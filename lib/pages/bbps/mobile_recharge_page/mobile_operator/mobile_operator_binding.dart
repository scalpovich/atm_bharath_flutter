import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_operator/mobile_operator_controller.dart';
import 'package:get/get.dart';

class MobileOperatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MobileOperatorController());
  }
}
