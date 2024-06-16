//
//  CustomColorSliderCell.h
//  NSSliderCell+CustomColor
//
//  Created by 박병호 on 6/16/24.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomColorSliderCell : NSSliderCell
@property (nonatomic) NSColor *sliderColor;
@property (nonatomic) NSColor *tickMarkColor;
@end

NS_ASSUME_NONNULL_END
