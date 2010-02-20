//
//  SI_UpdatePrefController.h
//  Set Icon
//
//	See 'LICENSE' for copyright and licensing.
//

#import <Cocoa/Cocoa.h>
#import "SS_PreferencePaneProtocol.h"

@interface SI_UpdatePrefController : NSObject <SS_PreferencePaneProtocol>
{
    IBOutlet NSView *prefsView;
}

@end
