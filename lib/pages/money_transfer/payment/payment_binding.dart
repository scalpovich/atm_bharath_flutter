import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/money_transfer/payment/payment_controller.dart';
import 'package:get/get.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
