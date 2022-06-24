import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => DatabaseOperations());
  }
}
