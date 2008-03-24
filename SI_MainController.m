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

@end
