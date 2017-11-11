#import <UIKit/UIKit.h>
#import <React/RCTViewManager.h>

#import "ClockView.h"

@interface RNTClockManager : RCTViewManager
@end

@implementation RNTClockManager

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(color, NSString)


- (UIView *)view
{
  return [[ClockView alloc] init];
}

@end
