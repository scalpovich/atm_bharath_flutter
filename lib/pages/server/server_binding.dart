import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/server/server_controller.dart';
import 'package:get/get.dart';

class ServerBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ServerController());
    Get.lazyPut(() => DatabaseOperations());
  }
}