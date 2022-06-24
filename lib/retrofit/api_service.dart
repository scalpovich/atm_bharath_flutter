import 'dart:convert';
import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/base/base_response.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/api_req_res_format.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ApiService extends GetConnect {
  ApiService() {
    httpClient.baseUrl = PrefManager().getBaseUrl;
    int timeout = int.parse(PrefManager().getTimeoutTime.toString());
    httpClient.timeout = Duration(seconds: timeout);
  }

  updateBaseUrl(String baseUrl) {
    httpClient.baseUrl = baseUrl;
    httpClient.timeout = const Duration(seconds: 60);
  }

//post method
  Future<BaseResponse?> postMethod(dynamic body, Map<String, String> header,
      String key, String endPoint) async {
    try {
      Log().logs('url::::', httpClient.baseUrl.toString() + endPoint);
      var response = await post(endPoint, body, headers: header);
      Log().logs("response:::", response.bodyBytes.toString());
      if (response.status.hasError) {
        return BaseResponse(status: false, message: response.statusText);
      } else {
        String resBody = response.bodyString!;
        String resbody = await ApiReqResFormat().resFormatter(resBody);
        String responseData = await AesEncryption().decrypt(resbody, key);
        if (responseData ==
            'javax.crypto.BadPaddingException: error:1e000065:Cipher functions:OPENSSL_internal:BAD_DECRYPT') {
          return BaseResponse(
              status: false,
              message: 'Sorry! Please try again later',
              data: []);
        } else {
          final jsonDecode = json.decode(responseData);
          final data = BaseResponse.fromJson(jsonDecode);
          return data;
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<dynamic> uploadImageIdForTransaction() async {}

//get method
  Future<BaseResponse?> getMethod(
      Map<String, String> header, String key, String endPoint) async {
    var response = await get(endPoint, headers: header);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      String resBody = response.bodyString!;
      String body = await ApiReqResFormat().resFormatter(resBody);
      String decryptedBody = await AesEncryption().decrypt(body, key);
      final jsonDecode = json.decode(decryptedBody);
      final data = BaseResponse.fromJson(jsonDecode);
      return data;
    }
  }

  // Future<void> uploadImage() async {
  //   var postUrl = Uri.parse('');
  //   var response = new http.MultipartRequest("POST", postUrl);
  //   response.fields[] = ;
  //   response.files.add()
  // }
}
