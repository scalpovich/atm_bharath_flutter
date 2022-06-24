import 'package:atm_flutter_app/pages/splash_screen/splash_screen_controller.dart';
import 'package:get/get.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }
}
