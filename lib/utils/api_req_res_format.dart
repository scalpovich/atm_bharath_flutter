import 'package:flutter/cupertino.dart';

class ApiReqResFormat {
  Future<String> reqFormatter(String request) async {
    var reqFormat;
    reqFormat = await '{"request_encrypted": "$request"}';
    debugPrint('request----$reqFormat');
    return reqFormat;
  }

  Future<String> resFormatter(String response) async {
    var resFormat;
    response = response.replaceAll('{"response_encrypted":"', '');
    response = response.replaceAll('"}', "");
    resFormat = await response;
    debugPrint('result---' + resFormat);
    return resFormat;
  }
}
