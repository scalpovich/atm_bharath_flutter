import 'dart:async';
import 'dart:convert';
import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/model/money_transfer/money_transfer_status.dart';
import 'package:atm_flutter_app/model/money_transfer/money_transfer_transaction_id.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/money_transfer/money_transfer_report.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/headers.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/api_req_res_format.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../retrofit/body/common_body.dart';
import '../report_details/money_transfer_report_summary_binding.dart';
import '../report_details/money_transfer_report_summary_page.dart';

class MoneyTransferReportController extends MainController {
  final fromDate = ''.obs;
  final toDate = ''.obs;
  RxList<MoneyTransferReport> reportList = <MoneyTransferReport>[].obs;
  DateTime firstDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );
  RxString date = ''.obs;
  List<MoneyTransferReport> moneyTransferReportList = [];
  List<MoneyTransferReport> searchList = [];

  RxList<String> transactionIdList = <String>[].obs;
  TextEditingController searchController = TextEditingController();

  RxString searchText = ''.obs;

  RxDouble commission = 0.0.obs;
  RxDouble transaction = 0.0.obs;
  RxDouble fee = 0.0.obs;
  RxDouble walletRecharge = 0.0.obs;
  RxBool searchVisible = false.obs;
  late DateTime startDate;
  late DateTime endDate;
  late DateTime dbDateInterval;

  RxBool isLoading = true.obs;

  List<MoneyTransferReport> get users => reportList.toList();
  RxBool isLastPage = false.obs;

  final ScrollController scrollController = ScrollController();

  RxInt pageNumber = 1.obs;
  RxBool hasMoreReport = true.obs;
  RxBool loading = false.obs;
  int interval = int.parse(PrefManager().getSyncDuration.toString());

  @override
  void onInit() {
    super.onInit();
    date.value = firstDay.toString();
    dbDateInterval =
        DateTime(DateTime.now().year, DateTime.now().month - interval, 1);
    fromDate.value =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(firstDay).toString();
    toDate.value =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()).toString();
    setDate();
    if (!isLastPage.value) {
      scrollController.addListener(scrollMore);
    }
  }

  ///getting report data from either db or from server
  void setDate() async {
    startDate = DateFormat('yyyy-MM-dd').parse(fromDate.value);
    if (toDate.value == '') {
      toDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    }
    endDate = DateFormat('yyyy-MM-dd').parse(toDate.value);
    if (endDate.isAfter(startDate)) {
      if (startDate.isAfter(dbDateInterval)) {
        getReportDataFromDB(startDate, endDate);
      } else {
        getReportList(startDate, endDate, pageNumber.value, '');
      }
    } else {
      toDate.value = fromDate.value;
    }
  }

  ///getting report from db
  getReportDataFromDB(DateTime startDate, DateTime endDate) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool isTableNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbMoneyTransferReport);
    if (isTableNotEmpty) {
      isLoading.value = false;
      List<MoneyTransferReport> dbMoneyTransferReport = box
          .get(DatabaseConstants.dbMoneyTransferReport)
          .toList()
          .cast<MoneyTransferReport>();
      dynamic getReportList = dbMoneyTransferReport
          .where((element) =>
              (DateTime.parse(element.transactionDate!).isAfter(startDate) &&
                  DateTime.parse(element.transactionDate!)
                      .isBefore(endDate.add(const Duration(days: 1)))))
          .toList();
      addToReportList(getReportList);
      if (getReportList.isNotEmpty) {
        await getTraceIdList();
      } else {
        reportList.clear();
        reportList.value = [];
      }
    } else {
      isLoading.value = false;
      reportList.clear();
      reportList.value = [];
    }
  }

  addToReportList(List<MoneyTransferReport> getReportList) async {
    List<MoneyTransferReport> moneyTransferReportList = getReportList
        .where((element) => element.transactionId != null)
        .toList()
        .cast<MoneyTransferReport>();
    moneyTransferReportList
        .sort((b, a) => a.transactionId!.compareTo(b.transactionId!));
    if (getReportList.isNotEmpty) {
      reportList.clear();
      reportList.value = [];
      reportList.addAll(moneyTransferReportList);
      commission.value = totalCommission(getReportList);
      fee.value = totalFee(getReportList);
      transaction.value = totalTransaction(getReportList);
      walletRecharge.value = totalWalletRecharge(getReportList);
    } else {
      hasMoreReport.value = false;
    }
  }

  Future<void> getReportList(DateTime startDate, DateTime endDate, int pageNo,
      String searchText) async {
    isLoading.value = true;
    dynamic body = await commonReportBody(
        startDate: startDate,
        endDate: endDate,
        sync: 'N',
        pageNo: pageNo,
        searchText: searchText);
    final result = await ApiService().postMethod(
        body,
        commonHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.REPORT_LIST);
    if (result != null) {
      if (result.status!) {
        isLoading.value = false;
        dynamic dataResult = result.data;
        final jsonEncoded = json.encode(dataResult);
        final jsonDecoded = json.decode(jsonEncoded);
        final reportData = MoneyTransferReports.fromJson(jsonDecoded);
        dynamic reportResult = reportData.report;
        dynamic totalResult = reportData.total;
        if (reportResult.isNotEmpty) {
          for (int i = 0; i < reportResult.length; i++) {
            final jsonEncode = json.encode(reportResult[i]);
            final jsonDecode = json.decode(jsonEncode);
            final reportData = MoneyTransferReport.fromJson(jsonDecode);
            reportList.add(reportData);
          }
          for (int i = 0; i < totalResult.length; i++) {
            final jsonEncode = json.encode(totalResult[i]);
            final jsonDecode = json.decode(jsonEncode);
            final reportData = MoneyTransferReportTotal.fromJson(jsonDecode);
            if (reportData.serviceType == 'MONEYTRF') {
              transaction.value = transaction.value + reportData.totalTrnAmt!;
              commission.value = commission.value + reportData.totalCmsnAmt!;
            } else {
              transaction.value = transaction.value + reportData.totalTrnAmt!;
              fee.value = fee.value + reportData.totalCmsnAmt!;
            }
          }
          pageNumber.value++;
        } else {
          isLoading.value = false;
          hasMoreReport.value = false;
          isLastPage.value = true;
        }
      } else {
        isLoading.value = false;
        commonSnackBar(result.message!);
      }
    } else {
      isLastPage.value = true;
      isLoading.value = false;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  void scrollMore() async {
    if (scrollController.position.extentAfter == 0.0) {
      // getReportDataFromDB();
      getMoreReportFromApi(startDate, endDate, '');
    }
  }

  Future<void> getMoreReportFromApi(
      DateTime startDate, DateTime endDate, String searchText) async {
    if (hasMoreReport.value && !loading.value) {
      loading.value = true;
      await getReportList(startDate, endDate, pageNumber.value, searchText);
      loading.value = false;
    }
  }

  Future<void> getTraceIdList() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool list =
        await dbAccess.isTableEmpty(DatabaseConstants.dbMoneyTransferReport);
    if (list) {
      moneyTransferReportList = box
          .get(DatabaseConstants.dbMoneyTransferReport)
          .toList()
          .cast<MoneyTransferReport>();
      List<MoneyTransferReport> filteredList = moneyTransferReportList
          .where((element) => element.status.toString().contains('Processing'))
          .toList();
      for (int i = 0; i < filteredList.length; i++) {
        if (filteredList[i].statusFlag == 'N') {
          String traceId = filteredList[i].traceId.toString();
          await getTransactionIdFromApi(traceId, filteredList[i]);
          Log().logs(
              'transaction Id--', filteredList[i].transactionId.toString());
        } else {
          transactionIdList.add(filteredList[i].transactionId.toString());
        }
      }
      await getTransactionIdList();
      if (filteredList.isNotEmpty) {}
    } else {}
  }

  Future<void> getTransactionIdFromApi(
      String traceId, MoneyTransferReport report) async {
    dynamic body = {'traceid': traceId};
    final jsonBody = jsonEncode(body);
    String encryptBody = await AesEncryption().encrypt(
        jsonBody,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptBody);
    dynamic result = await ApiService().postMethod(
        reqBody,
        commonHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.GET_TRANSACTION_ID);
    isLoading.value = false;
    if (result != null) {
      if (result.status) {
        final jsonEncodeRes = jsonEncode(result.data);
        final jsonDecodeRes = jsonDecode(jsonEncodeRes);
        final responseData = MoneyTransferTransactionId.fromJson(jsonDecodeRes);
        MoneyTransferReport moneyTransferReport = MoneyTransferReport(
            tranType: report.tranType,
            transactionId: responseData.transactionId,
            transactionDate: report.transactionDate,
            statusDescription: report.statusDescription,
            fromName: report.fromName,
            fromAccount: report.fromAccount,
            benfIfsc: report.benfIfsc,
            benefAccNo: report.benefAccNo,
            benefAccName: report.benefAccName,
            traceId: report.traceId,
            transferMode: report.transferMode,
            amount: report.amount,
            convFee: report.convFee,
            cgst: report.cgst,
            sgst: report.sgst,
            commissionAmount: report.commissionAmount,
            type: report.type,
            paymentChannel: report.paymentChannel,
            cess: report.cess,
            serviceType: report.serviceType,
            endCstmrMob: report.endCstmrMob,
            endCstmrName: report.endCstmrName,
            paymentId: report.paymentId,
            parameterValue: report.parameterValue,
            parameterName: report.parameterName,
            billerId: report.billerId,
            billerName: report.billerName,
            bbpsRefNo: report.bbpsRefNo,
            isBillerBbps: report.isBillerBbps,
            status: 'PENDING',
            statusFlag: 'Y');
        await saveTransactionIdToDB(moneyTransferReport, traceId);
      } else {
        Log().logs('traceId22--', traceId);
        if (result.message! == 'No data found') {
          Log().logs('traceId--', traceId);
          await removeTransactionFromDb(traceId);
        }
        commonSnackBar(result.message!);
      }
    } else {
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  Future<void> removeTransactionFromDb(String traceId) async {
    Log().logs('traceId--', traceId);
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    dynamic list = box.get(DatabaseConstants.dbMoneyTransferReport);
    if (list != null) {
      final index = reportList
          .indexWhere((element) => element.traceId.toString() == traceId);
      reportList.removeAt(index);
      box.put(DatabaseConstants.dbMoneyTransferReport, reportList.toList());
    }
  }

  Future<void> saveTransactionIdToDB(
      MoneyTransferReport report, String traceId) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    dynamic list = box.get(DatabaseConstants.dbMoneyTransferReport);
    if (list != null) {
      final index = reportList
          .indexWhere((element) => element.traceId.toString() == traceId);
      reportList.insert(index, report);
      reportList.removeAt(index + 1);
      box.put(DatabaseConstants.dbMoneyTransferReport, reportList.toList());
    } else {}
  }

  Future<void> getTransactionIdList() async {
    List<String> transIdList = [];
    for (int i = 0; i < transactionIdList.length; i++) {
      dynamic transId = {
        AppStrings.txtTransactionId: transactionIdList[i].toString(),
      };
      final jsonEncodeBody = jsonEncode(transId);
      transIdList.add(jsonEncodeBody);
    }
    dynamic body = {'data': transIdList};
    String encryptedBody = await AesEncryption().encrypt(
        body.toString(),
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    dynamic result = await ApiService().postMethod(
        reqBody,
        commonHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.TRANSACTION_STATUS);
    isLoading.value = false;
    if (result != null) {
      if (result.status!) {
        dynamic dataResult = result.data;
        List<MoneyTransferStatus> statusList = [];
        for (int i = 0; i < dataResult.length; i++) {
          final jsonEncodeRes = jsonEncode(dataResult[i]);
          final jsonDecodeRes = jsonDecode(jsonEncodeRes);
          final responseData = MoneyTransferStatus.fromJson(jsonDecodeRes);
          statusList.add(responseData);
          updateStatus(responseData);
        }
        isLoading.value = false;
        await updateTransactionStatus();
      } else {
        commonSnackBar(result.message!);
      }
    } else {
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  void searchView(String value) async {
    DateTime startingDate = DateTime.parse(fromDate.value);
    searchList.addAll(reportList);
    reportList.clear();
    reportList.value = [];
    if (startingDate.isAfter(dbDateInterval)) {
      getSearchReportDataFromDB(value);
    } else {
      await getReportList(startDate, endDate, 1, value);
    }
  }

  getSearchReportDataFromDB(String searchText) async {
    if (searchText.isNotEmpty) {
      String mobile = await AesEncryption()
          .encrypt(searchText, PrefManager().getCustomerCode.toString());
      final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
      List<MoneyTransferReport> dbMoneyTransferReport = box
          .get(DatabaseConstants.dbMoneyTransferReport)
          .toList()
          .cast<MoneyTransferReport>();
      List<MoneyTransferReport> getReportList = dbMoneyTransferReport
          .where((element) =>
              element.endCstmrName
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              element.benefAccName
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              element.endCstmrMob.toString().contains(mobile))
          .toList();
      if (getReportList.isNotEmpty) {
        reportList.addAll(getReportList);
        commission.value = totalCommission(getReportList);
        fee.value = totalFee(getReportList);
        transaction.value = totalTransaction(getReportList);
        walletRecharge.value = totalWalletRecharge(getReportList);
      } else {
        reportList.clear();
        reportList.value = [];
        commission.value = 0.0;
        fee.value = 0.0;
        transaction.value = 0.0;
        walletRecharge.value = 0.0;
      }
    } else {
      reportList.value = searchList;
      commission.value = totalCommission(reportList.value);
      fee.value = totalFee(reportList.value);
      transaction.value = totalTransaction(reportList.value);
      walletRecharge.value = totalWalletRecharge(reportList.value);
    }
  }

  getSearchReportDataFromApi(String searchText) async {}

  double totalCommission(List<MoneyTransferReport> reportList) {
    List<MoneyTransferReport> commissionList = reportList
        .where((element) => element.type == 'C')
        .toList()
        .cast<MoneyTransferReport>();
    double sum = 0.0;
    for (int i = 0; i < commissionList.length; i++) {
      num commission =
          double.parse(commissionList[i].commissionAmount.toString());
      sum += commission;
    }
    return sum;
  }

  double totalTransaction(List<MoneyTransferReport> reportList) {
    List<MoneyTransferReport> transactionList = reportList
        .where((element) =>
            element.transferMode == 'RECPT' && element.status != 'Failed')
        .toList()
        .cast<MoneyTransferReport>();
    double sum = 0.0;
    for (int i = 0; i < transactionList.length; i++) {
      num commission = double.parse(transactionList[i].amount.toString());
      sum += commission;
    }
    return sum;
  }

  double totalFee(List<MoneyTransferReport> reportList) {
    List<MoneyTransferReport> feeList = reportList
        .where((element) => element.type == 'F')
        .toList()
        .cast<MoneyTransferReport>();
    double sum = 0.0;
    for (int i = 0; i < feeList.length; i++) {
      num commission = double.parse(feeList[i].commissionAmount.toString());
      sum += commission;
    }
    return sum;
  }

  double totalWalletRecharge(List<MoneyTransferReport> reportList) {
    List<MoneyTransferReport> walletRechargeList = reportList
        .where((element) => element.transferMode == 'RECPT')
        .toList()
        .cast<MoneyTransferReport>();
    double sum = 0.0;
    for (int i = 0; i < walletRechargeList.length; i++) {
      num commission = double.parse(walletRechargeList[i].amount.toString());
      sum += commission;
    }
    return sum;
  }

  @override
  void onClose() {
    super.onClose();
    reportList.clear();
    reportList.value = [];
  }

  void onItemTap(int index) async {
    Get.to(() => const MoneyTransferReportSummaryPage(),
        arguments: {
          AppStrings.txtTransactionNo:
              reportList[index].transactionId.toString(),
          AppStrings.txtSenderName: reportList[index].endCstmrName.toString(),
          AppStrings.txtSenderMobile: reportList[index].endCstmrMob.toString(),
          AppStrings.txtAccount: reportList[index].benefAccNo.toString(),
          AppStrings.txtIFSCCode: reportList[index].benfIfsc.toString(),
          AppStrings.txtTransactionDate:
              reportList[index].transactionDate.toString(),
          AppStrings.txtTransferMode: reportList[index].transferMode.toString(),
          AppStrings.txtAmount: reportList[index].amount.toString(),
          AppStrings.txtFees: reportList[index].convFee.toString(),
          AppStrings.txtStatus: reportList[index].status.toString(),
          AppStrings.txtBeneficiaryName: reportList[index].benefAccName,
        },
        binding: MoneyTransferReportSummaryBinding());
  }

  void updateStatus(MoneyTransferStatus status) async {
    final index = reportList
        .indexWhere((element) => element.transactionId == status.transactionId);
    MoneyTransferReport moneyTransferReport = MoneyTransferReport(
        tranType: reportList[index].tranType,
        transactionId: reportList[index].transactionId,
        transactionDate: reportList[index].transactionDate,
        statusDescription: reportList[index].statusDescription,
        fromName: reportList[index].fromName,
        fromAccount: reportList[index].fromAccount,
        benfIfsc: reportList[index].benfIfsc,
        benefAccNo: reportList[index].benefAccNo,
        benefAccName: reportList[index].benefAccName,
        traceId: reportList[index].traceId,
        transferMode: reportList[index].transferMode,
        amount: reportList[index].amount,
        convFee: reportList[index].convFee,
        cgst: reportList[index].cgst,
        sgst: reportList[index].sgst,
        commissionAmount: reportList[index].commissionAmount,
        type: reportList[index].type,
        paymentChannel: reportList[index].paymentChannel,
        cess: reportList[index].cess,
        serviceType: reportList[index].serviceType,
        endCstmrMob: reportList[index].endCstmrMob,
        endCstmrName: reportList[index].endCstmrName,
        paymentId: reportList[index].paymentId,
        parameterValue: reportList[index].parameterValue,
        parameterName: reportList[index].parameterName,
        billerId: reportList[index].billerId,
        billerName: reportList[index].billerName,
        bbpsRefNo: reportList[index].bbpsRefNo,
        isBillerBbps: reportList[index].isBillerBbps,
        status: status.status,
        statusFlag: 'Y');
    reportList.insert(index, moneyTransferReport);
    reportList.removeAt(index + 1);
  }

  Future<void> updateTransactionStatus() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool isTableNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbMoneyTransferReport);
    if (isTableNotEmpty) {
      box.put(DatabaseConstants.dbMoneyTransferReport, reportList.toList());
    }
  }
}
