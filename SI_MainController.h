//
//  SI_MainController.h
//  Set Icon
//
//  Created by Alex on 23/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DPImageView.h"
#import "DPFileManager.h"
#import "MAAttachedWindow.h"

@interface SI_MainController : NSObject
{
	IBOutlet NSWindow *theWindow;
	IBOutlet NSPathControl *drivePath;
    IBOutlet DPImageView *theIcon;
	IBOutlet NSButton *setIconButton;
	IBOutlet NSView *driveView;
	IBOutlet NSView *iconView;
	IBOutlet NSView *buttonView;
	IBOutlet NSView *windowView;
	
    MAAttachedWindow *driveWindow;
	MAAttachedWindow *iconWindow;
	MAAttachedWindow *buttonWindow;
	MAAttachedWindow *mainWindow;
	
	NSUserDefaults *defaults;
	BOOL showToolTips;
	BOOL removeIcon;
}

- (IBAction)setIcon:(id)sender;
- (IBAction)removeCustomIcon:(id)sender;

@end
