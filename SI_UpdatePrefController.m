//
//  SI_UpdatePrefController.m
//  Set Icon
//
//  Created by Alex on 25/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "SI_UpdatePrefController.h"

@implementation SI_UpdatePrefController

+ (NSArray *)preferencePanes
{
    return [NSArray arrayWithObjects:[[[SI_UpdatePrefController alloc] init] autorelease], nil];
}


- (NSView *)paneView
{
    BOOL loaded = YES;
    
    if (!prefsView) {
        loaded = [NSBundle loadNibNamed:@"SI_UpdatesView" owner:self];
    }
    
    if (loaded) {
        return prefsView;
    }
    
    return nil;
}


- (NSString *)paneName
{
    return @"Updates";
}


- (NSImage *)paneIcon
{
    return [[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"SI_UpdateIcon"]] autorelease];
}


- (NSString *)paneToolTip
{
    return @"Update Preferences";
}


- (BOOL)allowsHorizontalResizing
{
    return NO;
}


- (BOOL)allowsVerticalResizing
{
    return NO;
}

@end
