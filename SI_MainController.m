//
//  SI_MainController.m
//  Set Icon
//
//  Created by Alex on 23/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "SI_MainController.h"

@implementation SI_MainController

- (void)awakeFromNib
{
	[theWindow center];
	
	NSPoint drivePoint = NSMakePoint(NSMaxX([drivePath frame]), NSMidY([drivePath frame]));
	driveWindow = [[MAAttachedWindow alloc] initWithView:driveView attachedToPoint:drivePoint inWindow:theWindow onSide:2 atDistance:10];
	[driveWindow setViewMargin:10];
	[driveWindow setHasShadow:FALSE];
	[theWindow addChildWindow:driveWindow ordered:NSWindowAbove];
	
	NSPoint iconPoint = NSMakePoint(NSMaxX([theIcon frame]), NSMidY([theIcon frame]));
	iconWindow = [[MAAttachedWindow alloc] initWithView:iconView attachedToPoint:iconPoint inWindow:theWindow onSide:2 atDistance:10];
	[iconWindow setViewMargin:8];
	[iconWindow setHasShadow:FALSE];
	[theWindow addChildWindow:iconWindow ordered:NSWindowAbove];
	
	NSPoint buttonPoint = NSMakePoint(NSMaxX([setIconButton frame]), NSMidY([setIconButton frame]));
	buttonWindow = [[MAAttachedWindow alloc] initWithView:buttonView attachedToPoint:buttonPoint inWindow:theWindow onSide:2 atDistance:10];
	[buttonWindow setViewMargin:10];
	[buttonWindow setHasShadow:FALSE];
	[theWindow addChildWindow:buttonWindow ordered:NSWindowAbove];
}

- (IBAction)setIcon:(id)sender
{
	if (![theIcon imagePath])
	{
		NSAlert *alert = [[[NSAlert alloc] init] autorelease];
		[alert addButtonWithTitle:@"OK"];
		[alert setMessageText:@"No icon selected!"];
		[alert setInformativeText:@"Please select an icon to apply to the drive by dragging it into the box."];
		[alert setAlertStyle:NSCriticalAlertStyle];
		[alert beginSheetModalForWindow:theWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
	} else {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		[fileManager authenticate];
		[fileManager deletePathWithAuthentication:[NSString stringWithFormat:@"%@/.VolumeIcon.icns", [[drivePath URL] relativePath]]];
		[fileManager copyPathWithAuthentication:[theIcon imagePath] toPath:[NSString stringWithFormat:@"%@/.VolumeIcon.icns", [[drivePath URL] relativePath]]];
		[fileManager setDriveIconWithAuthentication:[[drivePath URL] relativePath]];
		
		NSTask *task;
		task = [[NSTask alloc] init];
		[task setLaunchPath: @"/usr/bin/killall"];
		
		NSArray *arguments;
		arguments = [NSArray arrayWithObjects: @"Finder", nil];
		[task setArguments: arguments];

		NSPipe *pipe;
		pipe = [NSPipe pipe];
		[task setStandardOutput: pipe];
	
		[task launch];
	}
}

- (void)dealloc
{
	[theWindow release];
	[drivePath release];
    [theIcon release];
	[setIconButton release];
	[driveView release];
	[iconView release];
	[buttonView release];
    [driveWindow release];
	[iconWindow release];
	[buttonWindow release];
	
	[super dealloc];
}

@end
