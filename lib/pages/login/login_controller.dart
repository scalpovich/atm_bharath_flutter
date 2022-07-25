import 'dart:async';
import 'dart:convert';
import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/login/login_response.dart';
import 'package:atm_flutter_app/pages/server/server_binding.dart';
import 'package:atm_flutter_app/pages/server/server_page.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/body/login_body.dart';
import 'package:atm_flutter_app/retrofit/header/headers.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:atm_flutter_app/utils/utils.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../model/server.dart';

class LoginController extends MainController {
  final box = GetStorage();
  TextEditingController deviceIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final selectedValue = AppStrings.txtMerchant.obs;
  final token = ''.obs;

  RxBool rotateCard = false.obs;
  RxBool showFrontSide = true.obs;
  RxBool flipXAxis = true.obs;

  RxBool custCodeValidate = true.obs;
  RxBool deviceIdValidate = true.obs;
  RxBool btnClicked = false.obs;
  RxBool isDriver = false.obs;
  RxBool isMerchant = true.obs;
  RxString userType = 'N'.obs;
  String deviceId = PrefManager().getDeviceId.toString();
  @override
  void onInit() {
    deviceIdController = TextEditingController(text: deviceId);
    getDeviceToken();
    if (!PrefManager().getNewUserFlag!) {
      setServers();
    }
    super.onInit();
  }

  ///getting firebase device token
  void getDeviceToken() async {
    try {
      await FirebaseMessaging.instance.getToken().then((value) {
        token.value = value!;
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  ///setting base server and default server
  void setServers() async {
    PrefManager().setBaseUrl('https://app.atmbharath.in/MoneyTrfNew/MoneyTrf/');
    List<Server> serverList = [];
    serverList.add(Server(
        1, 'https://app.atmbharath.in/MoneyTrfNew/MoneyTrf/', true, 'D'));
    serverList.add(Server(
        2, 'https://api.atmbharath.com/MoneytrfNew/MoneyTrf/', false, 'NE'));
    serverList.add(
        Server(3, 'https://api.techorbit.net/moneytrf/Moneytrf/', false, 'NE'));
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    box.put(DatabaseConstants.dbServerList, serverList);
  }

  ///select user type
  void userTypeOnTap(bool value, String user) {
    if (user == AppStrings.txtDriver) {
      isDriver.value = value;
      isMerchant.value = !value;
      userType.value = 'Y';
    } else {
      isDriver.value = !value;
      isMerchant.value = value;
      userType.value = 'N';
    }
  }

  ///selected user type
  void setSelected(String value) {
    selectedValue.value = value;
  }

  ///login api call
  Future<bool> loginUser() async {
    String body = await loginBody(
        userName: deviceIdController.text,
        password: passwordController.text,
        token: token.toString());
    dynamic header = loginHeader(
        deviceId: deviceIdController.text, userType: userType.value);
    final result = await ApiService().postMethod(body, header,
        deviceIdController.text + passwordController.text, Apis.LOGIN);
    if (result != null) {
      if (result.status!) {
        dynamic dataResult = result.data;
        final jsonEncode = json.encode(dataResult);
        final jsonDecode = json.decode(jsonEncode);
        final loginResponse = LoginResponse.fromJson(jsonDecode);
        await setPrefs(loginResponse);
        return true;
      } else {
        btnClicked.value = false;
        commonSnackBar(result.message!);
        return false;
      }
    } else {
      btnClicked.value = false;
      commonSnackBar('error_network_timeout'.tr);
      return false;
    }
  }

  ///setting shared preference values for future use
  Future<void> setPrefs(LoginResponse loginResponse) async {
    String? wallet = Utils()
        .convertDecimal(double.parse(loginResponse.walletAmount.toString()));
    PrefManager().setDeviceId(deviceIdController.text);
    PrefManager().setWalletMoney(wallet);
    PrefManager().setCustomerName(loginResponse.customerName.toString());
    PrefManager().setShopGstNo(loginResponse.gst.toString());
    if (loginResponse.driverName != null) {
      PrefManager().setDriverName(loginResponse.driverName.toString());
      PrefManager().setDriverCode(loginResponse.driverCode.toString());
      PrefManager().setDriverDutyStatus(loginResponse.driverStatus.toString());
      String encryptDriverCode = await AesEncryption().encrypt(
          loginResponse.driverCode.toString(),
          deviceIdController.text + loginResponse.driverCode.toString());
      PrefManager().setEncryptedDriverCode(encryptDriverCode);
    }
    PrefManager().setCustomerMobile(loginResponse.customerMob.toString());
    PrefManager().setCustomerEmail(loginResponse.customerEmail.toString());
    PrefManager().setShopAddress(loginResponse.customerAddress1.toString());
    PrefManager().setShopAddressLine(loginResponse.customerAddress2.toString());
    PrefManager().setCustomerCode(loginResponse.customerCode.toString());
    if (PrefManager().getQRTimeout == null) {
      PrefManager().setQRTimeout('60');
    } else if (PrefManager().getQRTimeout == '') {
      PrefManager().setQRTimeout('60');
    }
    String encryptedCusCode = await AesEncryption().encrypt(
        loginResponse.customerCode.toString(),
        deviceIdController.text + loginResponse.customerCode.toString());
    PrefManager().setEncryptedCustomerCode(encryptedCusCode);
    PrefManager().setLockingAmount(loginResponse.lockingAmount.toString());
    PrefManager().setLoginFlag(true);
    PrefManager().setQR(false);
    PrefManager().setMoneyTransfer(false);
    PrefManager().setDoorStep(false);
    PrefManager().setBBPS(false);
    if (loginResponse.services != null) {
      for (int i = 0; loginResponse.services!.length > i; i++) {
        if (loginResponse.services![i].serviceName ==
            AppStrings.txtMoneyTransfer) {
          PrefManager().setMoneyTransfer(true);
          if (loginResponse.services![i].passWord != null ||
              loginResponse.services![i].passWord != 'null') {
            PrefManager().setMoneyTransferPassword(
                loginResponse.services![i].passWord.toString());
          } else {
            PrefManager().setMoneyTransferPassword('');
          }
        }
        if (loginResponse.services![i].serviceName ==
            AppStrings.txtBBPS.toUpperCase()) {
          PrefManager().setBBPS(true);
          if (loginResponse.services![i].passWord != null ||
              loginResponse.services![i].passWord != 'null') {
            PrefManager().setBBPSPassword(
                loginResponse.services![i].passWord.toString());
          } else {
            PrefManager().setBBPSPassword('');
          }
        }
        if (loginResponse.services![i].serviceName ==
            AppStrings.txtQR.toUpperCase()) {
          PrefManager().setQR(true);
          if (loginResponse.services![i].passWord != null ||
              loginResponse.services![i].passWord != 'null') {
            PrefManager()
                .setQRPassword(loginResponse.services![i].passWord.toString());
          } else {
            PrefManager().setQRPassword('');
          }
        }
        if (loginResponse.services![i].serviceName == AppStrings.txtDoorStep) {
          PrefManager().setDoorStep(true);
          if (loginResponse.services![i].passWord != null ||
              loginResponse.services![i].passWord != 'null') {
            PrefManager().setDoorStepPassword(
                loginResponse.services![i].passWord.toString());
          } else {
            PrefManager().setDoorStepPassword('');
          }
        } else {
          PrefManager().setDoorStep(false);
        }
      }
    }
  }

  ///navigate to server page
  void goToServerPage() async {
    Get.to(() => const ServerPage(), binding: ServerBinding());
  }
}
