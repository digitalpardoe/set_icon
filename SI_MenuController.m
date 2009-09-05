//
//  SI_ApplicationController.m
//  Set Icon
//
//  Created by Alex on 23/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "SI_MenuController.h"

@implementation SI_MenuController

- (void)awakeFromNib
{
	[[[SI_StartupChecks alloc] init] release];
	[NSApp activateIgnoringOtherApps:YES];
	mainWindow = [[SI_WindowController alloc] initWithWindowNibName:@"SI_Main"];
	[[mainWindow document] setTitle:@"Set Icon"];
	[mainWindow showWindow:self];
}

- (IBAction)preferences:(id)sender
{
	if (!prefs)
	{
		// Determine path to the sample preference panes
		NSString *pathToPanes = [NSString stringWithFormat:@"%@/../Preference Panes", [[NSBundle mainBundle] resourcePath]];
		
		prefs = [[SS_PrefsController alloc] initWithPanesSearchPath:pathToPanes];
		
		[prefs setAlwaysShowsToolbar:YES];
		[prefs setDebug:NO];
		
		[prefs setAlwaysOpensCentered:YES];
		
		[prefs setPanesOrder:[NSArray arrayWithObjects:@"Updates", nil]];
	}
    
	// Show the preferences window.
	[prefs showPreferencesWindow];
}

- (IBAction)donate:(id)sender
{
	[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=digital%2epardoe%40gmail%2ecom&item_name=digital%3apardoe%20Donation&no_shipping=1&return=http%3a%2f%2fdigitalpardoe%2eco%2euk%2f&cancel_return=http%3a%2f%2fdigitalpardoe%2eco%2euk%2f&no_note=1&tax=0&currency_code=GBP&lc=GB&bn=PP%2dDonationsBF&charset=UTF%2d8"]];
}

- (IBAction)changeLog:(id)sender
{
	changeLogWindow = [[SI_WindowController alloc] initWithWindowNibName:@"SI_ChangeLog"];
	[[changeLogWindow document] setTitle:@"Change Log"];
	[changeLogWindow showWindow:self];
}

- (void)dealloc
{
	[changeLogWindow release];
	[mainWindow release];
	[prefs release];
	[super dealloc];
}

@end
