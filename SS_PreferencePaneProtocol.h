//
// SS_PreferencePaneProtocol.m
// SS_PrefsController
//
// Source Code provided by Matt Gemmell.
// http://mattgemmell.com/source
//
// License Agreement for Source Code provided by Matt Gemmell
//
// This software is supplied to you by Matt Gemmell in consideration of your agreement to the
// following terms, and your use, installation, modification or redistribution of this software
// constitutes acceptance of these terms. If you do not agree with these terms, please do not
// use, install, modify or redistribute this software.
//
// In consideration of your agreement to abide by the following terms, and subject to these
// terms, Matt Gemmell grants you a personal, non-exclusive license, to use, reproduce, modify
// and redistribute the software, with or without modifications, in source and/or binary forms;
// provided that if you redistribute the software in its entirety and without modifications,
// you must retain this notice and the following text and disclaimers in all such redistributions
// of the software, and that in all cases attribution of Matt Gemmell as the original author of
// the source code shall be included in all such resulting software products or distributions.
//
// Neither the name, trademarks, service marks or logos of Matt Gemmell may be used to endorse or
// promote products derived from the software without specific prior written permission from Matt
// Gemmell. Except as expressly stated in this notice, no other rights or licenses, express or
// implied, are granted by Matt Gemmell herein, including but not limited to any patent rights that
// may be infringed by your derivative works or by other works in which the software may be
// incorporated.
//
// The software is provided by Matt Gemmell on an "AS IS" basis. MATT GEMMELL MAKES NO WARRANTIES,
// EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR ITS USE AND
// OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
//
// IN NO EVENT SHALL MATT GEMMELL BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
// MODIFICATION AND/OR DISTRIBUTION OF THE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF
// CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF MATT GEMMELL HAS
// BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <Cocoa/Cocoa.h>

@protocol SS_PreferencePaneProtocol


    //	preferencePanes is called whenever the calling application wants to instantiate preference panes.
    //	This method returns an array of preference pane instances. This array is autoreleased,
    //	so the calling application needs to retain whatever it wants to keep.
    //	If no instances were generated, this returns nil.

+ (NSArray *)preferencePanes;


    //	paneView returns a preference pane's view. This must not be nil.

- (NSView *)paneView;


    //	paneName returns the name associated with a preference pane's view.
    //	This is used as the label of the pane's toolbar item in the Preferences window,
    //	and as the title of the Preferences window when the pane is selected.
    //	This must not be nil or an empty string.

- (NSString *)paneName;


    //  paneIcon returns a preference pane's icon as an NSImage.
    //	The icon will be scaled to the default size for a toolbar icon (if necessary),
    //	and shown in the toolbar in the Preferences window.

- (NSImage *)paneIcon;


    //  paneToolTip returns the ToolTip to be used for a preference pane's icon in the
    //	Preferences window's toolbar. You can return nil or an empty string to disable
    //	the ToolTip for this preference pane.

- (NSString *)paneToolTip;


    //  allowsHorizontalResizing and allowsVerticalResizing determine whether the Preferences window
    //	will be resizable in the respective directions when the receiver is the visible preference
    //	pane. The initial size of the receiver's view will be used as the minimum size of the
    //	Preferences window.

- (BOOL)allowsHorizontalResizing;
- (BOOL)allowsVerticalResizing;


@end
