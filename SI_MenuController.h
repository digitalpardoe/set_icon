//
//  SI_ApplicationController.h
//  Set Icon
//
//  Created by Alex on 23/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SI_WindowController.h"
#import "SI_StartupChecks.h"
#import "SS_PrefsController.h"

@interface SI_MenuController : NSObject
{
	SS_PrefsController *prefs;
}

- (IBAction)preferences:(id)sender;
- (IBAction)donate:(id)sender;

@end
