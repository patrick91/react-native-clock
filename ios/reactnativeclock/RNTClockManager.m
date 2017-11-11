#import <UIKit/UIKit.h>
#import <React/RCTViewManager.h>

@interface RNTClockManager : RCTViewManager
@end

@implementation RNTClockManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[UIView alloc] init];
}

@end
