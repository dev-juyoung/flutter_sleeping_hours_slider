#import "FlutterSleepingHoursSliderPlugin.h"
#import <flutter_sleeping_hours_slider/flutter_sleeping_hours_slider-Swift.h>

@implementation FlutterSleepingHoursSliderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSleepingHoursSliderPlugin registerWithRegistrar:registrar];
}
@end
