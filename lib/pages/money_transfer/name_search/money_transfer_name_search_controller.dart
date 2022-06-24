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

class MoneyTransferNameSearchController extends GetxController {
  RxList<MobileSearch> benefNameSearchList = <MobileSearch>[].obs;
  dynamic argumentData = Get.arguments;
  RxBool isLoading = true.obs;
  RxBool status = true.obs;

  @override
  void onReady() {
    super.onReady();
    mobileSearchList();
  }

  void mobileSearchList() async {
    dynamic body = {
      AppStrings.txtBeneficiaryName: argumentData[AppStrings.txtBeneficiaryName]
    };
    final jsonBody = json.encode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody, PrefManager().getDeviceId! + PrefManager().getCustomerCode!);
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    final result = await ApiService().postMethod(
        reqBody,
        commonHeader,
        PrefManager().getDeviceId! + PrefManager().getCustomerCode!,
        Apis.NAME_SEARCH);
    if (result!.status!) {
      if (result.data != null) {
        dynamic dataResult = result.data;
        List<MobileSearch> searchList = [];
        for (int i = 0; i < dataResult.length; i++) {
          final jsonEncode = json.encode(dataResult[i]);
          final jsonDecode = json.decode(jsonEncode);
          final mobileSearchData = MobileSearch.fromJson(jsonDecode);
          dynamic searchData = MobileSearch(
              benefIfsc: mobileSearchData.benefIfsc,
              benefAccount: mobileSearchData.benefAccount,
              mobileNo: mobileSearchData.mobileNo,
              cusName: mobileSearchData.cusName);

          searchList.add(searchData);
        }
        isLoading.value = false;
        benefNameSearchList.addAll(searchList);
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

  Future<String> mobileNoDecrypt(String mobileNo) async {
    String decryptedNo =
        await AesEncryption().decrypt(mobileNo, PrefManager().getCustomerCode!);
    return decryptedNo;
  }

  void onTap(int index) async {
    String mobileNo =
        await mobileNoDecrypt(benefNameSearchList[index].mobileNo!.toString());
    Get.back(result: {
      AppStrings.txtIFSCCode: benefNameSearchList[index].benefIfsc!,
      AppStrings.txtCustomerName: benefNameSearchList[index].cusName!,
      AppStrings.txtBenefAccNo: benefNameSearchList[index].benefAccount!,
      AppStrings.txtCustomerMobile: mobileNo,
    });
  }
}
