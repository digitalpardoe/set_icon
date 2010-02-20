//
//  DPImageView.m
//  Set Icon
//
//	Created by Gregory Weston on 03/05/08.
//  Adapted by Alex Pardoe on 23/03/2008.
//	From http://www.cocoadev.com/index.pl?NSImageView
//
//	See 'LICENSE' for copyright and licensing.
//

#import "DPImageView.h"

@implementation DPImageView

- (void)cacheAliasFromURL:(NSURL*)inURL
{
	FSRef theRef = {};
	CFURLGetFSRef((CFURLRef)inURL, &theRef);
	OSErr theError = FSNewAlias(NULL, &theRef, &mImageAlias);
	if(theError != noErr) NSLog(@"FSNewAlias: %d", theError);
}

- (void)clearCachedAlias
{
	if(mImageAlias)
	{
		DisposeHandle((Handle)mImageAlias);
		mImageAlias = NULL;
	}
}

- (void)dealloc
{
	DisposeHandle((Handle)mImageAlias);
	[super dealloc];
}

- (void)setImage:(NSImage*)inImage
{
	if(mDraggingFlag == NO) [self clearCachedAlias];
	[super setImage:inImage];
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
	[self clearCachedAlias];
	
	NSPasteboard* thePasteboard = [sender draggingPasteboard];
	NSArray* theTypes = [thePasteboard types];
	if([theTypes containsObject:NSFilenamesPboardType])
	{
		NSArray* thePaths = [thePasteboard propertyListForType:NSFilenamesPboardType];
		NSString* thePath = [thePaths objectAtIndex:0];
		NSURL* theURL = [NSURL fileURLWithPath:thePath];
		[self cacheAliasFromURL:theURL];
	}
	
	mDraggingFlag = YES;
	[super concludeDragOperation:sender];
	mDraggingFlag = NO;
}

- (NSString*)imagePath
{
	NSString* theResult = nil;
	NSURL* theURL = [self imageURL];
	if(theURL && [theURL isFileURL])
	{
		theResult = [theURL path];
	}
	return theResult;
}

- (NSURL*)imageURL
{
	NSURL* theResult = nil;
	FSRef theRef = {};
	if([self getImageRef:&theRef])
	{
		CFURLRef theURL = CFURLCreateFromFSRef(kCFAllocatorDefault, &theRef);
		if(theURL)
		{
			theResult = [(NSURL*)theURL autorelease];
		}
	}
	return theResult;
}

- (AliasHandle)imageAlias
{
	return mImageAlias;
}

- (BOOL)getImageRef:(FSRef*)outRef
{
	BOOL theResult = NO;
	if(mImageAlias && outRef)
	{
		Boolean theChangeFlag = false;
		if(FSResolveAlias(NULL, mImageAlias, outRef, &theChangeFlag) == noErr)
		{
			theResult = YES;
		}
	}
	return theResult;
}

- (void)setImageFromPath:(NSString*)inPath
{
	if(inPath)
	{
		NSImage* theImage = [[NSImage alloc] initWithContentsOfFile:inPath];
		if(theImage)
		{
			[self setImage:theImage];
			[self clearCachedAlias];
			NSURL* theURL = [NSURL fileURLWithPath:inPath];
			[self cacheAliasFromURL:theURL];
		}
	}
}

- (void)setImageFromURL:(NSURL*)inURL
{
	if(inURL)
	{
		NSImage* theImage = [[NSImage alloc] initWithContentsOfURL:inURL];
		if(theImage)
		{
			[self setImage:theImage];
			[self clearCachedAlias];
			if([inURL isFileURL]) [self cacheAliasFromURL:inURL];
		}
	}
}

@end
