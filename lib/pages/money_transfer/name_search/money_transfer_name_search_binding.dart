import 'package:atm_flutter_app/pages/money_transfer/name_search/money_transfer_name_search_controller.dart';
import 'package:get/get.dart';

class MoneyTransferNameSearchBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MoneyTransferNameSearchController());
  }
}
