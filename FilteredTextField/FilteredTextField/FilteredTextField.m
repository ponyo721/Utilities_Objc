//
//  FilteredTextField.m
//  FilteredTextField
//
//  Created by 박병호 on 6/16/24.
//

#import "FilteredTextField.h"

@implementation FilteredTextField

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)textDidChange:(NSNotification *)notification{
    NSLog(@"textDidChange");
    
    NSString *replaceStr = [self getFilteredText:self.stringValue];
    
    [self setStringValue:replaceStr];
}

#pragma mark - private -

- (NSString *)getFilteredText:(NSString *)text{
    
    NSString *resultString = [self.regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    
    return resultString;
}

- (NSInteger)getMatchCountWithRegexPattern:(NSString *)pattern text:(NSString *)text{
    
    NSArray<NSTextCheckingResult *> *matches = [self.regex matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    
    return matches.count;
}



@end
