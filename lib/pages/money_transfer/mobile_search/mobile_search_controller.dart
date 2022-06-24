import 'dart:convert';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/money_transfer/mobile_search.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/headers.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/api_req_res_format.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:get/get.dart';

class MobileSearchController extends GetxController {
  RxList<MobileSearch> searchList = <MobileSearch>[].obs;
  dynamic argumentData = Get.arguments;
  RxBool isLoading = true.obs;
  RxBool status = true.obs;

  @override
  void onReady() {
    super.onReady();
    mobileSearchList();
  }

  void mobileSearchList() async {
    dynamic body = {AppStrings.txtMobile: argumentData[AppStrings.txtMobileNo]};
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
        Apis.MOBILE_SEARCH);
    if (result != null) {
      if (result.status!) {
        isLoading.value = false;
        dynamic dataResult = result.data;
        for (int i = 0; i < dataResult.length; i++) {
          final jsonEncode = json.encode(dataResult[i]);
          final jsonDecode = json.decode(jsonEncode);
          final mobileSearchData = MobileSearch.fromJson(jsonDecode);
          searchList.add(mobileSearchData);
        }
      } else {
        isLoading.value = false;
        status.value = false;
        commonSnackBar(result.message!);
      }
    } else {
      isLoading.value = false;
      commonSnackBar('error_network_timeout'.tr);
    }
  }
}
