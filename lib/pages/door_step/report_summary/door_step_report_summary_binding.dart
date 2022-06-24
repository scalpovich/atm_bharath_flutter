import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/door_step/report_summary/door_step_report_summary_controller.dart';
import 'package:get/get.dart';

class DoorStepReportSummaryBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DoorStepReportSummaryController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
