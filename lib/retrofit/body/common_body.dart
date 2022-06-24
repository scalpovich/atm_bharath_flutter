import 'dart:convert';

import 'package:intl/intl.dart';

import '../../helper/prefManager.dart';
import '../../resources/app_strings.dart';
import '../../utils/aes_encryption.dart';
import '../../utils/api_req_res_format.dart';

Future<dynamic> commonReportBody(
    {required DateTime startDate,
      required DateTime endDate,
      required int pageNo,
      required String sync,
      required String searchText}) async {
  Map<String, dynamic> body = {
    AppStrings.txtStartDate: DateFormat('yyyy-MM-ddTHH:mm:ss').format(startDate).toString(),
    AppStrings.txtEndDate: DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDate).toString(),
    AppStrings.txtPageNo: pageNo,
    AppStrings.txtSync.toLowerCase(): sync,
    AppStrings.txtSearchText: searchText
  };
  final jsonBody = jsonEncode(body);
  String encryptedBody = await AesEncryption().encrypt(
      jsonBody,
      PrefManager().getDeviceId.toString() +
          PrefManager().getCustomerCode.toString());
  String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
  return reqBody;
}