//
//  CustomColorSliderCell.m
//  NSSliderCell+CustomColor
//
//  Created by 박병호 on 6/16/24.
//

#import "CustomColorSliderCell.h"

@implementation CustomColorSliderCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sliderColor = [NSColor systemGrayColor];
        self.tickMarkColor = [NSColor systemGrayColor];
    }
    return self;
}

#pragma mark - Override -

- (void)drawKnob:(NSRect)knobRect {
    [super drawKnob:knobRect];
//    NSLog(@"[NSSliderCell] drawKnob");
}

- (void)drawBarInside:(NSRect)aRect flipped:(BOOL)flipped {
//    NSLog(@"[NSSliderCell] drawBarInside");
    
    // Calculate the filled part rect
    double value = (self.doubleValue - self.minValue) / (self.maxValue - self.minValue);
    NSRect fillRect = aRect;
    fillRect.size.width = fillRect.size.width * value;

    // Draw the filled part
    [self.sliderColor setFill];
    NSRectFill(fillRect);

    // Draw the remaining part
    [[NSColor lightGrayColor] setFill];
    NSRect remainingRect = aRect;
    remainingRect.origin.x += fillRect.size.width;
    remainingRect.size.width -= fillRect.size.width;
    NSRectFill(remainingRect);
}

- (void)drawTickMarks {
//    NSLog(@"[NSSliderCell] drawTickMarks");
    
    NSInteger numTickMarks = self.numberOfTickMarks;
    if (numTickMarks > 0) { // tick mark가 1개 이상 존재할 경우
        for (NSInteger i = 0; i < numTickMarks; i++) {
            double tickMarkValue = [self tickMarkValueAtIndex:i];   // 각 tick mark 의 value
            
            // Set color based on the tick mark value relative to the slider value
            if (tickMarkValue <= self.doubleValue) {
                [self.tickMarkColor setFill];
            } else {
                [[NSColor systemGrayColor] setFill];
            }
            
            NSRectFill([self rectOfTickMarkAtIndex:i]);
        }
    }
}

@end
