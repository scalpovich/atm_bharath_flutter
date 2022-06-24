import 'dart:developer';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';

class Device {
  static const platform = MethodChannel('flutter.native/PlatformHelper');

  Future<String?> initPlatformState() async {
    String udid;
    try {
      udid = await FlutterUdid.udid;
      if (kDebugMode) {
        print(udid.toString());
      }
    } on PlatformException {
      udid = 'Failed to get UDID.';
    }
    return udid;
  }

  Future<String?> getDeviceId() async {
    String deviceId;
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      // print('Running on ${androidInfo.model}');
      deviceId = androidInfo.device;
    } on Exception {
      deviceId = '';
    }
    return deviceId;
  }

  Future<String?> getUserId() async {
    String deviceId;
    try {
      deviceId =
          await platform.invokeMethod('SerialNumber', <String, String>{});
      log("request: $deviceId");
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      deviceId = '';
    }
    return deviceId;
  }
}
