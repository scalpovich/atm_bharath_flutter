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

class MoneyTransferAccountSearchController extends GetxController {
  RxList<MobileSearch> accountSearchList = <MobileSearch>[].obs;
  dynamic argumentData = Get.arguments;
  RxBool isLoading = true.obs;
  RxBool status = true.obs;

  @override
  void onReady() {
    super.onReady();
    accountNoSearchList();
  }

  void accountNoSearchList() async {
    dynamic body = {
      AppStrings.txtAccount.toLowerCase(): argumentData[AppStrings.txtMobileNo]
    };
    final jsonBody = json.encode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody, PrefManager().getDeviceId! + PrefManager().getCustomerCode!);
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    final result = await ApiService().postMethod(
        reqBody,
        commonHeader,
        PrefManager().getDeviceId! + PrefManager().getCustomerCode!,
        Apis.ACCOUNT_NO_SEARCH);
    if (result != null) {
      if (result.status!) {
        dynamic dataResult = result.data;
        List<MobileSearch> searchList = [];
        for (int i = 0; i < dataResult.length; i++) {
          final jsonEncode = json.encode(dataResult[i]);
          final jsonDecode = json.decode(jsonEncode);
          final mobileSearchData = MobileSearch.fromJson(jsonDecode);
          dynamic searchData = MobileSearch(
              mobileNo: mobileSearchData.mobileNo,
              benefName: mobileSearchData.benefName,
              cusName: mobileSearchData.cusName,
              benefIfsc: mobileSearchData.benefIfsc);
          searchList.add(searchData);
        }
        isLoading.value = false;
        accountSearchList.addAll(searchList);
      } else {
        status.value = false;
        isLoading.value = false;
        commonSnackBar(result.message!);
      }
    } else {
      isLoading.value = false;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  Future<String> mobileNoDecrypt(String mobileNo) async {
    String decryptedNo =
        await AesEncryption().decrypt(mobileNo, PrefManager().getCustomerCode!);
    return decryptedNo;
  }

  void onTap(int index) async {
    String mobileNo =
        await mobileNoDecrypt(accountSearchList[index].mobileNo!.toString());
    Get.back(result: {
      AppStrings.txtIFSCCode: accountSearchList[index].benefIfsc!,
      AppStrings.txtCustomerName: accountSearchList[index].cusName!,
      AppStrings.txtBeneficiaryName: accountSearchList[index].benefName!,
      AppStrings.txtCustomerMobile: mobileNo,
    });
  }
}
