//
//  SI_ApplicationController.m
//  Set Icon
//
//  Created by Alex on 23/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "SI_ApplicationController.h"


@implementation SI_ApplicationController

- (void)awakeFromNib {
	[NSApp activateIgnoringOtherApps:YES];
	SI_WindowController *mainWindow = [[SI_WindowController alloc] initWithWindowNibName:@"SI_Main"];
	[[mainWindow document] setTitle:@"String"];
	[mainWindow showWindow:self];
}

@end
