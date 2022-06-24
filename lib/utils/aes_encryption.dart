// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:atm_flutter_app/helper/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AesEncryption {
  static const platform = MethodChannel('flutter.native/PlatformHelper');

  encrypt(String body, String key) async {
    // String? encryptString;
    var encryptResult;
    try {
      encryptResult = await platform.invokeMethod(
          'EncryptRequest', <String, String>{'request': body, 'key': key});
      debugPrint('de---' + encryptResult);
    } on PlatformException catch (e) {
      print(e);
    }
    return encryptResult;
  }

  decrypt(String body, String key) async {
    // String decryptString;
    var decryptResult;
    debugPrint('decrypt---' + body + ',-,' + key);
    try {
      decryptResult = await platform.invokeMethod(
          'DecryptResponse', <String, String>{'response': body, 'key': key});
    } on PlatformException catch (e) {
      decryptResult = e.message.toString();
    }
    return decryptResult;
  }
}
