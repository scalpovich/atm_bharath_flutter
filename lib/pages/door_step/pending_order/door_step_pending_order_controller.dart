import 'dart:convert';

import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/door_step/door_step_report.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/retrofit/api_request.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/body/door_step_body.dart';
import 'package:atm_flutter_app/retrofit/headers.dart';
import 'package:atm_flutter_app/utils/location_service.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DoorStepPendingOrderController extends MainController {
  RxList<DoorStepReports> pendingOrderList = <DoorStepReports>[].obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  late Position currentPosition;

  @override
  void onInit() {
    super.onInit();
    // getCurrentLocation();
    getPendingOrders();
  }

  //door step pending orders from api
  getPendingOrders() async {
    String startDate =
        DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    dynamic body = {'start_date': startDate};
    Log().logs('driverCode---', PrefManager().getDriverCode.toString());
    String reqBody = await request(
        body: body,
        key: PrefManager().getDeviceId.toString() +
            PrefManager().getDriverCode.toString());
    final result = await ApiService().getMethod(
        // reqBody,
        doorStepHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getDriverCode.toString(),
        Apis.DOOR_STEP_PENDING_ORDER);
    if (result!.status!) {
      dynamic dataResult = result.data;
      for (int i = 0; i < dataResult.length; i++) {
        final jsonEncode = json.encode(dataResult[i]);
        final jsonDecode = json.decode(jsonEncode);
        final doorStepReport = DoorStepReports.fromJson(jsonDecode);
        pendingOrderList.add(doorStepReport);
      }
    } else {
      ///snackbar
    }
  }

  //get device current location
  getCurrentLocation() async {
    currentPosition = await getUserCurrentLocation();
    latitude.value = currentPosition.latitude.toString();
    longitude.value = currentPosition.longitude.toString();
  }

  Future<Position> getUserCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return currentPosition;
  }

  //door step driver accepting order
  acceptOrder(String orderId, RxList<DoorStepReports> dataList) async {
    dynamic body = await doorStepOrderAcceptedBody(
        latitude: latitude.value,
        longitude: longitude.value,
        customerName: PrefManager().getCustomerName.toString(),
        orderId: orderId);
    String reqBody =
        await request(body: body, key: PrefManager().getDriverCode.toString());
    final result = await ApiService().postMethod(
        reqBody,
        doorStepHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getEncryptedDriverCode.toString(),
        Apis.ORDER_ACCEPTED_BY_AGENT);
    if (result!.status!) {
      DoorStepReports doorStepReports = DoorStepReports(
          orderId: int.parse(orderId),
          orderDate: dataList[0].orderDate.toString(),
          orderStatus: 'Pending',
          orderTime: dataList[0].orderTime.toString(),
          addressType: dataList[0].addressType.toString(),
          address: dataList[0].address.toString(),
          buildingType: dataList[0].buildingType.toString(),
          landmark: dataList[0].landmark.toString(),
          latitude: latitude.value,
          product: dataList[0].product);
      saveAcceptedOrdersToDB(doorStepReports);
    } else {
      ///snackBar
    }
  }

  //door step driver rejecting order
  rejectOrder(String orderId, int index) async {
    dynamic body = await doorStepOrderRejectedBody(orderId: orderId);
    String reqBody =
        await request(body: body, key: PrefManager().getDriverCode.toString());
    final result = await ApiService().postMethod(
        reqBody,
        doorStepHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getDriverCode.toString(),
        Apis.ORDER_REJECTED_BY_AGENT);
    if (result!.status!) {
      pendingOrderList.removeAt(index);
    } else {
      ///snackBar
    }
  }

  //door step save accepted orders to local db
  saveAcceptedOrdersToDB(DoorStepReports reports) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    List<DoorStepReports> listDB = box
        .get(DatabaseConstants.dbDoorstepReports)
        .toList()
        .cast<DoorStepReports>();
    if (listDB.isNotEmpty) {
      listDB.add(reports);
      box.put(DatabaseConstants.dbDoorstepReports, listDB);
    } else {
      box.put(DatabaseConstants.dbDoorstepReports, reports);
    }
  }

  //door step setting icon using name from response
  setOrderIcon(String category) {
    switch (category) {
      case 'ic_atm_withdrawal':
        return AppDrawable.filePath + AppDrawable.atmWithdrawalLight;
      case 'ic_deposit':
        return AppDrawable.filePath + AppDrawable.deposit;
      case 'ic_dth':
        return AppDrawable.filePath + AppDrawable.dth;
      case 'ic_electricity':
        return AppDrawable.filePath + AppDrawable.electricity;
      case 'ic_fast_tag':
        return AppDrawable.filePath + AppDrawable.fastag;
      case 'ic_gas':
        return AppDrawable.filePath + AppDrawable.dsGas;
      case 'ic_landline':
        return AppDrawable.filePath + AppDrawable.landlinePostpaid;
      case 'ic_mobile_recharge':
        return AppDrawable.filePath + AppDrawable.mobileRecharge;
      case 'ic_money_transfer':
        return AppDrawable.filePath + AppDrawable.moneyTransfer;
      case 'ic_water':
        return AppDrawable.filePath + AppDrawable.dsWater;
    }
  }
}
