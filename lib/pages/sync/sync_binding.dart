import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/sync/sync_controller.dart';
import 'package:get/get.dart';

class SyncBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SyncController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
