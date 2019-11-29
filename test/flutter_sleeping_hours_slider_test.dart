import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sleeping_hours_slider/flutter_sleeping_hours_slider.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_sleeping_hours_slider');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterSleepingHoursSlider.platformVersion, '42');
  });
}
