import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_number/mobile_number_controller.dart';
import 'package:get/get.dart';

class MobileNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MobileNumberController());
  }
}
