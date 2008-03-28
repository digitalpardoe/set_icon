//
//  SI_ChangeLogController.m
//  Set Icon
//
//  Created by Alex on 28/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "SI_ChangeLogController.h"

@implementation SI_ChangeLogController

- (void)awakeFromNib
{
	[window center];
	
	NSBundle * myMainBundle = [NSBundle mainBundle];
	NSString * rtfFilePath = [myMainBundle pathForResource:@"ChangeLog" ofType:@"rtf"];
	[textView readRTFDFromFile:rtfFilePath];
}

- (void)dealloc
{
	[window release];
	[textView release];
	[super dealloc];
}

@end
