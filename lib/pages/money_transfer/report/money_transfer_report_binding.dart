import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/money_transfer/report/money_transafer_report_controller.dart';
import 'package:get/get.dart';

class MoneyTransferReportBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MoneyTransferReportController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
