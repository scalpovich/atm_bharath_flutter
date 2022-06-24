import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/money_transfer/report/money_transafer_report_controller.dart';
import 'package:atm_flutter_app/pages/money_transfer/report_details/money_transfer_report_summary_controller.dart';
import 'package:get/get.dart';

class MoneyTransferReportSummaryBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MoneyTransferReportSummaryController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
