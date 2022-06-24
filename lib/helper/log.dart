import 'dart:developer';

import 'package:get_storage/get_storage.dart';

class Log {
  final box = GetStorage();
  void logs(String title, String text) async {
    // bool logFlag = await box.read('log_flag');
    // if (logFlag == true) {
    log('$title:::$text');
    // }
  }
}
