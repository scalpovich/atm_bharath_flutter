import 'dart:convert';
import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/qr/qr_report.dart';
import 'package:atm_flutter_app/model/qr/qr_status.dart';
import 'package:atm_flutter_app/pages/qr_code/qr_code_generate/qr_code_binding.dart';
import 'package:atm_flutter_app/pages/qr_code/qr_code_generate/qr_code_generate_page.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/headers.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/api_req_res_format.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:atm_flutter_app/utils/print_receipt.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:get/get.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../home/home_binding.dart';
import '../../home/home_page.dart';

class QRCodeReportSummaryController extends MainController {
  RxBool isExpanded = false.obs;
  dynamic arguments = Get.arguments;
  RxString name = ''.obs;
  RxString amount = ''.obs;
  RxString invoiceNo = ''.obs;
  RxString invoiceDate = ''.obs;
  RxString invoiceName = ''.obs;
  RxString transactionNo = ''.obs;
  RxString transactionDate = ''.obs;
  RxString gst = '0'.obs;
  RxString gstIn = '0'.obs;
  RxString cess = '0'.obs;
  RxString cgst = '0'.obs;
  RxString sgst = '0'.obs;
  RxString igst = '0'.obs;
  RxString gstIncentive = '0'.obs;
  RxString gstPct = '0'.obs;
  RxString status = '0'.obs;
  RxBool btnClicked = false.obs;
  RxBool isLoading = false.obs;
  RxBool home = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bindingPrinter();
    getReportDetails();
  }

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  void getReportDetails() {
    name.value = arguments[AppStrings.txtInvoiceName];
    amount.value = arguments[AppStrings.txtAmount];
    invoiceNo.value = arguments[AppStrings.txtInvoiceNo];
    invoiceName.value = arguments[AppStrings.txtInvoiceName];
    invoiceDate.value = arguments[AppStrings.txtInvoiceDate];
    transactionNo.value = arguments[AppStrings.txtTransactionId];
    gst.value = arguments[AppStrings.txtGST] ?? '0';
    gstIn.value = arguments[AppStrings.txtGSTIn] ?? '0';
    cess.value = arguments[AppStrings.txtCESS] ?? '0';
    cgst.value = arguments[AppStrings.txtCGSt] ?? '0';
    sgst.value = arguments[AppStrings.txtSGST] ?? '0';
    igst.value = arguments[AppStrings.txtIGST] ?? '0';
    gstIncentive.value = arguments[AppStrings.txtGSTIncentive] ?? '0';
    gstPct.value = arguments[AppStrings.txtGSTPCT] ?? '0';
    status.value = arguments[AppStrings.txtStatus] ?? '0';
    home.value = arguments['home'];
    if (status.value == 'PENDING') {
      isLoading.value = true;
      getStatusFromApi();
    }
  }

  void onExpanded(bool value) {
    isExpanded.value = value;
  }

  void getStatusFromApi() async {
    dynamic body = {'transaction_id': transactionNo.value};
    final jsonBody = jsonEncode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    final result = await ApiService().postMethod(
        reqBody,
        commonHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.QR_CHECK_STATUS);
    isLoading.value = false;
    if (result != null) {
      if (result.status!) {
        final jsonEncode = json.encode(result.data!);
        final jsonDecode = json.decode(jsonEncode);
        final qrStatus = QrStatus.fromJson(jsonDecode);
        await updateQRStatus(qrStatus);
        status.value = qrStatus.status.toString();
      } else {
        commonSnackBar(result.message!);
      }
    } else {
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  Future<void> updateQRStatus(QrStatus qrStatus) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    List<QRReport> qrReportList =
        box.get(DatabaseConstants.dbQRReports).toList().cast<QRReport>();
    final index = qrReportList
        .indexWhere((element) => element.transactionId == transactionNo.value);
    final qrReport = QRReport(
        transactionDate: qrReportList[index].transactionDate,
        transactionId: qrReportList[index].transactionId,
        tranType: qrReportList[index].tranType,
        status: qrStatus.status,
        statusDescription: qrReportList[index].statusDescription,
        sgst: qrReportList[index].sgst,
        cess: qrReportList[index].cess,
        cgst: qrReportList[index].cgst,
        paymentChannel: qrReportList[index].paymentChannel,
        payerName: qrStatus.payerName,
        invoiceDate: qrReportList[index].invoiceDate,
        invoiceName: qrReportList[index].invoiceName,
        invoiceNo: qrReportList[index].invoiceNo,
        gstIncentive: qrReportList[index].gstIncentive,
        gstIn: qrReportList[index].gstIn,
        gstPct: qrReportList[index].gstPct,
        gst: qrReportList[index].gst,
        igst: qrReportList[index].igst,
        amount: qrReportList[index].amount);
    qrReportList.insert(index, qrReport);
    qrReportList.removeAt(index + 1);
    box.put(DatabaseConstants.dbQRReports, qrReportList);
  }

  void onRepeatTap() {
    Get.to(() => QRCodeGeneratePage(), binding: QRCodeBinding(), arguments: {
      AppStrings.txtAmount: amount.value,
    });
  }

  void printReceipt() {
    PrintReceipt().qrReceiptPrint(
        amount.value,
        invoiceName.value,
        invoiceNo.value,
        invoiceDate.value,
        gstIn.value,
        gst.value,
        cgst.value,
        igst.value,
        sgst.value,
        cess.value,
        gstIncentive.value,
        gstPct.value);
  }

  Future<bool> onBackPressed() async {
    if (home.value) {
      Get.off(() => HomePage(), binding: HomeBinding());
      return false;
    } else {
      Get.back();
      return false;
    }
  }
}
