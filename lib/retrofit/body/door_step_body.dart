import 'dart:convert';

import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/api_req_res_format.dart';
import 'package:intl/intl.dart';

import '../../resources/app_strings.dart';

Future<dynamic> doorStepOrderAcceptedBody(
    {required String latitude,
    required String longitude,
    required String customerName,
    required String orderId}) async {
  Map<String, String> body = {
    'latitude': latitude,
    'longitude': longitude,
    'customer_name': customerName,
    'order_id': orderId
  };
  return body;
}

// Map<String, String> doorStepBody = {
//   'start_date': ,
// };

Future<dynamic> doorStepOrderRejectedBody({required String orderId}) async {
  Map<String, String> body = {'order_id': orderId};
  return body;
}

Future<dynamic> doorStepAgentLocationBody(
    {required String orderId,
    required String latitude,
    required String longitude}) async {
  Map<String, String> body = {
    'order_id': orderId,
    'latitude': latitude,
    'longitude': longitude
  };
  final jsonBody = jsonEncode(body);
  String encryptedBody = await AesEncryption().encrypt(
      jsonBody,
      PrefManager().getDeviceId.toString() +
          PrefManager().getDriverCode.toString());
  String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
  return reqBody;
}

Future<dynamic> doorStepOrderStatusBody(
    {required String orderId, required String orderStatus}) async {
  Map<String, String> body = {
    'merchant_status': orderStatus,
    'order_id': orderId
  };
  final jsonBody = jsonEncode(body);
  String encryptedBody = await AesEncryption().encrypt(
      jsonBody,
      PrefManager().getDeviceId.toString() +
          PrefManager().getDriverCode.toString());
  String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
  return reqBody;
}

Future<dynamic> doorStepOtpVerifyBody(
    {required String otp, required String orderId}) async {
  Map<String, String> body = {'otp': otp, 'order_id': orderId};
  final jsonBody = jsonEncode(body);
  String encryptedBody = await AesEncryption().encrypt(
      jsonBody,
      PrefManager().getDeviceId.toString() +
          PrefManager().getDriverCode.toString());
  String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
  return reqBody;
}

Future<dynamic> doorStepReportBody(
    {required DateTime startDate,
    required DateTime endDate,
    required int pageNo,
    required String sync,
    required String searchText}) async {
  Map<String, dynamic> body = {
    AppStrings.txtStartDate:
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(startDate).toString(),
    AppStrings.txtEndDate:
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDate).toString(),
    AppStrings.txtPageNo: pageNo,
    AppStrings.txtSync.toLowerCase(): sync,
    AppStrings.txtSearchText: searchText
  };
  final jsonBody = jsonEncode(body);
  String encryptedBody = await AesEncryption().encrypt(
      jsonBody,
      PrefManager().getDeviceId.toString() +
          PrefManager().getDriverCode.toString());
  String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
  return reqBody;
}
