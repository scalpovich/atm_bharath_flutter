import 'package:atm_flutter_app/pages/door_step/completed_order/door_step_completed_order_controller.dart';
import 'package:get/get.dart';

class DoorSepCompletedOrderBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DoorStepCompletedOrderController());
  }
}
