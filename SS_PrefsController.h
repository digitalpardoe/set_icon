//
// SS_PrefsController.h
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

@interface SS_PrefsController : NSObject
{
    NSWindow *prefsWindow;
    NSMutableDictionary *preferencePanes;
    NSMutableArray *panesOrder;

    NSString *bundleExtension;
    NSString *searchPath;
    
    NSToolbar *prefsToolbar;
    NSMutableDictionary *prefsToolbarItems;

    NSToolbarDisplayMode toolbarDisplayMode;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
    NSToolbarSizeMode toolbarSizeMode;
#endif
    BOOL usesTexturedWindow;
    BOOL alwaysShowsToolbar;
    BOOL alwaysOpensCentered;
    
    BOOL debug;
}

// Convenience constructors
+ (id)preferencesWithPanesSearchPath:(NSString*)path bundleExtension:(NSString *)ext;
+ (id)preferencesWithBundleExtension:(NSString *)ext;
+ (id)preferencesWithPanesSearchPath:(NSString*)path;
+ (id)preferences;

// Designated initializer
- (id)initWithPanesSearchPath:(NSString*)path bundleExtension:(NSString *)ext;

- (id)initWithBundleExtension:(NSString *)ext;
- (id)initWithPanesSearchPath:(NSString*)path;

- (void)showPreferencesWindow;
- (void)createPreferencesWindowAndDisplay:(BOOL)shouldDisplay;
- (void)createPreferencesWindow;
- (void)destroyPreferencesWindow;
- (BOOL)loadPrefsPaneNamed:(NSString *)name display:(BOOL)disp;
- (BOOL)loadPreferencePaneNamed:(NSString *)name;
- (void)activatePane:(NSString*)path;
- (void)debugLog:(NSString*)msg;

float ToolbarHeightForWindow(NSWindow *window);
- (void)createPrefsToolbar;
- (void)prefsToolbarItemClicked:(NSToolbarItem*)item;

// Accessors
- (NSWindow *)preferencesWindow;
- (NSString *)bundleExtension;
- (NSString *)searchPath;

- (NSArray *)loadedPanes;
- (NSArray *)panesOrder;
- (void)setPanesOrder:(NSArray *)newPanesOrder;
- (BOOL)debug;
- (void)setDebug:(BOOL)newDebug;
- (BOOL)usesTexturedWindow;
- (void)setUsesTexturedWindow:(BOOL)newUsesTexturedWindow;
- (BOOL)alwaysShowsToolbar;
- (void)setAlwaysShowsToolbar:(BOOL)newAlwaysShowsToolbar;
- (BOOL)alwaysOpensCentered;
- (void)setAlwaysOpensCentered:(BOOL)newAlwaysOpensCentered;
- (NSToolbarDisplayMode)toolbarDisplayMode;
- (void)setToolbarDisplayMode:(NSToolbarDisplayMode)displayMode;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (NSToolbarSizeMode)toolbarSizeMode;
- (void)setToolbarSizeMode:(NSToolbarSizeMode)sizeMode;
#endif

@end
