//
//  DPImageView.h
//  Set Icon
//
//	Created by Gregory Weston on 03/05/08.
//  Adapted by Alex on 23/03/2008.
//	From http://www.cocoadev.com/index.pl?NSImageView
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DPImageView : NSImageView
{
	AliasHandle mImageAlias;
	BOOL mDraggingFlag;
}

- (NSString*)imagePath;
- (NSURL*)imageURL;
- (AliasHandle)imageAlias;
- (BOOL)getImageRef:(FSRef*)outRef;

- (void)setImageFromPath:(NSString*)inPath;
- (void)setImageFromURL:(NSURL*)inURL;

@end
