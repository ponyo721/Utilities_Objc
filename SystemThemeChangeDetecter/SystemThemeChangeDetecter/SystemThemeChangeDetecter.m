//
//  SystemThemeChangeDetecter.m
//  SystemThemeChangeDetecter
//
//  Created by 박병호 on 6/16/24.
//

#import "SystemThemeChangeDetecter.h"

#define SYS_THEME_CHAGE_NOTI_NAME @"AppleInterfaceThemeChangedNotification"

@interface SystemThemeChangeDetecter (){
    id _sys_theme_observer;
}

@end

@implementation SystemThemeChangeDetecter

#pragma mark - public -
- (void)startObserving{
    NSLog(@"[SystemThemeChangeDetecter] startObserving");
    
    [self observeThemeChange];
}

- (void)stopObserving{
    NSLog(@"[SystemThemeChangeDetecter] stopObserving");
    
    if (_sys_theme_observer != nil){
        [[NSDistributedNotificationCenter defaultCenter] removeObserver:_sys_theme_observer name:SYS_THEME_CHAGE_NOTI_NAME object:nil];
        _sys_theme_observer = nil;
    }
}

#pragma mark - private -

- (void)observeThemeChange {
    if(_sys_theme_observer == nil)
        _sys_theme_observer = [[NSDistributedNotificationCenter defaultCenter] addObserverForName:SYS_THEME_CHAGE_NOTI_NAME
                                                                     object:nil
                                                                      queue:nil
                                                                 usingBlock:^(NSNotification * _Nonnull note) {
            [self updateUIColor];
        }];
}

-(void)updateUIColor{
    NSString *appearanceName = [[NSApp effectiveAppearance] name];
    if([appearanceName.lowercaseString containsString:@"dark"])
        [self.delegate systemThemeDidChanged:YES];
    else
        [self.delegate systemThemeDidChanged:NO];
}

@end
