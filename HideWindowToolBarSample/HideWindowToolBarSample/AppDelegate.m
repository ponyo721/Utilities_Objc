//
//  AppDelegate.m
//  HideWindowToolBarSample
//
//  Created by 박병호 on 6/16/24.
//

#import "AppDelegate.h"

@interface AppDelegate () <NSWindowDelegate> {
    BOOL _is_hide_toolbar;
}

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    _is_hide_toolbar = NO;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

#pragma mark - NSWindowDelegate -

- (NSApplicationPresentationOptions)window:(NSWindow *)window willUseFullScreenPresentationOptions:(NSApplicationPresentationOptions)proposedOptions {
    
    NSLog(@"%lu", (unsigned long)proposedOptions);
    
    _is_hide_toolbar = _is_hide_toolbar?NO:YES;
    
    if(_is_hide_toolbar) // tool bar 가 자동 숨겨짐
        return NSApplicationPresentationAutoHideToolbar | NSApplicationPresentationAutoHideMenuBar | NSApplicationPresentationFullScreen;
    else // tool bar 가 유지 됨
        return NSApplicationPresentationAutoHideMenuBar | NSApplicationPresentationFullScreen;
    
}

#pragma mark - NSWindowDelegate -

- (void)windowWillClose:(NSNotification *)notification{
    [NSApp terminate:nil];
}

@end
