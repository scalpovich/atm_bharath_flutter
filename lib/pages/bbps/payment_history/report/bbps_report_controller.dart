import 'dart:async';
import 'dart:convert';
import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/bbps/bbps_report.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/headers.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../resources/app_drawables.dart';
import '../../../../retrofit/body/common_body.dart';
import '../report_details/bbps_payment_details_binding.dart';
import '../report_details/bbps_payment_details_page.dart';

class BBPSReportController extends MainController {
  final fromDate = ''.obs;
  final toDate = ''.obs;
  RxList<BBPSReport> reportList = <BBPSReport>[].obs;
  RxList<BBPSReport> bbpsReportsList = <BBPSReport>[].obs;
  final isLastPage = false.obs;
  RxDouble convFee = 0.0.obs;
  RxDouble transaction = 0.0.obs;
  late DateTime startDate;
  late DateTime endDate;
  RxString categoryImage = ''.obs;
  int interval = int.parse(PrefManager().getSyncDuration.toString());

  DateTime firstDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );
  RxString searchText = ''.obs;
  RxBool isLoading = false.obs;

  late DateTime dbDateInterval;

  RxBool searchVisible = false.obs;

  RxInt pageNumber = 1.obs;
  RxBool hasMoreReport = true.obs;

  List<BBPSReport> get users => reportList.toList();
  bool get lastPage => isLastPage.value;
  set lastPage(bool value) => isLastPage.value = value;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  ///getting bbps report from server
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
        Apis.BBPS_REPORTS);
    if (result != null) {
      if (result.status!) {
        dynamic dataResult = result.data;
        final jsonEncoded = json.encode(dataResult);
        final jsonDecoded = json.decode(jsonEncoded);
        final reportData = BBPSReports.fromJson(jsonDecoded);
        dynamic reportResult = reportData.report;
        dynamic totalResult = reportData.total;
        if (reportResult.isNotEmpty) {
          for (int i = 0; i < reportResult.length; i++) {
            final jsonEncode = json.encode(reportResult[i]);
            final jsonDecode = json.decode(jsonEncode);
            final reportData = BBPSReport.fromJson(jsonDecode);
            reportList.add(reportData);
          }
          for (int i = 0; i < totalResult.length; i++) {
            final jsonEncoded = json.encode(totalResult[i]);
            final jsonDecode = json.decode(jsonEncoded);
            final totalData = BBPSReportTotal.fromJson(jsonDecode);
            transaction.value = totalData.totalTrnAmt!;
          }
          pageNumber.value++;
        } else {
          hasMoreReport.value = false;
          isLastPage.value = true;
        }
      } else {
        hasMoreReport.value = false;
        isLastPage.value = true;
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
    DateTime now = DateTime.now();
    toDate.value = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now).toString();
    setDate();
    if (!isLastPage.value) {
      scrollController.addListener(scrollMore);
    }
  }

  ///searching customer details
  Future<void> searchView(String value) async {
    DateTime startingDate = DateTime.parse(fromDate.value);
    reportList.value = [];
    if (startingDate.isAfter(dbDateInterval)) {
      await getSearchReportDataFromDB(value);
    } else {
      await getReportList(startDate, endDate, value);
    }
  }

  ///load details when scrolling
  void scrollMore() async {
    if (scrollController.position.extentAfter == 0.0) {
      if (startDate.isAfter(dbDateInterval)) {
        getReportDataFromDB();
      } else {
        getMoreReportFromApi(startDate, endDate, searchText.value);
      }
    }
  }

  ///getting more report data from server
  Future<void> getMoreReportFromApi(
      DateTime startDate, DateTime endDate, String searchText) async {
    if (hasMoreReport.value && !isLoading.value) {
      isLoading.value = true;
      await getReportList(startDate, endDate, searchText);
      isLoading.value = false;
    }
  }

  ///getting more report data from db
  Future<void> getMoreReportFromDb() async {
    if (hasMoreReport.value && !isLoading.value) {
      isLoading.value = true;
      await getReportDataFromDB();
      isLoading.value = false;
    }
  }

  ///getting report data from db
  getReportDataFromDB() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    final isTableNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbBBPSReports);
    if (isTableNotEmpty) {
      List<BBPSReport> dbBBPSReport =
          box.get(DatabaseConstants.dbBBPSReports).toList().cast<BBPSReport>();
      dynamic getReportList = dbBBPSReport
          .where((element) =>
              (DateTime.parse(element.transactionDate!).isAfter(startDate) &&
                  DateTime.parse(element.transactionDate!)
                      .isBefore(endDate.add(const Duration(days: 1)))))
          .toList();
      Log().logs('length--', getReportList.length.toString());
      addToReportList(getReportList);
    } else {
      commonSnackBar('Sync report!');
    }
  }

  ///adding report to report list
  addToReportList(List<BBPSReport> getReportList) async {
    getReportList
        .sort((b, a) => a.transactionDate!.compareTo(b.transactionDate!));
    if (getReportList.isNotEmpty) {
      reportList.clear();
      reportList.value = [];
      reportList.addAll(getReportList);
      bbpsReportsList.addAll(reportList);
      convFee.value = totalConvFee(getReportList);
      transaction.value = totalTransaction(getReportList);
    } else {
      hasMoreReport.value = false;
    }
  }

  ///getting search report data from db
  getSearchReportDataFromDB(String searchText) async {
    if (searchText.isNotEmpty) {
      String mobile = await AesEncryption()
          .encrypt(searchText, PrefManager().getCustomerCode.toString());
      Box box = await dbAccess.openDatabase(DatabaseConstants.dbName);
      List<BBPSReport> dbBBPSReport =
          box.get(DatabaseConstants.dbBBPSReports).toList().cast<BBPSReport>();
      List<BBPSReport> getReportList = dbBBPSReport
          .where((element) =>
              element.billerName
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              element.endCstmrName
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              element.endCstmrMob.toString().contains(mobile))
          .toList();
      if (getReportList.isNotEmpty) {
        reportList.addAll(getReportList);
        convFee.value = totalConvFee(getReportList);
        transaction.value = totalTransaction(getReportList);
      } else {
        reportList.clear();
        reportList.value = [];
        transaction.value = 0.0;
      }
    } else {
      reportList = bbpsReportsList;
    }
  }

  ///setting total conv Fee
  double totalConvFee(List<BBPSReport> reportList) {
    List<BBPSReport> convFeeList = reportList
        .where((element) => element.status == 'STATUS')
        .toList()
        .cast<BBPSReport>();
    double sum = 0.0;
    for (int i = 0; i < convFeeList.length; i++) {
      num convFee = double.parse(convFeeList[i].convFee.toString());
      sum += convFee;
    }
    return sum;
  }

  ///setting total transaction amount
  double totalTransaction(List<BBPSReport> reportList) {
    List<BBPSReport> transactionList = reportList
        .where((element) => element.status!.toUpperCase() == 'SUCCESS')
        .toList()
        .cast<BBPSReport>();
    double sum = 0.0;
    for (int i = 0; i < transactionList.length; i++) {
      num transaction = double.parse(transactionList[i].amount.toString());
      sum += transaction;
    }
    return sum;
  }

  ///setting date
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

  ///report data click function
  void onItemTap(int index) {
    String paramsN = reportList[index].parameterName.toString();
    String paramsV = reportList[index].paramsValue.toString();
    String parameterNa = paramsN.replaceAll('[', '');
    String parameterName = parameterNa.replaceAll(']', '');
    String parameterVa = paramsV.replaceAll('[', '');
    String parameterValue = parameterVa.replaceAll(']', '');
    // categoryImage.value =
    //     setCategoryImage(reportList[index].billerCategory.toString());
    Get.to(() => const BBPSPaymentDetailsPage(),
        arguments: {
          AppStrings.txtTransactionNo:
              reportList[index].transactionId.toString(),
          AppStrings.txtPaymentId: reportList[index].paymentId.toString(),
          AppStrings.txtSenderName: reportList[index].endCstmrName.toString(),
          AppStrings.txtSenderMobile: reportList[index].endCstmrMob.toString(),
          AppStrings.txtParameterValue: parameterValue,
          AppStrings.txtBBPSRefNo: reportList[index].bbpsRefNo.toString(),
          AppStrings.txtBillerName: reportList[index].billerName.toString(),
          AppStrings.txtBillerId: reportList[index].billerId.toString(),
          AppStrings.txtBillDate: reportList[index].transactionDate.toString(),
          AppStrings.txtBillAmount: reportList[index].amount.toString(),
          AppStrings.txtConvFee: reportList[index].convFee.toString(),
          AppStrings.txtPaymentChannel:
              reportList[index].paymentChannel.toString(),
          AppStrings.txtPaymentMode: reportList[index].transferMode.toString(),
          AppStrings.txtParameterName: parameterName,
          AppStrings.txtRefNo: reportList[index].referenceNo.toString(),
          AppStrings.txtTraceId: reportList[index].traceId.toString(),
          AppStrings.txtCategory: reportList[index].billerCategory.toString(),
          AppStrings.txtStatus: reportList[index].status.toString(),
          AppStrings.txtCategoryImage: categoryImage.value,
          'home': false,
        },
        binding: BBPSPaymentDetailsBinding());
  }

  ///setting category image from using category type
  String? setCategoryImage(String categoryTitle) {
    String? categoryImage;
    switch (categoryTitle) {
      case 'Mobile Prepaid':
        categoryImage = AppDrawable.mobileRecharge;
        break;
      case 'DTH':
        categoryImage = AppDrawable.dth;
        break;
      case 'FASTag':
        categoryImage = AppDrawable.fastag;
        break;
      case 'Electricity':
        categoryImage = AppDrawable.electricity;
        break;
      case 'Piped Gas':
        categoryImage = AppDrawable.pipelineGas;
        break;
      case 'LPG Cylinder':
        categoryImage = AppDrawable.cylinder;
        break;
      case 'Water':
        categoryImage = AppDrawable.pipelineWater;
        break;
      case 'Broadband':
        categoryImage = AppDrawable.broadband;
        break;
      case 'Landline':
        categoryImage = AppDrawable.landlinePostpaid;
        break;
      case 'Cable TV':
        categoryImage = AppDrawable.cableTv;
        break;
      case 'Postpaid':
        categoryImage = AppDrawable.mobilePostpaid;
        break;
      case 'Insurance':
        categoryImage = AppDrawable.insurance;
        break;
      case 'Loan':
        categoryImage = AppDrawable.loan;
        break;
      case 'Credit Card':
        categoryImage = AppDrawable.creditCard;
        break;
      case 'Tax':
        categoryImage = AppDrawable.municipalTax;
        break;
      case 'Municipal Services':
        categoryImage = AppDrawable.municipalService;
        break;
      case 'Hospital':
        categoryImage = AppDrawable.hospital;
        break;
      case 'Housing Society':
        categoryImage = AppDrawable.housingSociety;
        break;
      case 'Subscription':
        categoryImage = AppDrawable.subscriptionFee;
        break;
      case 'Donation':
        categoryImage = AppDrawable.donation;
        break;
      case 'Clubs And Associations':
        categoryImage = AppDrawable.clubsAndAssociations;
        break;
    }
    return categoryImage;
  }
}
