#import <UIKit/UIKit.h>
#import "ClockView.h"
#import "UIColor+HexString.h"

@implementation ClockView {
  UIColor * _color;
  CGFloat _secondsAngle;
  CGFloat _minuteAngle;
  CGFloat _hourAngle;
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.opaque = NO;
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextClearRect(context, rect);

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
    CGFloat h = w * (i % 5 == 0 ? 0.2 : 0.1);
        
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
  CGContextRotateCTM(context, _minuteAngle);
  
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
  CGContextRotateCTM(context, _hourAngle);
  
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
  CGContextRotateCTM(context, _secondsAngle);
  
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

- (void)setSeconds:(int) seconds {
  // every second is one 60th of a circle
  CGFloat angle = 360 / 60 * seconds;
  // remove 180 degrees to start at -90
  angle -= 90;
  
  _secondsAngle = M_PI / 180 * angle;
  
  [self setNeedsDisplay];
}

- (void)setMinute:(int) minute {
  // every minute is one 60th of a circle
  CGFloat angle = 360 / 60 * minute;
  // remove 180 degrees to start at -90
  angle -= 90;
  
  _minuteAngle = M_PI / 180 * angle;
  
  [self setNeedsDisplay];
}

- (void)setHour:(int) hour {
  // every hour is one 12th of a circle
  CGFloat angle = 360 / 12 * hour;
  // remove 180 degrees to start at -90
  angle -= 90;
  
  _hourAngle = M_PI / 180 * angle;
  
  [self setNeedsDisplay];
}

@end
