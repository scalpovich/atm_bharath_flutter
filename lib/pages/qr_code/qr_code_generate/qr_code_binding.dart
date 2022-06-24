import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/qr_code/qr_code_generate/qr_code_controller.dart';
import 'package:get/get.dart';

class QRCodeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => QRCodeController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
