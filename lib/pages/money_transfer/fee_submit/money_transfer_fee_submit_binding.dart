import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/pages/money_transfer/fee_submit/money_transfer_fee_submit_controller.dart';
import 'package:get/get.dart';

class MoneyTransferFeeSubmitBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MoneyTransferFeeSubmitController());
    Get.lazyPut(() => DatabaseOperations());
  }
}
