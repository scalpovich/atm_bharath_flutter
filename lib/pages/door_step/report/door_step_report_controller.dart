import 'dart:convert';

import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/door_step/door_step_report.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/body/common_body.dart';
import 'package:atm_flutter_app/retrofit/headers.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/api_req_res_format.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class DoorStepReportController extends MainController {
  final fromDate = ''.obs;
  final toDate = ''.obs;
  final reportList = <DoorStepReports>[].obs;
  final isLastPage = false.obs;
  final doorStepProductList = <Product>[].obs;
  DateTime firstDay = new DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );
  RxInt pageNumber = 1.obs;
  RxBool hasMoreReport = true.obs;
  RxBool isLoading = false.obs;

  List<DoorStepReports> get report => reportList.toList();
  List<Product> get product => doorStepProductList.toList();
  bool get lastPage => isLastPage.value;
  set lastPage(bool value) => isLastPage.value = value;

  final ScrollController scrollController = ScrollController();

  late DateTime startDate;
  late DateTime endDate;
  DateTime dbDateInterval =
      DateTime(DateTime.now().year, DateTime.now().month - 2, 1);

  Future<void> getReportList(DateTime startDate, DateTime endDate) async {
    dynamic body = await commonReportBody(
        startDate: startDate,
        endDate: endDate,
        pageNo: pageNumber.value,
        sync: 'N',
        searchText: '');
    final result = await ApiService().postMethod(
        body,
        doorStepHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getDriverCode.toString(),
        Apis.DS_ORDER_REPORT);
    if (result != null) {
      dynamic dataResult = result.data;
      if (dataResult.isNotEmpty) {
        for (int i = 0; i < dataResult.length; i++) {
          final jsonEncode = json.encode(dataResult[i]);
          final jsonDecode = json.decode(jsonEncode);
          final reportData = DoorStepReports.fromJson(jsonDecode);
          dynamic productData = reportData.product;
          for (int j = 0; j < productData.length; j++) {
            final jsonEncode = json.encode(dataResult[i]);
            final jsonDecode = json.decode(jsonEncode);
            final reportData = Product.fromJson(jsonDecode);
            doorStepProductList.add(reportData);
          }
          reportList.add(reportData);
        }
        pageNumber.value++;
      } else {
        hasMoreReport.value = false;
        isLastPage.value = true;
      }
    } else {
      isLastPage.value = true;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fromDate.value =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(firstDay).toString();
    toDate.value =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()).toString();
    setDate();
    if (!isLastPage.value) {
      scrollController.addListener(scrollMore);
    }
  }

  void scrollMore() async {
    Log().logs('scroll--', scrollController.position.extentAfter.toString());
    if (scrollController.position.extentAfter == 0.0) {
      if (startDate.isAfter(dbDateInterval)) {
        getReportDataFromDB();
      } else {
        getMoreReportFromApi(startDate, endDate);
      }
    }
  }

  Future<void> getMoreReportFromApi(
      DateTime startDate, DateTime endDate) async {
    if (hasMoreReport.value && !isLoading.value) {
      isLoading.value = true;
      await getReportList(startDate, endDate);
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
    DateTime startDate = DateTime.parse('2021-12-01T00:00:00');
    DateTime endDate = DateTime.now();
    Box box = await dbAccess.openDatabase(DatabaseConstants.dbDoorstepReports);
    List<DoorStepReports> dbDoorStepReport = box
        .get(DatabaseConstants.dbDoorstepReports)
        .toList()
        .cast<DoorStepReports>();
    List<DoorStepReports> getReportList = dbDoorStepReport
        .where((element) =>
            DateTime.parse(element.orderDate!).isAfter(startDate) &&
            DateTime.parse(element.orderDate!).isBefore(endDate))
        .toList();
    if (getReportList.isNotEmpty) {
      reportList.value = getReportList;
    }
    for (int i = 0; i < getReportList.length; i++) {
      Log().logs('hive report--', getReportList[i].toString());
    }
  }

  getSearchReportDataFromDB(String searchText) async {
    Box box = await dbAccess.openDatabase(DatabaseConstants.dbDoorstepReports);
    List<DoorStepReports> dbDoorStepReport =
        box.get(DatabaseConstants.dbReports).toList().cast<DoorStepReports>();
    // List<DoorStepReports> getReportList = dbDoorStepReport
    //     .where((element) =>
    // element.endCstmrName == searchText ||
    //     element.benefAccName == searchText ||
    //     element.endCstmrMob ==
    //         AesEncryption().encrypt(searchText, deviceId).toString())
    //     .toList();
    // if (getReportList.isNotEmpty) {
    //   reportList.value = getReportList;
    // }
  }

  void setDate() async {
    startDate = DateFormat('yyyy-MM-dd').parse(fromDate.value);
    if (toDate.value == '') {
      toDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    }
    endDate = DateFormat('yyyy-MM-dd').parse(toDate.value);
    DateTime dbDateInterval =
        DateTime(DateTime.now().year, DateTime.now().month - 2, 1);

    Log().logs('startDate--', startDate.toString());
    Log().logs('endDate--', endDate.toString());
    Log().logs('dbInterval', dbDateInterval.toString());

    if (endDate.isAfter(startDate)) {
      Log().logs('entered', '');
      if (startDate.isAfter(dbDateInterval)) {
        Log().logs('entered', 'db');
        getReportDataFromDB();
      } else {
        Log().logs('entered', 'api');
        getMoreReportFromApi(startDate, endDate);
      }
    } else {
      toDate.value = fromDate.value;
    }
  }
}
