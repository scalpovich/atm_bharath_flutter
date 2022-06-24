import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/recharge/mobile_recharge_controller.dart';
import 'package:get/get.dart';

class MobileRechargeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MobileRechargeController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
