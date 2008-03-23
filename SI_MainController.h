//
//  SI_MainController.h
//  Set Icon
//
//  Created by Alex on 23/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DPImageView.h"

@interface SI_MainController : NSObject
{
	IBOutlet NSWindow *theWindow;
	IBOutlet NSPathControl *drivePath;
    IBOutlet DPImageView *theIcon;
	IBOutlet NSButton *setIconButton;
}

- (IBAction)setIcon:(id)sender;

@end
