import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_details/bbps_bill_details_controller.dart';
import 'package:atm_flutter_app/utils/location_service.dart';
import 'package:get/get.dart';

class BBPSBillDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BBPSBillDetailsController());
    Get.lazyPut(() => DatabaseOperations());
    Get.lazyPut(() => LocationService());
  }
}
