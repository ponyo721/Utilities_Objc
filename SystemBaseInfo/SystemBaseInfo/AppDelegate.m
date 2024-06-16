//
//  AppDelegate.m
//  SystemBaseInfo
//
//  Created by 박병호 on 6/16/24.
//

#import "AppDelegate.h"
#import "SystemBaseInfo.h"

@interface AppDelegate (){
    SystemBaseInfo *_sys_base_info;
}

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    _sys_base_info = [[SystemBaseInfo alloc] init];
    
    // cpu name
    NSLog(@"my cpu name : %@", [_sys_base_info getCPUBrandName]);
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}


@end
