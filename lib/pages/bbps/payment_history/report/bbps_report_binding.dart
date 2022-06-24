import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:get/get.dart';

import 'bbps_report_controller.dart';

class BBPSReportBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => BBPSReportController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
