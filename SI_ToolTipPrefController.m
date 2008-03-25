//
//  SI_ToolTipPrefController
//  Set Icon
//
//  Created by Alex on 25/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "SI_ToolTipPrefController.h"

@implementation SI_ToolTipPrefController

+ (NSArray *)preferencePanes
{
    return [NSArray arrayWithObjects:[[[SI_ToolTipPrefController alloc] init] autorelease], nil];
}


- (NSView *)paneView
{
    BOOL loaded = YES;
    
    if (!prefsView) {
        loaded = [NSBundle loadNibNamed:@"SI_ToolTipsView" owner:self];
    }
    
    if (loaded) {
        return prefsView;
    }
    
    return nil;
}


- (NSString *)paneName
{
    return @"Tool Tips";
}


- (NSImage *)paneIcon
{
    return [[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"SI_ToolTipIcon"]] autorelease];
}


- (NSString *)paneToolTip
{
    return @"Tool Tip Preferences";
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
