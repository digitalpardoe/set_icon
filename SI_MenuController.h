//
//  SI_ApplicationController.h
//  Set Icon
//
//	See 'LICENSE' for copyright and licensing.
//

#import <Cocoa/Cocoa.h>
#import "SI_WindowController.h"
#import "SI_StartupChecks.h"
#import "SS_PrefsController.h"

@interface SI_MenuController : NSObject
{
	SI_WindowController *mainWindow;
	SI_WindowController *changeLogWindow;
	SS_PrefsController *prefs;
}

- (IBAction)preferences:(id)sender;
- (IBAction)donate:(id)sender;
- (IBAction)changeLog:(id)sender;

@end
