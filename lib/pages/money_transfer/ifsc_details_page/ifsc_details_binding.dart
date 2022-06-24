import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/money_transfer/ifsc_details_page/ifsc_details_controller.dart';
import 'package:get/get.dart';

class IFSCDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IFSCDetailsController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
