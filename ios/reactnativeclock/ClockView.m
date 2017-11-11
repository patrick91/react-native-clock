#import <UIKit/UIKit.h>
#import "ClockView.h"
#import "UIColor+HexString.h"

@implementation ClockView {
  UIColor * _color;
}

- (void)drawRect:(CGRect)rect {
  NSLog(@"drawing!");
  CGContextRef context=UIGraphicsGetCurrentContext();
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, 50, 50);
  CGContextAddLineToPoint(context, 100, 120);
  CGContextAddLineToPoint(context, 20, 100);
  CGContextClosePath(context);
  
  [_color setFill];
  [[UIColor redColor] setStroke];
  
  CGContextDrawPath(context,kCGPathFillStroke);
}

- (void)setColor:(NSString *) colorString {
  _color = [UIColor colorWithHexString:colorString];
//  UIColor *color = UIColor.colorWithHexString(colorString);
  [self setNeedsDisplay];
}

@end
