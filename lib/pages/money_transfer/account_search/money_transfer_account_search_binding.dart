import 'package:atm_flutter_app/pages/money_transfer/account_search/money_transfer_account_search_controller.dart';
import 'package:get/get.dart';

class MoneyTransferAccountSearchBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MoneyTransferAccountSearchController());
  }
}
