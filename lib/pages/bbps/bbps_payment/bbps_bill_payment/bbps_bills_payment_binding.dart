import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_payment/bbps_bills_payment_controller.dart';
import 'package:get/get.dart';

class BBPSBillsPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BBPSBillsPaymentController());
    Get.lazyPut(() => DatabaseOperations());
  }
}