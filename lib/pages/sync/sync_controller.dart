import 'dart:async';
import 'dart:convert';
import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/bbps/biller.dart';
import 'package:atm_flutter_app/model/money_transfer/bank_name.dart';
import 'package:atm_flutter_app/model/bbps/bbps_report.dart';
import 'package:atm_flutter_app/model/bbps/circle.dart';
import 'package:atm_flutter_app/model/door_step/door_step_report.dart';
import 'package:atm_flutter_app/model/money_transfer/money_transfer_report.dart';
import 'package:atm_flutter_app/model/money_transfer/purpose.dart';
import 'package:atm_flutter_app/model/qr/qr_report.dart';
import 'package:atm_flutter_app/pages/home/home_binding.dart';
import 'package:atm_flutter_app/pages/home/home_page.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/body.dart';
import 'package:atm_flutter_app/retrofit/headers.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/api_req_res_format.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import '../../widgets/button_widget/button_widget.dart';
import '../../widgets/text_widget/text_widget.dart';

class SyncController extends MainController {
  RxList<int> servicesList = <int>[].obs;
  RxString percentValue = '0'.obs;

  int duration = int.parse(PrefManager().getSyncDuration.toString());
  late DateTime fromDate;

  RxBool btnClicked = false.obs;

  RxList<MoneyTransferReport> moneyTransferReportList =
      <MoneyTransferReport>[].obs;
  RxList<BBPSReport> bbpsReportList = <BBPSReport>[].obs;
  RxList<QRReport> qrReportList = <QRReport>[].obs;
  RxList<DoorStepReports> doorStepReportList = <DoorStepReports>[].obs;
  RxList<Biller> billerList = <Biller>[].obs;
  RxList<Circle> circleList = <Circle>[].obs;
  RxList<BankName> bankList = <BankName>[].obs;
  RxList<Purpose> purposeList = <Purpose>[].obs;
  RxInt progress = 0.obs;
  RxDouble percent = 0.0.obs;
  RxString reportSynced = AppStrings.txtSyncing.obs;
  RxString bbpsReportSynced = AppStrings.txtSyncing.obs;
  RxString qrReportSynced = AppStrings.txtSyncing.obs;
  RxString doorStepReportSynced = AppStrings.txtSyncing.obs;
  RxString bankSynced = AppStrings.txtSyncing.obs;
  RxString purposeSynced = AppStrings.txtSyncing.obs;
  RxString billerCircleSynced = AppStrings.txtSyncing.obs;
  RxBool doorStepUser = false.obs;
  RxBool btnVisibility = false.obs;

  double getPercentage(int progress) {
    int max = servicesList.length;
    percent.value = (progress / max) * 100;
    String perc = percent.value.toString();
    List<String> value = perc.split('.');
    int percentage = int.parse(value[0]);
    percentValue.value = percentage.toString();
    percent.value = percent.value / 100;
    buttonVisibility();
    return percent.value;
  }

  ///getting user available service list
  void getServiceList() async {
    if (PrefManager().getBBPS!) {
      _syncBillerAndCircle();
      _syncBBPSReport();
      servicesList.addAll([1, 2]);
    }
    if (PrefManager().getMoneyTransfer!) {
      _syncMoneyTransferReport();
      _syncBank();
      _syncPurpose();
      servicesList.addAll([3, 4, 5]);
    }
    if (PrefManager().getQR!) {
      _syncQRReport();
      servicesList.add(6);
    }
    if (PrefManager().getUserType == AppStrings.txtDriver) {
      if (PrefManager().getDoorStep!) {
        doorStepUser.value = true;
        _syncDoorStepReport();
        servicesList.add(7);
      }
    }
  }

  ///money transfer report api calling
  _syncMoneyTransferReport() async {
    dynamic body = await syncReportBody(
        startDate: fromDate, endDate: DateTime.now(), sync: 'Y');
    final jsonBody = json.encode(body);
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
        Apis.REPORT_LIST);
    if (result != null) {
      dynamic dataResult = result.data;
      if (result.status!) {
        final jsonEncoded = json.encode(dataResult);
        final jsonDecoded = json.decode(jsonEncoded);
        final reportsData = MoneyTransferReports.fromJson(jsonDecoded);
        dynamic reportResult = reportsData.report;
        if (reportResult.isNotEmpty) {
          for (int i = 0; i < reportResult.length; i++) {
            final jsonEncode = json.encode(reportResult[i]);
            final jsonDecode = json.decode(jsonEncode);
            final reportData = MoneyTransferReport.fromJson(jsonDecode);
            moneyTransferReportList.add(reportData);
          }
          await _checkMoneyTransferReportBox(moneyTransferReportList);
          reportSynced.value = AppStrings.txtSynced;
          progress.value = progress.value + 1;
          getPercentage(progress.value);
        }
      } else {
        ///snackBar
        reportSynced.value = AppStrings.txtSync;
        commonSnackBar(result.message!);
      }
    } else {
      ///snackBar
      reportSynced.value = AppStrings.txtSync;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///checking local db is there data in money transfer report and clearing data
  Future<void> _checkMoneyTransferReportBox(
      List<MoneyTransferReport> report) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool tableIsNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbMoneyTransferReport);
    if (tableIsNotEmpty) {
      await box.delete(DatabaseConstants.dbReports);
      await _addToMoneyTransferReportList(report);
    } else {
      await _addToMoneyTransferReportList(report);
    }
  }

  ///adding money transfer report data to local db
  Future<void> _addToMoneyTransferReportList(
      List<MoneyTransferReport> report) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    box.put(DatabaseConstants.dbMoneyTransferReport, report);
  }

  ///BBPS report api calling
  _syncBBPSReport() async {
    dynamic body = await syncReportBody(
        startDate: fromDate, endDate: DateTime.now(), sync: 'Y');
    final jsonBody = json.encode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody, PrefManager().getDeviceId! + PrefManager().getCustomerCode!);
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    final result = await ApiService().postMethod(
        reqBody,
        commonHeader,
        PrefManager().getDeviceId! + PrefManager().getCustomerCode!,
        Apis.BBPS_REPORTS);
    if (result != null) {
      if (result.status!) {
        dynamic dataResult = result.data;
        final jsonEncoded = json.encode(dataResult);
        final jsonDecoded = json.decode(jsonEncoded);
        final reportData = BBPSReports.fromJson(jsonDecoded);
        dynamic reportResult = reportData.report;
        for (int i = 0; i < reportResult.length; i++) {
          final jsonEncode = json.encode(reportResult[i]);
          final jsonDecode = json.decode(jsonEncode);
          final reportData = BBPSReport.fromJson(jsonDecode);
          bbpsReportList.add(reportData);
        }
        await _checkBBPSReportBox(bbpsReportList);
        bbpsReportSynced.value = AppStrings.txtSynced;
        progress.value = progress.value + 1;
        getPercentage(progress.value);
      } else {
        ///snackBar
        bbpsReportSynced.value = AppStrings.txtSync;
        commonSnackBar(result.message!);
      }
    } else {
      ///snackBar
      bbpsReportSynced.value = AppStrings.txtSync;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///checking local db is there data in money transfer report and clearing data
  Future<void> _checkBBPSReportBox(List<BBPSReport> bbpsReport) async {
    Box box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool tableIsNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbBBPSReports);
    if (tableIsNotEmpty) {
      await box.delete(DatabaseConstants.dbBBPSReports);
      await _addToBBPSReportList(bbpsReport);
    } else {
      await _addToBBPSReportList(bbpsReport);
    }
  }

  ///adding BBPS report data to local db
  Future<void> _addToBBPSReportList(List<BBPSReport> bbpsReport) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    await box.put(DatabaseConstants.dbBBPSReports, bbpsReport);
  }

  ///QR report api calling
  _syncQRReport() async {
    dynamic body = await syncReportBody(
        startDate: fromDate, endDate: DateTime.now(), sync: 'Y');
    final jsonBody = json.encode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody, PrefManager().getDeviceId! + PrefManager().getCustomerCode!);
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    final result = await ApiService().postMethod(
        reqBody,
        commonHeader,
        PrefManager().getDeviceId! + PrefManager().getCustomerCode!,
        Apis.QR_REPORT);
    if (result != null) {
      if (result.status!) {
        dynamic dataResult = result.data;
        final jsonEncoded = json.encode(dataResult);
        final jsonDecoded = json.decode(jsonEncoded);
        final reportData = QRReports.fromJson(jsonDecoded);
        dynamic reportResult = reportData.report;
        for (int i = 0; i < reportResult.length; i++) {
          final jsonEncode = json.encode(reportResult[i]);
          final jsonDecode = json.decode(jsonEncode);
          final reportData = QRReport.fromJson(jsonDecode);
          qrReportList.add(reportData);
        }
        await _checkQRReportBox(qrReportList);
        qrReportSynced.value = AppStrings.txtSynced;
        progress.value = progress.value + 1;
        getPercentage(progress.value);
      } else {
        ///snackBar
        qrReportSynced.value = AppStrings.txtSync;
        commonSnackBar(result.message!);
      }
    } else {
      ///snackBar
      qrReportSynced.value = AppStrings.txtSync;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///checking local db is there data in money transfer report and clearing data
  Future<void> _checkQRReportBox(List<QRReport> qrReport) async {
    Box box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool tableIsNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbQRReports);
    if (tableIsNotEmpty) {
      await box.delete(DatabaseConstants.dbQRReports);
      await _addToQRReportList(qrReport);
    } else {
      await _addToQRReportList(qrReport);
    }
  }

  ///adding QR report data to local db
  Future<void> _addToQRReportList(List<QRReport> qrReport) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    box.put(DatabaseConstants.dbQRReports, qrReport);
  }

  ///DoorStep report api calling
  _syncDoorStepReport() async {
    dynamic body = await syncReportBody(
        startDate: fromDate, endDate: DateTime.now(), sync: 'Y');
    final jsonBody = json.encode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody, PrefManager().getDeviceId! + PrefManager().getDriverCode!);
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    final result = await ApiService().postMethod(
        reqBody,
        doorStepHeader,
        PrefManager().getDeviceId! + PrefManager().getDriverCode!,
        Apis.DS_ORDER_REPORT);
    if (result != null) {
      if (result.status!) {
        dynamic dataResult = result.data;
        for (int i = 0; i < dataResult.length; i++) {
          final jsonEncode = json.encode(dataResult[i]);
          final jsonDecode = json.decode(jsonEncode);
          final reportData = DoorStepReports.fromJson(jsonDecode);
          doorStepReportList.add(reportData);
        }
        await _checkDoorStepReportBox(doorStepReportList);
        doorStepReportSynced.value = AppStrings.txtSynced;
        progress.value = progress.value + 1;
        getPercentage(progress.value);
      } else {
        ///snackBar
        doorStepReportSynced.value = AppStrings.txtSync;
        commonSnackBar(result.message!);
      }
    } else {
      ///snackBar
      doorStepReportSynced.value = AppStrings.txtSync;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///checking local db is there data in money transfer report and clearing data
  Future<void> _checkDoorStepReportBox(
      List<DoorStepReports> doorStepReports) async {
    Box box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool tableIsNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbDoorstepReports);
    if (tableIsNotEmpty) {
      await box.delete(DatabaseConstants.dbDoorstepReports);
      await _addToDoorSTepReportList(doorStepReports);
    } else {
      await _addToDoorSTepReportList(doorStepReports);
    }
  }

  ///adding DoorStep report data to local db
  Future<void> _addToDoorSTepReportList(
      List<DoorStepReports> doorStepReports) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    box.put(DatabaseConstants.dbDoorstepReports, doorStepReports);
  }

  ///BBPS biller and circle api calling
  _syncBillerAndCircle() async {
    final result = await ApiService().getMethod(
        commonHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.BILLER_CIRCLE);
    if (result != null) {
      dynamic dataResult = result.data;
      if (result.status!) {
        dynamic biller = Circles.fromJson(dataResult);
        dynamic billerResult = biller.biller;
        dynamic circleResult = biller.circle;
        for (int i = 0; i < billerResult.length; i++) {
          final jsonEncode = json.encode(billerResult[i]);
          final jsonDecode = json.decode(jsonEncode);
          dynamic reportData = Biller.fromJson(jsonDecode);
          if (reportData != null) {
            billerList.add(reportData);
          }
        }
        await _checkBillerBox(billerList);
        for (int j = 0; j < circleResult.length; j++) {
          final jsonEncode = json.encode(circleResult[j]);
          final jsonDecode = json.decode(jsonEncode);
          dynamic reportData = Circle.fromJson(jsonDecode);
          if (reportData != null) {
            circleList.add(reportData);
          }
        }
        await _checkCircleBox(circleList);
        billerCircleSynced.value = AppStrings.txtSynced;
        progress.value = progress.value + 1;
        getPercentage(progress.value);
      } else {
        ///snackBar
        billerCircleSynced.value = AppStrings.txtSync;
        commonSnackBar(result.message!);
      }
    } else {
      ///snackBar
      billerCircleSynced.value = AppStrings.txtSync;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///checking local db is there data in money transfer report and clearing data
  Future<void> _checkBillerBox(List<Biller> biller) async {
    Box box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool tableIsNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbOperator);
    if (tableIsNotEmpty) {
      await box.delete(DatabaseConstants.dbOperator);
      await _addToBillerList(biller);
    } else {
      await _addToBillerList(biller);
    }
  }

  ///adding BBPs biller to local db
  Future<void> _addToBillerList(List<Biller> biller) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    box.put(DatabaseConstants.dbOperator, biller);
  }

  ///checking local db is there data in money transfer report and clearing data
  Future<void> _checkCircleBox(List<Circle> circle) async {
    Box box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool tableIsNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbCircle);
    if (tableIsNotEmpty) {
      await box.delete(DatabaseConstants.dbCircle);
      _addToCircleList(circle);
    } else {
      _addToCircleList(circle);
    }
  }

  ///adding BBPS circle to local db
  Future<void> _addToCircleList(List<Circle> circle) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    box.put(DatabaseConstants.dbCircle, circle);
  }

  ///Money transfer Bank list api calling
  _syncBank() async {
    final result = await ApiService().getMethod(
        commonHeader,
        PrefManager().getDeviceId! + PrefManager().getCustomerCode!,
        Apis.SEARCH_BANK);
    if (result != null) {
      if (result.status!) {
        dynamic dataResult = result.data;
        if (dataResult.isNotEmpty) {
          for (int i = 0; i < dataResult.length; i++) {
            final jsonEncode = json.encode(dataResult[i]);
            final jsonDecode = json.decode(jsonEncode);
            dynamic reportData = BankName.fromJson(jsonDecode);
            bankList.add(reportData);
          }
          await _checkBankBox(bankList);
          bankSynced.value = AppStrings.txtSynced;
          progress.value = progress.value + 1;
          getPercentage(progress.value);
        } else {
          bankSynced.value = AppStrings.txtSynced;
        }
      } else {
        bankSynced.value = AppStrings.txtSync;
        commonSnackBar(result.message!);
      }
    } else {
      bankSynced.value = AppStrings.txtSync;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///checking local db is there data in money transfer report and clearing data
  Future<void> _checkBankBox(List<BankName> bankName) async {
    Box box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool tableIsNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbBankList);
    if (tableIsNotEmpty) {
      await box.delete(DatabaseConstants.dbBankList);
      await _addToBankList(bankName);
    } else {
      await _addToBankList(bankName);
    }
  }

  ///adding bank list to local db
  Future<void> _addToBankList(List<BankName> bankName) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    box.put(DatabaseConstants.dbBankList, bankName);
  }

  ///Purpose api calling
  _syncPurpose() async {
    final result = await ApiService().getMethod(
        commonHeader,
        PrefManager().getDeviceId! + PrefManager().getCustomerCode!,
        Apis.PURPOSE);
    if (result != null) {
      dynamic dataResult = result.data;
      if (result.status!) {
        for (int i = 0; i < dataResult.length; i++) {
          final jsonEncode = json.encode(dataResult[i]);
          final jsonDecode = json.decode(jsonEncode);
          dynamic reportData = Purpose.fromJson(jsonDecode);
          purposeList.add(reportData);
        }
        await _checkPurposeBox(purposeList);
        purposeSynced.value = AppStrings.txtSynced;
        progress.value = progress.value + 1;
        getPercentage(progress.value);
      } else {
        ///snackBar
        purposeSynced.value = AppStrings.txtSync;
        commonSnackBar(result.message!);
      }
    } else {
      ///snackBar
      purposeSynced.value = AppStrings.txtSync;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///checking local db is there data in money transfer report and clearing data
  Future<void> _checkPurposeBox(List<Purpose> purpose) async {
    Box box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool tableIsNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbPurpose);
    if (tableIsNotEmpty) {
      await box.delete(DatabaseConstants.dbPurpose);
      await _addToPurposeList(purpose);
    } else {
      await _addToPurposeList(purpose);
    }
  }

  ///adding purpose list data to local db
  Future<void> _addToPurposeList(List<Purpose> purpose) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    box.put(DatabaseConstants.dbPurpose, purpose);
  }

  @override
  void onReady() {
    fromDate = DateTime(
      DateTime.now().year,
      DateTime.now().month - duration,
      1,
    );
    Timer(const Duration(seconds: 1), getServiceList);
    super.onReady();
  }

  ///visible done button sync completed
  void buttonVisibility() {
    if (percentValue.value == '100') {
      PrefManager().setSyncFlag(true);
      btnVisibility.value = true;
    }
  }

  ///navigate to home page when done button clicked
  void onTap() {
    Get.to(() => HomePage(), binding: HomeBinding());
  }

  void cancelDialog() {
    Get.defaultDialog(
        title: '',
        content: TextWidget(
            text: 'data_sync_cancel'.tr,
            textColor: Theme.of(Get.context!).textTheme.subtitle1!.color!),
        cancel: ButtonWidget(
          label: 'cancel'.tr,
          width: 100,
          clicked: false,
          btnColor: Theme.of(Get.context!).primaryColor,
          onTap: Get.back,
        ),
        confirm: ButtonWidget(
          label: 'exit'.tr,
          width: 100,
          btnColor: Theme.of(Get.context!).primaryColor,
          clicked: false,
          onTap: onTap,
        ));
  }
}
