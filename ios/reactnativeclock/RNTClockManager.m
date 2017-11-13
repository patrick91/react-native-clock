#import <UIKit/UIKit.h>
#import <React/RCTViewManager.h>

#import "ClockView.h"

@interface RNTClockManager : RCTViewManager
@end

@implementation RNTClockManager

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(color, NSString)
RCT_EXPORT_VIEW_PROPERTY(angle, int)


- (UIView *)view
{
  return [[ClockView alloc] init];
}

@end
