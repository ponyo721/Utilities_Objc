//
//  AppDelegate.m
//  NSSliderCell+CustomColor
//
//  Created by 박병호 on 6/16/24.
//

#import "AppDelegate.h"
#import "CustomColorSliderCell.h"

@interface AppDelegate () <NSWindowDelegate>

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self.window setLevel:NSModalPanelWindowLevel];
    
    CustomColorSliderCell *customColorSliderCell = [[CustomColorSliderCell alloc] init];
    [customColorSliderCell setMinValue:0];
    [customColorSliderCell setMaxValue:100];
    [customColorSliderCell setNumberOfTickMarks:5];
    [customColorSliderCell setVertical:NO];
    [customColorSliderCell setSliderColor:[NSColor yellowColor]];
    [customColorSliderCell setTickMarkColor:[NSColor redColor]];

    NSSlider *newSlider = [[NSSlider alloc] initWithFrame:NSMakeRect(0, 0, 400, 50)];
    [newSlider setCell:customColorSliderCell];
    
    CGFloat x = (self.window.frame.size.width - newSlider.frame.size.width) / 2;
    CGFloat y = (self.window.frame.size.height - newSlider.frame.size.height) / 2;
    [newSlider setFrameOrigin:NSMakePoint(x, y)];
    
    
    [self.window.contentView addSubview:newSlider];
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
