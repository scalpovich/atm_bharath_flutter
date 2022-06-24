import 'dart:convert';

import 'package:atm_flutter_app/model/door_step/door_step_report.dart';
import 'package:atm_flutter_app/pages/door_step/report_summary/door_step_report_summary_binding.dart';
import 'package:atm_flutter_app/pages/door_step/report_summary/door_step_report_summary_page.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:get/get.dart';

import '../../../constants/database_constants.dart';
import '../../../helper/prefManager.dart';
import '../../../resources/app_strings.dart';
import '../../../retrofit/api_request.dart';
import '../../../retrofit/api_service.dart';
import '../../../retrofit/apis.dart';
import '../../../retrofit/headers.dart';

class DoorStepCompletedOrderController extends MainController {
  RxList<DoorStepReports> completedOrderList = <DoorStepReports>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCompletedOrdersFromDB();
  }

  //getting driver completed orders from server
  getCompletedOrdersFromApi() async {
    dynamic body = {'start_date': DateTime.now().toString()};
    String reqBody =
        await request(body: body, key: PrefManager().getDriverCode.toString());
    final result = await ApiService().postMethod(
        reqBody,
        doorStepHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getDriverCode.toString(),
        Apis.DOOR_STEP_ACCEPTED_ORDER);
    if (result!.status!) {
      dynamic dataResult = result.data;
      for (int i = 0; i < dataResult.length; i++) {
        final jsonEncode = json.encode(dataResult[i]);
        final jsonDecode = json.decode(jsonEncode);
        final doorStepReport = DoorStepReports.fromJson(jsonDecode);
        completedOrderList.add(doorStepReport);
      }
      saveCompletedOrdersToDB();
    } else {
      ///snackbar
    }
  }

  //save door step driver accepted orders to local db
  saveCompletedOrdersToDB() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    box.put(DatabaseConstants.dbDoorstepReports, completedOrderList.toList());
  }

  //getting driver accepted orders from local db
  getCompletedOrdersFromDB() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    List<DoorStepReports> listDB = box
        .get(DatabaseConstants.dbDoorstepReports)
        .toList()
        .cast<DoorStepReports>();
    if (listDB.isNotEmpty) {
      List<DoorStepReports> completedList = listDB
          .where((element) => element.orderStatus == AppStrings.txtAccepted)
          .toList()
          .cast<DoorStepReports>();
      completedOrderList.value = completedList;
    } else {
      getCompletedOrdersFromApi();
    }
  }

  onItemTap(String orderId) async {
    Get.to(() => DoorStepReportSummaryPage(),
        binding: DoorStepReportSummaryBinding(),
        arguments: {AppStrings.txtOrderId: orderId});
  }
}
