#import <UIKit/UIKit.h>
#import "ClockView.h"
#import "UIColor+HexString.h"

@implementation ClockView {
  UIColor * _secondsColor;
  UIColor * _minutesColor;
  UIColor * _hoursColor;
  CGFloat _secondsAngle;
  CGFloat _minutesAngle;
  CGFloat _hoursAngle;
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

  [_hoursColor setFill];
  
  // draw ticks
  
  for (int i = 0; i < 60; i++) {
    CGFloat angle = M_PI * 2 / 60 * i;
    CGFloat r = cx * 0.9;
    
    CGFloat w = cx * (i % 5 == 0 ? 0.2 : 0.1);
    CGFloat h = w * (i % 5 == 0 ? 0.2 : 0.1);
        
    CGFloat x = cx + cos(angle) * r;
    CGFloat y = cy + sin(angle) * r;
    
    CGRect tick = CGRectMake(- w, - h / 2, w, h);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, x, y);
    CGContextRotateCTM(context, angle);
    
    CGContextFillRect(context, tick);
    
    CGContextRestoreGState(context);
  }
  
  // draw minutes
  
  [_minutesColor setFill];

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
  CGContextRotateCTM(context, _minutesAngle);
  
  CGContextFillRect(context, rectangle);
  
  CGContextRestoreGState(context);

  // draw hours
  
  [_hoursColor setFill];
  
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
  CGContextRotateCTM(context, _hoursAngle);
  
  CGContextFillRect(context, hourRectangle);
  
  CGContextRestoreGState(context);
  
  // draw seconds
  
  [_secondsColor setFill];
  
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
  
  // seconds circle

  CGFloat ir = cx * 0.08;
  CGFloat circleX = cx + cos(_secondsAngle) * (secondsWidth - ir);
  CGFloat circleY = cy + sin(_secondsAngle) * (secondsWidth - ir) ;

  CGContextSetLineWidth(context,5);
  CGContextAddArc(context, circleX, circleY, ir, 0.0, M_PI*2, YES);
  CGContextFillPath(context);

  // central circle
  CGContextSetLineWidth(context,5);
  CGContextAddArc(context, cx, cy, cx * 0.04, 0.0, M_PI*2, YES);
  CGContextFillPath(context);
}

- (void)setSecondsColor:(NSString *) colorString {
  _secondsColor = [UIColor colorWithHexString:colorString];
  [self setNeedsDisplay];
}

- (void)setMinutesColor:(NSString *) colorString {
  _minutesColor = [UIColor colorWithHexString:colorString];
  [self setNeedsDisplay];
}

- (void)setHoursColor:(NSString *) colorString {
  _hoursColor = [UIColor colorWithHexString:colorString];
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

- (void)setMinutes:(int) minute {
  // every minute is one 60th of a circle
  CGFloat angle = 360 / 60 * minute;
  // remove 180 degrees to start at -90
  angle -= 90;
  
  _minutesAngle = M_PI / 180 * angle;
  
  [self setNeedsDisplay];
}

- (void)setHours:(int) hour {
  // every hour is one 12th of a circle
  CGFloat angle = 360 / 12 * hour;
  // remove 180 degrees to start at -90
  angle -= 90;
  
  _hoursAngle = M_PI / 180 * angle;
  
  [self setNeedsDisplay];
}

@end
