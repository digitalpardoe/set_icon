//
//  SI_UpdatePrefController.h
//  Set Icon
//
//  Created by Alex on 25/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SS_PreferencePaneProtocol.h"

@interface SI_UpdatePrefController : NSObject <SS_PreferencePaneProtocol>
{
    IBOutlet NSView *prefsView;
}

@end
