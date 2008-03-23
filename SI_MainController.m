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
	NSLog(@"%@", [[drivePath URL] relativePath]);
	NSLog(@"%@", [theIcon image]);
}

@end
