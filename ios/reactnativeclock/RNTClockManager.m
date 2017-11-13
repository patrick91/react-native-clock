#import <UIKit/UIKit.h>
#import <React/RCTViewManager.h>

#import "ClockView.h"

@interface RNTClockManager : RCTViewManager
@end

@implementation RNTClockManager

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(secondsColor, NSString)
RCT_EXPORT_VIEW_PROPERTY(minutesColor, NSString)
RCT_EXPORT_VIEW_PROPERTY(hoursColor, NSString)
RCT_EXPORT_VIEW_PROPERTY(seconds, int)
RCT_EXPORT_VIEW_PROPERTY(minute, int)
RCT_EXPORT_VIEW_PROPERTY(hour, int)


- (UIView *)view
{
  return [[ClockView alloc] init];
}

@end
