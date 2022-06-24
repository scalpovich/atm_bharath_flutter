import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/qr/qr_status.dart';
import 'package:atm_flutter_app/pages/qr_code/report_details/qr_code_report_summary_binding.dart';
import 'package:atm_flutter_app/pages/qr_code/report_details/qr_code_report_summary_page.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/body.dart';
import 'package:atm_flutter_app/retrofit/headers.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/api_req_res_format.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:atm_flutter_app/utils/print_receipt.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../../model/qr/qr_report.dart';

class QRCodeController extends MainController {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController invoiceNoController = TextEditingController();
  final TextEditingController invoiceNameController = TextEditingController();
  final TextEditingController gstInController = TextEditingController();
  final TextEditingController gstController = TextEditingController(text: '0');
  final TextEditingController cgstController = TextEditingController(text: '0');
  final TextEditingController sgstController = TextEditingController(text: '0');
  final TextEditingController igstController = TextEditingController(text: '0');
  final TextEditingController cessController = TextEditingController(text: '0');
  final TextEditingController gstIncentiveController =
      TextEditingController(text: '0');
  final TextEditingController gstPctController =
      TextEditingController(text: '0');

  RxBool amountValidate = true.obs;

  RxBool isExpanded = false.obs;
  final walletAmount = ''.obs;
  RxBool btnClicked = false.obs;
  RxString transactionId = ''.obs;
  RxString transactionDate = ''.obs;

  int qrTime = int.parse(PrefManager().getQRTimeout.toString());
  RxInt time = 0.obs;
  RxString invoiceDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

  late Duration countdownDuration;
  Duration duration = const Duration();
  Timer? timer, timer2;
  bool countDown = true;
  GlobalKey<ScaffoldState> globalKey = GlobalKey();

  ///go to next page
  void goToDetailsPage() {
    Get.off(() => QRCodeReportSummaryPage(),
        binding: QRCodeReportSummaryBinding(),
        arguments: {
          AppStrings.txtInvoiceName: invoiceNameController.text,
          AppStrings.txtAmount: amountController.text,
          AppStrings.txtGST: gstController.text,
          AppStrings.txtTransactionId: transactionId.value,
          AppStrings.txtGSTIn: gstInController.text,
          AppStrings.txtGSTIncentive: gstIncentiveController.text,
          AppStrings.txtSGST: sgstController.text,
          AppStrings.txtIGST: igstController.text,
          AppStrings.txtCGSt: cgstController.text,
          AppStrings.txtCESS: cessController.text,
          AppStrings.txtGSTPCT: gstPctController.text,
          AppStrings.txtInvoiceDate: invoiceDate.value,
          AppStrings.txtStatus: 'PENDING',
          AppStrings.txtInvoiceNo: invoiceNoController.text,
          'home': true,
        });
    clearTextFields();
  }

  ///generating qr code
  Future<void> generateQrCode(dynamic body, dynamic header) async {
    dynamic result = await ApiService().postMethod(
        body,
        header,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.QR_CODE_GENERATOR);
    if (result != null) {
      if (result!.status!) {
        dynamic dataResult = result.data;
        startTimer();
        qrCodeDialog(dataResult);
      } else {
        commonSnackBar(result.message!);
      }
    } else {
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///getting qr code status from server
  getQRCodeStatus(dynamic body) async {
    dynamic result = await ApiService().postMethod(
        body,
        commonHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.QR_CHECK_STATUS);
    if (result != null) {
      if (result.status!) {
        dynamic dataResult = result.data;
        return dataResult;
      }
    } else {
      return '';
    }
  }

  textValidate() {
    if (!amountController.text.isNotEmpty) {
      amountValidate.value = false;
    } else {
      amountValidate.value = true;
      btnClicked.value = true;
      generateQr();
    }
  }

  void generateQr() async {
    if (amountController.text.isNotEmpty) {}
    String invoiceDt = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String date = DateFormat('yyyy-MM-ddTHH:mm:ss')
        .format(DateTime.now())
        .toString()
        .trim();
    String dateTime = date.replaceAll(':', '');
    dateTime = dateTime.replaceAll('T', '');
    dateTime = dateTime.replaceAll('-', '');
    transactionId.value =
        PrefManager().getCustomerCode.toString() + '-' + '3' + '-' + dateTime;
    transactionDate.value = date;
    QRReport qrReport = QRReport(
        transactionId: transactionId.value,
        transactionDate: transactionDate.value,
        status: 'PENDING',
        payerName: 'NA',
        statusDescription: '',
        invoiceNo: invoiceNoController.text,
        invoiceName: invoiceNameController.text,
        invoiceDate: invoiceDate.value,
        amount: amountController.text,
        sgst: num.parse(sgstController.text),
        cess: num.parse(cessController.text),
        cgst: num.parse(cgstController.text),
        igst: num.parse(igstController.text),
        gst: num.parse(gstController.text),
        gstIn: gstInController.text,
        gstIncentive: num.parse(gstIncentiveController.text),
        gstPct: num.parse(gstPctController.text));
    await saveToDB(qrReport);
    dynamic body = await qrCodeGenerateBody(
        transactionId: transactionId.value,
        transactionDate: transactionDate.value,
        amount: amountController.text,
        sgst: sgstController.text,
        cess: cessController.text,
        cgst: cgstController.text,
        igst: igstController.text,
        gst: gstController.text,
        gstIn: gstInController.text,
        gstIncentive: gstIncentiveController.text,
        gstPct: gstPctController.text,
        invoiceDate: invoiceDt.toString(),
        invoiceName: invoiceNameController.text,
        invoiceNo: invoiceNoController.text);
    final jsonBody = json.encode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    await generateQrCode(reqBody, commonHeader);
    btnClicked.value = false;
  }

  ///qr code dialog
  void qrCodeDialog(String data) {
    startTimer();
    Get.defaultDialog(
        title: '',
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            data != ''
                ? RepaintBoundary(
                    key: globalKey,
                    child: QrImage(
                      data: data,
                      size: 200,
                      embeddedImage: const AssetImage(
                          AppDrawable.filePath + AppDrawable.qrEmbedLogo),
                      backgroundColor: Colors.white,
                    ),
                  )
                : const SizedBox(
                    width: 50,
                    height: 50,
                  ),
            const Image(
              image: AssetImage(AppDrawable.filePath + AppDrawable.loading),
              width: 30,
              height: 30,
            ),
            Obx(
              () => TextWidget(
                  text: time.value.toString(),
                  textColor: Theme.of(Get.context!).primaryColor),
            ),
          ],
        ),
        cancel: ButtonWidget(
          clicked: false,
          label: 'Cancel',
          btnColor: Theme.of(Get.context!).primaryColor,
          width: 100,
          onTap: () {
            Get.back();
          },
        ),
        confirm: ButtonWidget(
          clicked: false,
          label: 'Print',
          btnColor: Theme.of(Get.context!).primaryColor,
          width: 100,
          onTap: () => getWidgetImage(),
        ));
    timer2 = Timer.periodic(const Duration(seconds: 5), (timer2) {
      getQRStatus(timer2);
    });
  }

  ///getting qr status
  void getQRStatus(Timer timer) async {
    dynamic body = {AppStrings.txtTransactionId: transactionId.value};
    final jsonBody = json.encode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    dynamic result = await ApiService().postMethod(
        reqBody,
        commonHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.QR_CHECK_STATUS);
    if (result != null) {
      if (result!.status!) {
        dynamic dataResult = result.data;
        final jsonEncodeRes = jsonEncode(dataResult);
        final jsonDecodeRes = jsonDecode(jsonEncodeRes);
        final responseData = QrStatus.fromJson(jsonDecodeRes);
        QRReport qrReport = QRReport(
            transactionId: transactionId.value,
            transactionDate: transactionDate.value,
            status: responseData.status,
            payerName: responseData.payerName ?? 'NA',
            statusDescription: '',
            invoiceNo: invoiceNoController.text,
            invoiceName: invoiceNameController.text,
            invoiceDate: invoiceDate.value,
            amount: responseData.amount.toString(),
            sgst: num.parse(sgstController.text),
            cess: num.parse(cessController.text),
            cgst: num.parse(cgstController.text),
            igst: num.parse(igstController.text),
            gst: num.parse(gstController.text),
            gstIn: gstInController.text,
            gstIncentive: num.parse(gstIncentiveController.text),
            gstPct: num.parse(gstPctController.text));
        await updateDataFromDB(qrReport, transactionId);
        timer.cancel();
      } else {
        commonSnackBar(result.message!);
      }
    } else {
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  Future<void> updateDataFromDB(QRReport report, transactionId) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    dynamic list = box.get(DatabaseConstants.dbQRReports);
    if (list != null) {
      List<QRReport> reportList =
          box.get(DatabaseConstants.dbQRReports).toList().cast<QRReport>();
      final index = reportList.indexWhere((element) =>
          element.transactionId.toString().contains(transactionId));
      reportList.removeAt(index);
      reportList.add(report);
      box.put(DatabaseConstants.dbQRReports, reportList);
    } else {
      box.put(DatabaseConstants.dbQRReports, report);
    }
  }

  Future<void> saveToDB(QRReport reports) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    dynamic list = box.get(DatabaseConstants.dbQRReports);
    if (list != null) {
      List<QRReport> reportList =
          box.get(DatabaseConstants.dbQRReports).toList().cast<QRReport>();
      reportList.add(reports);
      box.put(DatabaseConstants.dbQRReports, reportList);
    } else {
      box.put(DatabaseConstants.dbQRReports, reports);
    }
  }

  @override
  void onClose() {
    super.onClose();
    stopTimer();
    clearTextFields();
  }

  void clearTextFields() {
    invoiceNameController.clear();
    invoiceNoController.clear();
    amountController.clear();
    gstInController.clear();
    gstController.value = const TextEditingValue(text: '0');
    cgstController.value = const TextEditingValue(text: '0');
    sgstController.value = const TextEditingValue(text: '0');
    igstController.value = const TextEditingValue(text: '0');
    cessController.value = const TextEditingValue(text: '0');
    gstIncentiveController.value = const TextEditingValue(text: '0');
    gstPctController.value = const TextEditingValue(text: '0');
  }

  @override
  void onInit() {
    super.onInit();
    _bindingPrinter();
    countdownDuration = Duration(seconds: qrTime);
    time.value = int.parse(countdownDuration.inSeconds.toString());
  }

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      timer = t;
      setCountDown();
    });
  }

  void stopTimer() {
    timer!.cancel();
    timer2!.cancel();
  }

  void setCountDown() {
    const reduceSeconds = 1;
    final seconds = countdownDuration.inSeconds - reduceSeconds;
    if (seconds == 0) {
      stopTimer();
      Get.back();
      goToDetailsPage();
    } else {
      countdownDuration = Duration(seconds: seconds);
      time.value = int.parse(countdownDuration.inSeconds.toString());
    }
  }

  void getWidgetImage() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      PrintReceipt().qrCodePrint(pngBytes, amountController.text);
    } catch (exception) {}
    return null;
  }
}
