//
//  SystemThemeChangeDetecter.h
//  SystemThemeChangeDetecter
//
//  Created by 박병호 on 6/16/24.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SystemThemeChangeDetecterDelegate <NSObject>

- (void)systemThemeDidChanged:(BOOL)isDark;

@end

@interface SystemThemeChangeDetecter : NSObject
@property (nonatomic) id<SystemThemeChangeDetecterDelegate> delegate;

- (void)startObserving;
- (void)stopObserving;
@end

NS_ASSUME_NONNULL_END
