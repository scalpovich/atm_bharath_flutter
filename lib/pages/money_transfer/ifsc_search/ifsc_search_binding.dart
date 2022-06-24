import 'package:atm_flutter_app/pages/money_transfer/ifsc_search/ifsc_search_controller.dart';
import 'package:get/get.dart';

class IFSCSearchBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => IFSCSearchController());
  }
}
