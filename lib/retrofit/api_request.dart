import 'dart:convert';

import '../utils/aes_encryption.dart';
import '../utils/api_req_res_format.dart';

Future<String> request({required dynamic body, required String key}) async {
  final jsonBody = json.encode(body);
  String encryptedBody = await AesEncryption()
      .encrypt(jsonBody, key);
  String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
  return reqBody;
}