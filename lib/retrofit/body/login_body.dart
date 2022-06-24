import 'dart:convert';

import '../../helper/log.dart';
import '../../utils/aes_encryption.dart';
import '../../utils/api_req_res_format.dart';

Future<String> loginBody(
    {required String userName,
    required String password,
    required String token}) async {
  dynamic data = {
    'device_id': userName,
    'customer_code': password,
    'token': token
  };
  Log().logs('request::', data.toString());
  final jsonBody = json.encode(data);
  String reqBody = await AesEncryption().encrypt(jsonBody, userName + password);
  String body = await ApiReqResFormat().reqFormatter(reqBody);
  return body;
}
