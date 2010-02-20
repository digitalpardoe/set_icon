//
//  SI_MainController.h
//  Set Icon
//
//	See 'LICENSE' for copyright and licensing.
//

#import <Cocoa/Cocoa.h>
#import "DPImageView.h"
#import "DPAuthFileManager.h"
#import "NSImage+IconData.h"

@interface SI_MainController : NSObject
{
	IBOutlet NSWindow *theWindow;
	IBOutlet NSPathControl *drivePath;
    IBOutlet DPImageView *theIcon;
	IBOutlet NSButton *setIconButton;
	IBOutlet NSTextField *helpText;
	
	NSUserDefaults *defaults;
	BOOL removeIcon;
	
	NSImage* theImage;
}

- (IBAction)setIcon:(id)sender;
- (IBAction)removeCustomIcon:(id)sender;
- (IBAction)imageDropped:(id)sender;

@end
