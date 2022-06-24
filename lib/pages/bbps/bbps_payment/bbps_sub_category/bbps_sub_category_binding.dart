import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_sub_category/bbps_sub_catgory_controller.dart';
import 'package:get/get.dart';

class BBPSSubCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BBPSSubCategoryController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
