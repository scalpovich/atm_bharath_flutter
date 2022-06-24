import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/pages/money_transfer/add_transaction/money_transfer_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/add_transaction/money_transfer_page.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MoneyTransferReportSummaryController extends MainController {
  dynamic arguments = Get.arguments;
  RxString transactionId = ''.obs;
  RxString transactionDate = ''.obs;
  RxString senderName = ''.obs;
  RxString senderMobile = ''.obs;
  RxString accountNo = ''.obs;
  RxString ifsc = ''.obs;
  RxString mode = ''.obs;
  RxString amount = ''.obs;
  RxString fee = ''.obs;
  RxString status = ''.obs;
  RxString benefName = ''.obs;

  @override
  void onInit() {
    getDataFromDB(transactionId.value);
    super.onInit();
  }

  getDataFromDB(String id) async {
    String replaceDate = arguments[AppStrings.txtTransactionDate]
        .toString()
        .replaceAll('T', ' ');
    DateTime date = DateTime.parse(replaceDate);
    String transDate = DateFormat('dd-MM-yyyy').format(date).toString();
    transactionId.value = arguments[AppStrings.txtTransactionNo];
    transactionDate.value = transDate;
    senderName.value = arguments[AppStrings.txtSenderName];
    senderMobile.value = await decryptMobileNo();
    accountNo.value = arguments[AppStrings.txtAccount];
    ifsc.value = arguments[AppStrings.txtIFSCCode];
    mode.value = arguments[AppStrings.txtTransferMode];
    amount.value = arguments[AppStrings.txtAmount];
    fee.value = arguments[AppStrings.txtFees];
    status.value = arguments[AppStrings.txtStatus];
    benefName.value = arguments[AppStrings.txtBeneficiaryName];
  }

  Future<String> decryptMobileNo() async {
    String mobileNo = await AesEncryption().decrypt(
        arguments[AppStrings.txtSenderMobile].toString(),
        PrefManager().getCustomerCode.toString());
    return mobileNo;
  }

  void onRepeatTap() async {
    Get.to(() => const MoneyTransferPage(),
        binding: MoneyTransferBinding(),
        arguments: {
          AppStrings.txtSenderName: senderName.value,
          AppStrings.txtBeneficiaryName: benefName.value,
          AppStrings.txtBenefAccNo: accountNo.value,
          AppStrings.txtIFSCCode: ifsc.value,
        });
  }
}
