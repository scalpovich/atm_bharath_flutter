import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/qr_code/report_details/qr_code_report_summary_controller.dart';
import 'package:get/get.dart';

class QRCodeReportSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QRCodeReportSummaryController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
