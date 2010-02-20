//
//  SI_ChangeLogController.m
//  Set Icon
//
//	See 'LICENSE' for copyright and licensing.
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
