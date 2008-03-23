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
	SI_WindowController *mainWindow = [[SI_WindowController alloc] initWithWindowNibName:@"SI_Window"];
	[mainWindow showWindow:self];
}

- (void)centerWindow {
	NSRect visibleFrame = [[NSScreen mainScreen] visibleFrame];
	NSRect windowFrame = [self frame];
	[self setFrame:NSMakeRect((visibleFrame.size.width - windowFrame.size.width) * 0.5,
	(visibleFrame.size.height - windowFrame.size.height) * (9.0/10.0),
	windowFrame.size.width, windowFrame.size.height) display:YES];
}

@end
