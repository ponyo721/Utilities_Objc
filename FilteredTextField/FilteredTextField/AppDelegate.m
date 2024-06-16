//
//  AppDelegate.m
//  FilteredTextField
//
//  Created by 박병호 on 6/16/24.
//

#import "AppDelegate.h"
#import "FilteredTextField.h"

@interface AppDelegate () <NSWindowDelegate> {
    FilteredTextField *_text_field;
}

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self.window setLevel:NSModalPanelWindowLevel];
    
    _text_field = [[FilteredTextField alloc] initWithFrame:NSMakeRect(0, 0, 400, 50)];
    NSString *pattern = @"[\\p{Emoji}\\p{Emoji_Presentation}\\\\/:?*<>|&%+;\"']";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    [_text_field setRegex:regex];
    
    CGFloat x = (self.window.frame.size.width - _text_field.frame.size.width) / 2;
    CGFloat y = (self.window.frame.size.height - _text_field.frame.size.height) / 2;
    [_text_field setFrameOrigin:NSMakePoint(x, y)];
    
    
    [self.window.contentView addSubview:_text_field];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

#pragma mark - NSWindowDelegate -

- (void)windowWillClose:(NSNotification *)notification{
    [NSApp terminate:nil];
}


@end
