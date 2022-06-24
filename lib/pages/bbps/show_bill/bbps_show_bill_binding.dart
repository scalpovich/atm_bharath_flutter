import 'package:atm_flutter_app/pages/bbps/show_bill/bbps_show_bill_controller.dart';
import 'package:get/get.dart';

class BBPSShowBillBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => BBPSShowBillController());
  }
}
