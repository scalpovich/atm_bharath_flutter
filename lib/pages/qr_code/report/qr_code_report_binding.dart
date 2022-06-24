import 'package:atm_flutter_app/pages/qr_code/report/qr_code_report_controller.dart';
import 'package:get/get.dart';

import '../../../helper/database_operations.dart';

class QRCodeReportBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => QRCodeReportController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
