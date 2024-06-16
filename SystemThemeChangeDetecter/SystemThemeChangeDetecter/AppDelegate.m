//
//  AppDelegate.m
//  SystemThemeChangeDetecter
//
//  Created by 박병호 on 6/16/24.
//

#import "AppDelegate.h"
#import "SystemThemeChangeDetecter.h"

@interface AppDelegate () <NSWindowDelegate, SystemThemeChangeDetecterDelegate> {
    SystemThemeChangeDetecter *_sys_theme_detecter;
}

@property (strong) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *commonLabel;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self.window setLevel:NSModalPanelWindowLevel];
    
    _sys_theme_detecter = [[SystemThemeChangeDetecter alloc] init];
    [_sys_theme_detecter setDelegate:self];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

#pragma mark - ui action -

- (IBAction)actionOnOffObserverBtn:(id)sender {
    NSButton *btn = (NSButton*)sender;
    
    switch (btn.state) {
        case NSControlStateValueOn:
            NSLog(@"NSControlStateValueOn");
            [_sys_theme_detecter startObserving];
            break;
        case NSControlStateValueOff:
            NSLog(@"NSControlStateValueOff");
            [_sys_theme_detecter stopObserving];
            break;
        default:
            NSLog(@"button state error");
            [_sys_theme_detecter stopObserving];
            break;
    }
}

#pragma mark - NSWindowDelegate -

- (void)windowWillClose:(NSNotification *)notification{
    [NSApp terminate:nil];
}

#pragma mark - SystemThemeChangeDetecterDelegate -

- (void)systemThemeDidChanged:(BOOL)isDark{
    if(isDark)
        [_commonLabel setStringValue:@"changed dark"];
    else
        [_commonLabel setStringValue:@"changed light"];
}

@end
