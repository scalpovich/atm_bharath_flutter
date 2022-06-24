import 'package:atm_flutter_app/pages/door_step/accepted_order/door_step_accepted_order_controller.dart';
import 'package:atm_flutter_app/pages/door_step/completed_order/door_step_completed_order_controller.dart';
import 'package:atm_flutter_app/pages/door_step/door_step_controller.dart';
import 'package:atm_flutter_app/pages/door_step/pending_order/door_step_pending_order_controller.dart';
import 'package:get/get.dart';

class DoorStepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoorStepController());
    Get.lazyPut(() => DoorStepPendingOrderController());
    // Get.lazyPut(() => DoorStepAcceptedOrderController());
    Get.lazyPut(() => DoorStepCompletedOrderController());
    // Get.lazyPut(() => DoorStepAcceptedOrderController());
  }
}
