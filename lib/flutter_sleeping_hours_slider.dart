import 'dart:async';

import 'package:flutter/services.dart';

class FlutterSleepingHoursSlider {
  static const MethodChannel _channel =
      const MethodChannel('flutter_sleeping_hours_slider');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
