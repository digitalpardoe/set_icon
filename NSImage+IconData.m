// ================================================================
// Copyright (C) 2007 Google Inc.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//      http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ================================================================
//
//  NSImage+IconData.m
//  MacFUSE
//
//  Created by ted on 12/28/07.
//
//  Now with extra bits nicked Matt Gemmel's NSImage+MGCropExtensions
//  for nicer image resizing, we don't want stretched images.
//
//  Modified by Alex Pardoe on 06/10/09.
//
#import <AppKit/AppKit.h>
#import <CoreServices/CoreServices.h>
#import <Accelerate/Accelerate.h>
#import "NSImage+IconData.h"

@implementation NSImage (IconData)

- (NSData *)icnsDataWithWidth:(int)width {
	SInt32 version;
	Gestalt(gestaltSystemVersionMinor, &version);
	
	OSType icnsType;
	switch (width) {
		case 128:
			icnsType = 'ic07';  // kIconServices128PixelDataARGB
			break;
		case 256:
			icnsType = kIconServices256PixelDataARGB;
			break;
		case 512:
			icnsType = 'ic09';  // kIconServices512PixelDataARGB
			break;
			
		default:
			NSLog(@"Invalid icon width: %d", width);
			return nil;      
	}
	
	// Call code by Matt Gemmel to scale rather than stretch the image.
	self = [self imageToFitSize:NSMakeSize(width, width)];
	
	// See Cocoa Drawing Guide > Images > Creating a Bitmap
	// Also see IconStorage.h in OSServices.Framework in CoreServices umbrella.
	NSRect rect = NSMakeRect(0, 0, width, width);
	size_t bitmapSize = 4 * rect.size.width * rect.size.height;
	Handle bitmapHandle = NewHandle(bitmapSize);
	unsigned char* bitmapData = (unsigned char *)*bitmapHandle;
	NSBitmapFormat format = NSAlphaFirstBitmapFormat;
	
	if (version < 5) {
		format |= NSAlphaNonpremultipliedBitmapFormat;
	}
	
	NSBitmapImageRep* rep = 
	[[[NSBitmapImageRep alloc] 
	  initWithBitmapDataPlanes:&bitmapData  // Single plane; just our bitmapData
	  pixelsWide:rect.size.width
	  pixelsHigh:rect.size.height
	  bitsPerSample:8 
	  samplesPerPixel:4  // ARGB
	  hasAlpha:YES 
	  isPlanar:NO 
	  colorSpaceName:NSCalibratedRGBColorSpace 
	  bitmapFormat:format
	  bytesPerRow:0  // Let it compute bytesPerRow and bitsPerPixel
	  bitsPerPixel:0] autorelease];
	
	[NSGraphicsContext saveGraphicsState];
	NSGraphicsContext* context = [NSGraphicsContext graphicsContextWithBitmapImageRep:rep];
	[NSGraphicsContext setCurrentContext:context];
	NSImageInterpolation interpolation = [context imageInterpolation];
	[context setImageInterpolation:NSImageInterpolationHigh];
	[self drawInRect:rect fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
	[context setImageInterpolation:interpolation];
	[NSGraphicsContext restoreGraphicsState];
	
	// On Tiger, the above actually returns RGBA data. Probably a bug in Tiger?
	// We use vImage to permute from RGBA -> ARGB in place on the data buffer.
	if (version == 4) {
		vImage_Buffer src;
		src.data = bitmapData;
		src.height = rect.size.height;
		src.width = rect.size.width;
		src.rowBytes = [rep bytesPerRow];
		vImage_Buffer dst = src;  // We'll just overwrite our bitmap data.
		uint8_t permuteMap[] = { 3, 0, 1, 2 };  // Used to go from RGBA -> ARGB
		vImagePermuteChannels_ARGB8888(&src, &dst, permuteMap, kvImageDoNotTile);
	}
	
	// We need to use SetIconFamilyData here rather than just setting the raw
	// bytes because icon family will compress the bitmap for us using RLE. This
	// is described in http://ezix.org/project/wiki/MacOSXIcons
	Handle familyHandle = NewHandle(0);
	SetIconFamilyData((IconFamilyHandle)familyHandle, icnsType, bitmapHandle);
	DisposeHandle(bitmapHandle);
	NSData* data = [NSData dataWithBytes:*familyHandle length:GetHandleSize(familyHandle)];
	DisposeHandle(familyHandle);
	return data;
}

// Code from NSImage+MGCropExtension by Matt Gemmell.
- (void)drawInRect:(NSRect)dstRect operation:(NSCompositingOperation)op fraction:(float)delta
{
	float sourceWidth = [self size].width;
	float sourceHeight = [self size].height;
	float targetWidth = dstRect.size.width;
	float targetHeight = dstRect.size.height;
	BOOL cropping = NO;
	
	// Calculate aspect ratios
	float sourceRatio = sourceWidth / sourceHeight;
	float targetRatio = targetWidth / targetHeight;
	
	// Determine what side of the source image to use for proportional scaling
	BOOL scaleWidth = (sourceRatio <= targetRatio);
	// Deal with the case of just scaling proportionally to fit, without cropping
	scaleWidth = (cropping) ? scaleWidth : !scaleWidth;
	
	// Proportionally scale source image
	float scalingFactor, scaledWidth, scaledHeight;
	if (scaleWidth) {
		scalingFactor = 1.0 / sourceRatio;
		scaledWidth = targetWidth;
		scaledHeight = round(targetWidth * scalingFactor);
	} else {
		scalingFactor = sourceRatio;
		scaledWidth = round(targetHeight * scalingFactor);
		scaledHeight = targetHeight;
	}
	
	// Calculate compositing rectangles
	NSRect sourceRect;
	
	sourceRect = NSMakeRect(0, 0, sourceWidth, sourceHeight);
	dstRect.origin.x += (targetWidth - scaledWidth) / 2.0;
	dstRect.origin.y += (targetHeight - scaledHeight) / 2.0;
	dstRect.size.width = scaledWidth;
	dstRect.size.height = scaledHeight;
	
	[self drawInRect:dstRect fromRect:sourceRect operation:op fraction:delta];
}

- (NSImage *)imageToFitSize:(NSSize)size
{
    NSImage *result = [[NSImage alloc] initWithSize:size];
    
    // Composite image appropriately
    [result lockFocus];
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
	[self drawInRect:NSMakeRect(0,0,size.width,size.height) operation:NSCompositeSourceOver fraction:1.0];
    [result unlockFocus];
    
    return [result autorelease];
}

@end
