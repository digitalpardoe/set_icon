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
	defaults = [NSUserDefaults standardUserDefaults];
	showToolTips = [defaults boolForKey:@"ShowToolTips"];
	
	[theWindow center];
	
	if (showToolTips == TRUE)
	{
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
		
		NSPoint windowPoint = NSMakePoint(NSMidX([setIconButton frame]), NSMaxY([setIconButton frame]));
		mainWindow = [[MAAttachedWindow alloc] initWithView:windowView attachedToPoint:windowPoint inWindow:theWindow onSide:1 atDistance:50];
		[mainWindow setViewMargin:10];
		[mainWindow setHasShadow:FALSE];
		[theWindow addChildWindow:mainWindow ordered:NSWindowAbove];
	}
	
	[theWindow makeKeyAndOrderFront:self];
}

- (IBAction)setIcon:(id)sender
{
	BOOL isDir, fail;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	[fileManager fileExistsAtPath:[[drivePath URL] relativePath] isDirectory:&isDir];
	fail = NO;
	
	if(!isDir)
	{
		NSAlert *alert = [[[NSAlert alloc] init] autorelease];
		[alert addButtonWithTitle:@"OK"];
		[alert setMessageText:@"No drive selected!"];
		[alert setInformativeText:@"Please select a drive to apply the icon to by dragging it to the bar or using the arrows at the end of the bar."];
		[alert setAlertStyle:NSCriticalAlertStyle];
		[alert beginSheetModalForWindow:theWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
		fail = YES;
	}
	
	if (![theIcon imagePath])
	{
		NSAlert *alert = [[[NSAlert alloc] init] autorelease];
		[alert addButtonWithTitle:@"OK"];
		[alert setMessageText:@"No icon selected!"];
		[alert setInformativeText:@"Please select an icon to apply to the drive by dragging it into the box."];
		[alert setAlertStyle:NSCriticalAlertStyle];
		[alert beginSheetModalForWindow:theWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
		fail = YES;
	}
	
	if(!fail)
	{
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
	[windowView release];
    [driveWindow release];
	[iconWindow release];
	[buttonWindow release];
	[mainWindow release];
	
	[defaults release];
	
	[super dealloc];
}

@end
