import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../helper/prefManager.dart';
import '../home/home_binding.dart';
import '../home/home_page.dart';
import '../login/login_binding.dart';
import '../login/login_page.dart';

class SplashScreenController extends GetxController {
  RxBool hasConnection = false.obs;
  bool loginFlag = PrefManager().getLoginFlag ?? false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkInternetConnection();
  }

  void checkInternetConnection() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        hasConnection.value = true;
        goToNextPage();
      } else {
        hasConnection.value = false;
      }
    });
  }

  void goToNextPage() {
    Timer(const Duration(seconds: 5), () {
      if (loginFlag) {
        Get.off(() => HomePage(), binding: HomeBinding());
      } else {
        bool newUser = PrefManager().getNewUserFlag ?? false;
        if (!newUser) {
          PrefManager().setNewUserFlag(false);
          PrefManager().setTimeoutTime('60');
          PrefManager().setQRTimeout('60');
          PrefManager().setSyncDuration('2');
        }
        Get.off(() => const LoginPage(), binding: LoginBinding());
      }
    });
  }
}
