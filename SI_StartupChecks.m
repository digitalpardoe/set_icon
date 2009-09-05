//
//  SI_StartupChecks.m
//  Set Icon
//
//  Created by Alex on 25/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "SI_StartupChecks.h"

@implementation SI_StartupChecks

- (id)init
{
	[self _updateCheck];
	[self _donateCheck];
	
	return nil;
}

- (void)_updateCheck
{
	NSNumber *updateChecking = [[NSUserDefaults standardUserDefaults] objectForKey:@"SUCheckAtStartup"];
	if (!updateChecking) {
		updateChecking = [NSNumber numberWithBool:NSRunAlertPanel(NSLocalizedString(@"Check for updates on startup?", nil), [NSString stringWithFormat:NSLocalizedString(@"Would you like Set Icon to check for updates on startup? If not, you can initiate the check manually from the application menu.", nil)], NSLocalizedString(@"Yes", nil), NSLocalizedString(@"No", nil), nil) == NSAlertDefaultReturn];
		[[NSUserDefaults standardUserDefaults] setObject:updateChecking forKey:@"SUCheckAtStartup"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

- (void)_donateCheck
{
	NSNumber *donateChecking = [[NSUserDefaults standardUserDefaults] objectForKey:@"Donation"];
	if (!donateChecking) {
		donateChecking = [NSNumber numberWithBool:NSRunAlertPanel(NSLocalizedString(@"Would you like to donate?", nil), [NSString stringWithFormat:NSLocalizedString(@"If you like this application please consider making a donation, you can also make a donation from the application menu.", nil)], NSLocalizedString(@"Donate", nil), NSLocalizedString(@"Not Now", nil), nil) == NSAlertDefaultReturn];
		[[NSUserDefaults standardUserDefaults] setObject:donateChecking forKey:@"Donation"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Donation"]) {
			[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=contact%40digitalpardoe%2eco%2euk&item_name=digital%3apardoe&no_shipping=1&no_note=1&tax=0&currency_code=GBP&lc=GB&bn=PP%2dDonationsBF&charset=UTF%2d8"]];
		}
	}
}

@end
