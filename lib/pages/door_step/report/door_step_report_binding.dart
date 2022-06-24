import 'package:atm_flutter_app/pages/door_step/report/door_step_report_controller.dart';
import 'package:get/get.dart';

class DoorStepReportBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DoorStepReportController());
  }
}