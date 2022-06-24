import 'dart:convert';
import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/qr/qr_report.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/body/common_body.dart';
import 'package:atm_flutter_app/retrofit/headers.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class QRCodeReportController extends MainController {
  final fromDate = ''.obs;
  final toDate = ''.obs;
  final reportList = <QRReport>[].obs;
  final searchList = <QRReport>[].obs;
  final isLastPage = false.obs;
  RxDouble transaction = 0.0.obs;

  DateTime firstDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );

  RxInt pageNumber = 1.obs;
  RxBool hasMoreReport = true.obs;
  RxBool isLoading = false.obs;
  RxBool searchVisible = false.obs;
  RxString searchText = ''.obs;

  late DateTime startDate;
  late DateTime endDate;
  late DateTime dbDateInterval;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  List<QRReport> get users => reportList.toList();
  bool get lastPage => isLastPage.value;
  set lastPage(bool value) => isLastPage.value = value;
  int interval = int.parse(PrefManager().getSyncDuration.toString());

  Future<void> getReportList(
      DateTime startDate, DateTime endDate, String searchText) async {
    dynamic body = await commonReportBody(
        startDate: startDate,
        endDate: endDate,
        pageNo: pageNumber.value,
        sync: 'N',
        searchText: searchText);
    final result = await ApiService().postMethod(
        body,
        commonHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.QR_REPORT);
    if (result != null) {
      if (result.status!) {
        dynamic dataResult = result.data;
        final jsonEncoded = json.encode(dataResult);
        final jsonDecoded = json.decode(jsonEncoded);
        final reportData = QRReports.fromJson(jsonDecoded);
        dynamic reportResult = reportData.report;
        dynamic totalResult = reportData.total;
        if (reportResult.isNotEmpty) {
          for (int i = 0; i < reportResult.length; i++) {
            final jsonEncode = json.encode(reportResult[i]);
            final jsonDecode = json.decode(jsonEncode);
            final reportData = QRReport.fromJson(jsonDecode);
            reportList.add(reportData);
          }
          for (int i = 0; i < totalResult.length; i++) {
            final jsonEncode = json.encode(totalResult[i]);
            final jsonDecode = json.decode(jsonEncode);
            final reportData = QRReportTotal.fromJson(jsonDecode);
            transaction.value = transaction.value + reportData.totalTrnAmt!;
          }
          pageNumber.value++;
        } else {
          hasMoreReport.value = false;
          isLastPage.value = true;
        }
      } else {
        commonSnackBar(result.message!);
      }
    } else {
      isLastPage.value = true;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  @override
  void onInit() {
    super.onInit();
    dbDateInterval =
        DateTime(DateTime.now().year, DateTime.now().month - interval, 1);
    fromDate.value =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(firstDay).toString();
    toDate.value =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()).toString();
    setDate();
    scrollController.addListener(scrollMore);
  }

  void searchView(String value) {
    DateTime startingDate = DateTime.parse(fromDate.value);
    searchList.addAll(reportList);
    reportList.clear();
    reportList.value = [];
    if (startingDate.isAfter(dbDateInterval)) {
      getSearchReportDataFromDB(value);
    } else {
      getMoreReportFromApi(startDate, endDate, value);
    }
  }

  void scrollMore() async {
    if (scrollController.position.extentAfter == 0.0) {
      if (startDate.isAfter(dbDateInterval)) {
        getReportDataFromDB();
      } else {
        getMoreReportFromApi(startDate, endDate, searchText.value);
      }
    }
  }

  Future<void> getMoreReportFromApi(
      DateTime startDate, DateTime endDate, String searchText) async {
    if (hasMoreReport.value && !isLoading.value) {
      isLoading.value = true;
      await getReportList(startDate, endDate, searchText);
      isLoading.value = false;
    }
  }

  Future<void> getMoreReportFromDb() async {
    if (hasMoreReport.value && !isLoading.value) {
      isLoading.value = true;
      await getReportDataFromDB();
      isLoading.value = false;
    }
  }

  getReportDataFromDB() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    List<QRReport> dbQRReport =
        box.get(DatabaseConstants.dbQRReports).toList().cast<QRReport>();
    dynamic getReportList = dbQRReport
        .where((element) =>
            (DateTime.parse(element.transactionDate!).isAfter(startDate) &&
                DateTime.parse(element.transactionDate!)
                    .isBefore(endDate.add(const Duration(days: 1)))))
        .toList();
    addToReportList(getReportList);
  }

  addToReportList(List<QRReport> getReportList) async {
    getReportList.sort((b, a) => a.transactionId!.compareTo(b.transactionId!));
    if (getReportList.isNotEmpty) {
      reportList.clear();
      reportList.value = [];
      reportList.addAll(getReportList);
      transaction.value = totalTransaction(getReportList);
    } else {
      hasMoreReport.value = false;
    }
  }

  getSearchReportDataFromDB(String searchText) async {
    if (searchText.isNotEmpty) {
      Box box = await dbAccess.openDatabase(DatabaseConstants.dbName);
      List<QRReport> dbMoneyTransferReport =
          box.get(DatabaseConstants.dbQRReports).toList().cast<QRReport>();
      List<QRReport> getReportList = dbMoneyTransferReport
          .where((element) =>
              element.payerName
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              element.invoiceName
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase()))
          .toList();
      if (getReportList.isNotEmpty) {
        reportList.addAll(getReportList);
        transaction.value = totalTransaction(getReportList);
      } else {
        reportList.clear();
        reportList.value = [];
        transaction.value = 0.0;
      }
    } else {
      reportList.addAll(searchList);
      transaction.value = totalTransaction(reportList.value);
    }
  }

  double totalTransaction(List<QRReport> reportList) {
    List<QRReport> transactionList = reportList
        .where((element) => element.status == 'SUCCESS')
        .toList()
        .cast<QRReport>();
    double sum = 0.0;
    for (int i = 0; i < transactionList.length; i++) {
      num transaction = double.parse(transactionList[i].amount.toString());
      sum += transaction;
    }
    return sum;
  }

  void setDate() async {
    startDate = DateFormat('yyyy-MM-dd').parse(fromDate.value);
    if (toDate.value == '') {
      toDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    }
    endDate = DateFormat('yyyy-MM-dd').parse(toDate.value);
    DateTime dbDateInterval =
        DateTime(DateTime.now().year, DateTime.now().month - 2, 1);

    if (endDate.isAfter(startDate)) {
      if (startDate.isAfter(dbDateInterval)) {
        getReportDataFromDB();
      } else {
        getMoreReportFromApi(startDate, endDate, searchText.value);
      }
    } else {
      toDate.value = fromDate.value;
    }
  }
}
