#import <UIKit/UIKit.h>
#import "ClockView.h"
#import "UIColor+HexString.h"

@implementation ClockView {
  UIColor * _color;
  CGFloat _angle;
}


- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextClearRect(context, self.bounds);

  CGFloat cx = rect.size.width / 2;
  CGFloat cy = rect.size.height / 2;

  // DEBUG
  
  [[UIColor brownColor] set];
  CGContextSetLineWidth(context, 1.0f);
  CGContextMoveToPoint(context, 0, cx);
  CGContextAddLineToPoint(context, cx * 2, cx);
  CGContextStrokePath(context);

  [[UIColor redColor] set];
  CGContextSetLineWidth(context, 1.0f);
  CGContextMoveToPoint(context, cx, 0);
  CGContextAddLineToPoint(context, cx, cx * 2);
  CGContextStrokePath(context);

  [_color setFill];
  [[UIColor redColor] setStroke];
  
  // draw ticks
  
  for (int i = 0; i < 60; i++) {
    CGFloat angle = M_PI * 2 / 60 * i;
    CGFloat r = cx * 0.8;
    
    CGFloat w = cx * (i % 5 == 0 ? 0.2 : 0.1);
    CGFloat h = w * (i % 5 == 0 ? 0.2 : 0.1);;
    
    CGFloat x = cx + cos(angle) * r;
    CGFloat y = cy + sin(angle) * r;
    
    CGRect tick = CGRectMake(- w / 2, - h / 2, w, h);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, x, y);
    CGContextRotateCTM(context, angle);
    
    CGContextFillRect(context, tick);
    CGContextStrokeRect(context, tick);
    
    CGContextRestoreGState(context);
  }
  
  // draw minutes
  
  CGFloat minuteWidth = cx * 1;
  CGFloat minuteHeight = minuteWidth * 0.1;
  CGRect rectangle = CGRectMake(
                                - minuteWidth * 0.15,
                                - minuteHeight / 2,
                                minuteWidth,
                                minuteHeight
                                );
  
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, cx, cy);
  CGContextRotateCTM(context, _angle);
  
  CGContextFillRect(context, rectangle);
  
  CGContextRestoreGState(context);

  // draw hours
  
  [[UIColor purpleColor] setFill];
  [[UIColor redColor] setStroke];
  
  CGFloat hourWidth = cx * 0.8;
  CGFloat hourHeight = minuteWidth * 0.1;
  CGRect hourRectangle = CGRectMake(
                                - hourWidth * 0.15,
                                - hourHeight / 2,
                                hourWidth,
                                hourHeight
                                );
  
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, cx, cy);
  CGContextRotateCTM(context, _angle + 0.53);
  
  CGContextFillRect(context, hourRectangle);
  
  CGContextRestoreGState(context);
  
  // draw seconds
  
  [[UIColor yellowColor] setFill];
  
  CGFloat secondsWidth = cx * 0.8;
  CGFloat secondsHeight = minuteWidth * 0.03;
  CGRect secondsRectangle = CGRectMake(
                                    - secondsWidth * 0.15,
                                    - secondsHeight / 2,
                                    secondsWidth,
                                    secondsHeight
                                    );
  
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, cx, cy);
  CGContextRotateCTM(context, _angle + 1.53);
  
  CGContextFillRect(context, secondsRectangle);
  
  CGContextRestoreGState(context);
  
  // DEBUG
  
  CGContextSetLineWidth(context,5);
  CGContextSetRGBStrokeColor(context,0.8,0.8,0.8,1.0);
  CGContextAddArc(context,cx,cy,30,0.0,M_PI*2,YES);
  CGContextStrokePath(context);
}

- (void)setColor:(NSString *) colorString {
  _color = [UIColor colorWithHexString:colorString];
  [self setNeedsDisplay];
}

- (void)setAngle:(int) angle {
  _angle = M_PI / 180 * angle;
  [self setNeedsDisplay];
}

@end
