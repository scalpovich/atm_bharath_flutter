import 'dart:convert';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import '../../../constants/database_constants.dart';
import '../../../constants/date_time_constants.dart';
import '../../../helper/prefManager.dart';
import '../../../model/money_transfer/money_transfer.dart';
import '../../../model/money_transfer/money_transfer_report.dart';
import '../../../retrofit/api_service.dart';
import '../../../retrofit/apis.dart';
import '../../../retrofit/body.dart';
import '../../../retrofit/headers.dart';
import '../../../utils/aes_encryption.dart';
import '../../../utils/api_req_res_format.dart';
import '../../../utils/print_receipt.dart';
import '../../../utils/utils.dart';
import '../../../widgets/dialog_box_widget/snack_bar.dart';
import '../../../widgets/text_widget/text_widget.dart';
import '../fee_submit/money_transfer_fee_submit.dart';
import '../fee_submit/money_transfer_fee_submit_binding.dart';

class PaymentController extends MainController {
  dynamic arguments = Get.arguments;
  RxString genKey = ''.obs;
  String transferMode = '';
  TextEditingController amountController = TextEditingController();

  RxList<MoneyTransfer> moneyTransferList = <MoneyTransfer>[].obs;
  RxList<MoneyTransferReport> reportList = <MoneyTransferReport>[].obs;

  RxBool btnClicked = false.obs;

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  @override
  void onReady() {
    _bindingPrinter();
    super.onReady();
  }

  void submitAlertDialog() {
    Get.defaultDialog(
      title: '',
      content: TextWidget(
          text: 'details_submission_dialog'.tr,
          textColor: Theme.of(Get.context!).textTheme.subtitle1!.color!),
      confirm: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(Get.context!).primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color!,
                  width: 2.0,
                ),
              ),
            ),
          ),
          onPressed: () {
            btnClicked.value = true;
            Get.back();
            onTap();
          },
          child: TextWidget(
            text: 'submit'.tr,
            textColor: Theme.of(Get.context!).textTheme.bodyText1!.color!,
          )),
      cancel: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(Get.context!).textTheme.bodyText1!.color!,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(
                  color: Theme.of(Get.context!).primaryColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
          onPressed: () => Get.back(),
          child: TextWidget(
            text: 'cancel'.tr,
            textColor: Theme.of(Get.context!).primaryColor,
          )),
      barrierDismissible: true,
    );
  }

  void onTap() {
    PrintReceipt().moneyTransferReceiptPrint(
        arguments[AppStrings.txtBeneficiaryName],
        arguments[AppStrings.txtBenefAccNo],
        arguments[AppStrings.txtIFSCCode],
        arguments[AppStrings.txtPaymentMode],
        arguments[AppStrings.txtPurpose],
        amountController.text);
    onSubmit();
  }

  void onSubmit() async {
    // Get.back();
    String currentDate = DateFormat(DateTimeFormats.SERVER_DATE_TIME_FORMAT)
        .format(DateTime.now())
        .toString();
    String encryptedCusMob = await AesEncryption().encrypt(
        arguments[AppStrings.txtCustomerMobile],
        PrefManager().getCustomerCode.toString());
    String salt = Utils().getTraceId();
    String todayDate = DateTime.now().toString().trim();
    String dateReplaced1 = todayDate.replaceAll('-', '');
    String dateReplaced2 = dateReplaced1.replaceAll(':', '');
    String dateReplaced3 = dateReplaced2.replaceAll('.', '');
    String dateReplaced4 = dateReplaced3.replaceAll(' ', '');
    int id = int.parse(dateReplaced4.replaceRange(0, 10, ''));
    genKey.value =
        PrefManager().getDeviceId.toString() + dateReplaced4.trim() + salt;
    MoneyTransferReport moneyTransferReport = MoneyTransferReport(
        transactionDate: currentDate,
        transactionId: id,
        commissionAmount: '0',
        sgst: '0',
        cgst: '0',
        cess: '0',
        status: 'Processing',
        type: 'F',
        amount: amountController.text,
        endCstmrMob: encryptedCusMob,
        endCstmrName: arguments[AppStrings.txtCustomerName],
        benefAccName: arguments[AppStrings.txtBeneficiaryName],
        benefAccNo: arguments[AppStrings.txtBenefAccNo],
        benfIfsc: arguments[AppStrings.txtIFSCCode],
        transferMode: arguments[AppStrings.txtPaymentMode],
        statusFlag: 'N',
        traceId: genKey.value);
    await saveToLocalDB(moneyTransferReport);
    dynamic header = await addTransactionHeader(genKey.value);
    dynamic body = await addTransactionBody(
        cusMob: arguments[AppStrings.txtCustomerMobile],
        cusName: arguments[AppStrings.txtCustomerName],
        benefName: arguments[AppStrings.txtBeneficiaryName],
        benefAccNo: arguments[AppStrings.txtBenefAccNo],
        ifscCode: arguments[AppStrings.txtIFSCCode],
        amount: amountController.text,
        purpose: arguments[AppStrings.txtPurposeId],
        mode: arguments[AppStrings.txtPaymentMode]);

    final jsonBody = json.encode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody, PrefManager().getDeviceId! + PrefManager().getCustomerCode!);
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    bool submitted = await submitTransaction(reqBody, header);
    if (submitted) {
      Get.to(() => const MoneyTransferFeeSubmit(),
          arguments: {
            AppStrings.txtTransactionId: moneyTransferList[0].transactionId,
          },
          binding: MoneyTransferFeeSubmitBinding());
      amountController.clear();
    }
  }

  Future<bool> submitTransaction(dynamic body, dynamic header) async {
    dynamic result = await ApiService().postMethod(
        body,
        header,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.SUBMIT);
    if (result != null) {
      if (result.status!) {
        dynamic dataResult = result.data;
        final moneyTransferData = MoneyTransfer.fromJson(dataResult);
        String encryptedCusMob = await AesEncryption().encrypt(
            arguments[AppStrings.txtCustomerMobile],
            PrefManager().getCustomerCode.toString());
        MoneyTransferReport moneyTransferReport = MoneyTransferReport(
            transactionId:
                int.parse(moneyTransferData.transactionId.toString()),
            transactionDate: Utils()
                .parseDBDateTime(moneyTransferData.transactionDate.toString()),
            commissionAmount: moneyTransferData.commisionFees,
            status: moneyTransferData.status,
            type: moneyTransferData.isFee,
            cess: moneyTransferData.cess,
            cgst: moneyTransferData.cgst,
            sgst: moneyTransferData.sgst,
            benefAccName: arguments[AppStrings.txtBeneficiaryName],
            transferMode: arguments[AppStrings.txtPaymentMode],
            amount: amountController.text,
            endCstmrName: arguments[AppStrings.txtCustomerName],
            endCstmrMob: encryptedCusMob,
            benefAccNo: arguments[AppStrings.txtBenefAccNo],
            benfIfsc: arguments[AppStrings.txtIFSCCode],
            tranType: 'moneytrf',
            traceId: genKey.value,
            statusFlag: 'Y');
        moneyTransferList.add(moneyTransferData);
        updateLocalDBData(moneyTransferReport);
        btnClicked.value = false;
        return true;
      } else {
        btnClicked.value = false;
        commonSnackBar(result.message!);
        return false;
      }
    } else {
      btnClicked.value = false;
      commonSnackBar('error_network_timeout'.tr);
      return false;
    }
  }

  Future<void> saveToLocalDB(MoneyTransferReport moneyTransferReport) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool reportIsEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbMoneyTransferReport);
    if (reportIsEmpty) {
      List<MoneyTransferReport> report = box
          .get(DatabaseConstants.dbMoneyTransferReport)
          .toList()
          .cast<MoneyTransferReport>();
      reportList.addAll(report);
      reportList.add(moneyTransferReport);
      box.put(DatabaseConstants.dbMoneyTransferReport, reportList.toList());
    } else {
      reportList.add(moneyTransferReport);
      box.put(DatabaseConstants.dbMoneyTransferReport, reportList.toList());
    }
  }

  void updateLocalDBData(MoneyTransferReport moneyTransferReport) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    List<MoneyTransferReport> report = box
        .get(DatabaseConstants.dbMoneyTransferReport)
        .toList()
        .cast<MoneyTransferReport>();
    reportList.clear();
    reportList.addAll(report);
    reportList.add(moneyTransferReport);
    box.put(DatabaseConstants.dbMoneyTransferReport, reportList.toList());
    PrefManager().setWalletMoney(moneyTransferReport.walletAmount.toString());
  }

  void onPayTap() {
    checkPaymentValidation();
  }

  void onTextDelete() {
    List<String> amountList = amountController.text.split('');
    amountList.removeLast();
    amountController.value = TextEditingValue(text: amountList.join(''));
  }

  @override
  void onInit() {
    transferMode = arguments[AppStrings.txtPaymentMode];
    super.onInit();
  }

  void checkPaymentValidation() {
    if (amountController.text.isNotEmpty) {
      if (transferMode == 'RTGS' &&
          (double.parse(amountController.text) > 2000000)) {
        commonSnackBar('rtgs_amount_max_amount_toast'.tr);
      } else if (transferMode == 'RTGS' &&
          (double.parse(amountController.text) < 200000)) {
        commonSnackBar('rtgs_amount_min_amount'.tr);
      } else if (transferMode == 'NEFT' &&
          (double.parse(amountController.text) > 2000000)) {
        commonSnackBar('neft_amount_max_amount_toast'.tr);
      } else if (transferMode == 'IMPS' &&
          (double.parse(amountController.text) > 200000)) {
        commonSnackBar('imps_amount_max_amount_toast'.tr);
      } else {
        submitAlertDialog();
      }
    } else {
      commonSnackBar('amount_required'.tr);
    }
  }

  @override
  void onClose() {
    amountController.clear();
    super.onClose();
  }
}
