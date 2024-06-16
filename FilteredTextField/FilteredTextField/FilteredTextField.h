//
//  FilteredTextField.h
//  FilteredTextField
//
//  Created by 박병호 on 6/16/24.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilteredTextField : NSTextField
@property (nonatomic) NSRegularExpression *regex;
@end

NS_ASSUME_NONNULL_END
