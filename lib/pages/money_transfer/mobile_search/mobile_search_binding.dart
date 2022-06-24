import 'package:atm_flutter_app/pages/money_transfer/mobile_search/mobile_search_controller.dart';
import 'package:get/get.dart';

class MobileSearchBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MobileSearchController());
  }
}
