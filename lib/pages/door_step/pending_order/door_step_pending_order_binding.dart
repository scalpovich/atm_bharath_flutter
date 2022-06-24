import 'package:atm_flutter_app/pages/door_step/pending_order/door_step_pending_order_controller.dart';
import 'package:get/get.dart';

class DoorStepPendingOrderBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DoorStepPendingOrderController());
  }
}