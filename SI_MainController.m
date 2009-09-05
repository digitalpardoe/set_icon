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
	removeIcon = FALSE;
	
	defaults = [NSUserDefaults standardUserDefaults];
	
	[theWindow center];
	[drivePath setURL:[NSURL fileURLWithPath:@"/"]];
	
	[theWindow makeKeyAndOrderFront:self];
}

- (IBAction)setIcon:(id)sender
{
	BOOL isDir, fail;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	fail = NO;
	
	isDir = [fileManager isDrive:[[drivePath URL] relativePath]];
		
	if(!fail && !isDir)
	{
		NSAlert *alert = [[[NSAlert alloc] init] autorelease];
		[alert addButtonWithTitle:@"OK"];
		[alert setMessageText:@"No drive selected!"];
		[alert setInformativeText:@"Please select a drive to apply the icon to by dragging it onto the path bar or using the arrows at the end of the path bar."];
		[alert setAlertStyle:NSCriticalAlertStyle];
		[alert beginSheetModalForWindow:theWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
		
		fail = YES;
	}
	
	if (!fail && ![theIcon imagePath] && !removeIcon)
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
		
		if ([fileManager authorized])
		{
			if(removeIcon)
			{
				[fileManager deletePathWithAuthentication:[NSString stringWithFormat:@"%@/.VolumeIcon.icns", [[drivePath URL] relativePath]]];
			} else {
				theImage = [[[NSImage alloc] initWithContentsOfURL:[theIcon imageURL]] autorelease];
				[[theImage icnsDataWithWidth:512] writeToFile:@"/tmp/seticon_temp.icns" atomically:NO];
		
				[fileManager deletePathWithAuthentication:[NSString stringWithFormat:@"%@/.VolumeIcon.icns", [[drivePath URL] relativePath]]];
				[fileManager copyPathWithAuthentication:@"/tmp/seticon_temp.icns" toPath:[NSString stringWithFormat:@"%@/.VolumeIcon.icns", [[drivePath URL] relativePath]]];
				[fileManager setDriveIconWithAuthentication:[[drivePath URL] relativePath]];
				
				[fileManager deletePathWithAuthentication:[NSString stringWithFormat:@"/tmp/seticon_temp.icns"]];
			}
			
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
			[task release];
		}
	}
}

- (IBAction)removeCustomIcon:(id)sender
{
	if ([[setIconButton title] isEqualToString:@"Set Icon"])
	{
		[setIconButton setTitle:@"Remove Icon"];
		removeIcon = TRUE;
	} else {
		[setIconButton setTitle:@"Set Icon"];
		removeIcon = FALSE;
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
	[defaults release];
	[theImage release];
	[super dealloc];
}

@end
