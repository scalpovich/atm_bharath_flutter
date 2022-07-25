import 'dart:math';

import 'package:atm_flutter_app/constants/date_time_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Utils {
  String getTraceId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz1234567890';
    Random rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    String genKey = getRandomString(4);
    return genKey.toUpperCase();
  }

  String convertDecimal(double? amount) {
    NumberFormat numberFormat = NumberFormat("#,###,##0.00");
    String convertedValue = numberFormat.format(amount);
    return convertedValue;
  }

  String parseDBDateTime(String input) {
    String output = '';
    if (input.isNotEmpty) {
      try {
        DateFormat inputFormat =
            DateFormat(DateTimeFormats.SERVER_DATE_TIME_FORMAT);
        DateTime newDate = inputFormat.parse(input);

        DateFormat outputFormat =
            DateFormat(DateTimeFormats.SQLITE_DATE_FORMAT);
        output = outputFormat.format(newDate);
      } on Exception catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    return output;
  }

  String getSaltString() {
    const chars = "abcdefghijklmnopqrstuvwxyz1234567890";
    Random rnd = Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
    String saltStr = getRandomString(8);
    return saltStr;
  }
}
