import Flutter
import UIKit

public class SwiftFlutterSleepingHoursSliderPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_sleeping_hours_slider", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterSleepingHoursSliderPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
