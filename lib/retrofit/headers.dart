import 'dart:core';

import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/utils/utils.dart';

Map<String, String> commonHeader = {
  'DeviceId': PrefManager().getDeviceId!,
  'CustomerCode': PrefManager().getEncryptedCustomerCode!,
  'Content-Type': 'application/json; charset=utf-8'
};

Map<String, String> doorStepHeader = {
  'DeviceId': PrefManager().getDeviceId!,
  'CustomerCode': PrefManager().getEncryptedDriverCode.toString(),
  'Content-Type': 'application/json; charset=utf-8'
};

Map<String, String> agentDutyStatusHeader = {
  'DeviceId': PrefManager().getDeviceId!,
  'CustomerCode': PrefManager().getEncryptedDriverCode!,
};

Future<dynamic> addTransactionHeader(String genKey) async {
  Map<String, String> header = {
    'DeviceId': PrefManager().getDeviceId!,
    'CustomerCode': PrefManager().getEncryptedCustomerCode!,
    'BD-Traceid': genKey,
    'Content-Type': 'application/json; charset=utf-8'
  };
  return header;
}

Future<Map<String, String>> bbpsCommonHeader() async {
  Map<String, String> header = {
    'DeviceId': PrefManager().getDeviceId.toString(),
    'CustomerCode': PrefManager().getEncryptedCustomerCode.toString(),
    'BD-Traceid': Utils().getSaltString(),
  };
  return header;
}
