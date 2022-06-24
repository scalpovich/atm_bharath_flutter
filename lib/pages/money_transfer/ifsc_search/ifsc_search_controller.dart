import 'dart:convert';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/money_transfer/ifsc.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/headers.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/api_req_res_format.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:get/get.dart';

class IFSCSearchController extends GetxController {
  dynamic argumentData = Get.arguments;
  RxList<IFSC> ifscSearchList = <IFSC>[].obs;
  RxBool isLoading = true.obs;
  RxBool status = true.obs;

  @override
  void onInit() {
    super.onInit();
    getIFSCSearchList();
  }

  void getIFSCSearchList() async {
    dynamic body = {
      'bank': argumentData[AppStrings.txtBankName].toString().toUpperCase(),
      'branch': argumentData[AppStrings.txtBranch],
      'state': argumentData[AppStrings.txtState],
      'district': argumentData[AppStrings.txtDistrict]
    };
    final jsonBody = json.encode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    final result = await ApiService().postMethod(
        reqBody,
        commonHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.IFSC_SEARCH);
    if (result != null) {
      if (result.status!) {
        isLoading.value = false;
        dynamic dataResult = result.data;
        for (int i = 0; i < dataResult.length; i++) {
          final jsonEncode = json.encode(dataResult[i]);
          final jsonDecode = json.decode(jsonEncode);
          final ifscSearchData = IFSC.fromJson(jsonDecode);
          ifscSearchList.add(ifscSearchData);
        }
      } else {
        isLoading.value = false;
        commonSnackBar(result.message!);
      }
    } else {
      isLoading.value = false;
      status.value = false;
      commonSnackBar('error_network_timeout'.tr);
    }
  }
}
