import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/model/money_transfer/money_transfer_report.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:atm_flutter_app/utils/print_receipt.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../home/home_binding.dart';
import '../../home/home_page.dart';

class MoneyTransferFeeSubmitController extends MainController {
  dynamic arguments = Get.arguments;

  RxString benefName = ''.obs;
  RxString commissionFee = '0'.obs;
  RxString sgst = '0'.obs;
  RxString cgst = '0'.obs;
  RxString cess = '0'.obs;
  RxString transactionDate = ''.obs;
  RxString transactionNo = ''.obs;
  RxString transferMode = ''.obs;
  RxString amount = ''.obs;
  RxString benefAccNo = ''.obs;
  RxDouble totalAmount = 0.0.obs;

  static Box<MoneyTransferReport> report() =>
      Hive.box<MoneyTransferReport>(DatabaseConstants.dbMoneyTransferReport);

  @override
  void onInit() {
    super.onInit();
    transactionNo.value = arguments[AppStrings.txtTransactionId].toString();
    getDataFromLocalDB();
  }

  getDataFromLocalDB() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    List<MoneyTransferReport> listDB = box
        .get(DatabaseConstants.dbMoneyTransferReport)
        .toList()
        .cast<MoneyTransferReport>();
    List<MoneyTransferReport> dbList = listDB
        .where((element) => element.transactionId
            .toString()
            .contains(transactionNo.value.toString()))
        .toList();
    String dateReplace =
        dbList[0].transactionDate.toString().replaceAll('T', ' ');
    List<String> replaceList = dateReplace.split('+');
    DateTime changeDate = DateTime.parse(replaceList[0].toString());
    String transDate = DateFormat('yyyy-MM-dd').format(changeDate).toString();
    DateTime date = DateTime.parse(transDate);
    String dateFormat = DateFormat('dd-MM-yyyy').format(date).toString();
    benefName.value = dbList[0].benefAccName.toString();
    commissionFee.value = dbList[0].commissionAmount.toString();
    sgst.value = dbList[0].sgst.toString();
    cgst.value = dbList[0].cgst.toString();
    cess.value = dbList[0].cess.toString();
    transactionDate.value = dateFormat.toString();
    transferMode.value = dbList[0].transferMode.toString();
    amount.value = dbList[0].amount.toString();
    benefAccNo.value = dbList[0].benefAccNo.toString();
    totalAmount.value = double.parse(amount.value) +
        double.parse(commissionFee.value) +
        double.parse(sgst.value) +
        double.parse(cgst.value) +
        double.parse(cess.value);
  }

  void printReceipt() async {
    PrintReceipt().moneyTransferTransactionReceiptPrint(
        benefName.value,
        benefAccNo.value,
        transactionDate.value,
        transactionNo.value,
        transferMode.value,
        amount.value);
  }

  Future<bool> onBackPressed() async {
    Get.off(() => HomePage(), binding: HomeBinding());
    return false;
  }
}
