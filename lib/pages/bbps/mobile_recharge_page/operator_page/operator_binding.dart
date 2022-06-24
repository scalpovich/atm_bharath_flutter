import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/operator_page/operaor_controller.dart';
import 'package:get/get.dart';

class OperatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OperatorController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
