//
//  SI_MainController.h
//  Set Icon
//
//  Created by Alex on 23/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DPImageView.h"
#import "DPAuthFileManager.h"
#import "NSImage+IconData.h"

@interface SI_MainController : NSObject
{
	IBOutlet NSWindow *theWindow;
	IBOutlet NSPathControl *drivePath;
    IBOutlet DPImageView *theIcon;
	IBOutlet NSButton *setIconButton;
	
	NSUserDefaults *defaults;
	BOOL removeIcon;
	
	NSImage* theImage;
}

- (IBAction)setIcon:(id)sender;
- (IBAction)removeCustomIcon:(id)sender;

@end
