import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:get/get.dart';

import 'bbps_payment_details_controller.dart';

class BBPSPaymentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BBPSPaymentDetailsController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
