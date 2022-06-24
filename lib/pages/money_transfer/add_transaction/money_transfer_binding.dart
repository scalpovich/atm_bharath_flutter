import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/money_transfer/add_transaction/money_transfer_controller.dart';
import 'package:get/get.dart';

class MoneyTransferBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MoneyTransferController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
