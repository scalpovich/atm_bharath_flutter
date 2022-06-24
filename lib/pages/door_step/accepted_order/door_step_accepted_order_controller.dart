// import 'dart:convert';
//
// import 'package:atm_flutter_app/constants/database_constants.dart';
// import 'package:atm_flutter_app/resources/app_strings.dart';
// import 'package:atm_flutter_app/retrofit/body/door_step_body.dart';
// import 'package:atm_flutter_app/utils/main_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../helper/prefManager.dart';
// import '../../../model/door_step/door_step_report.dart';
// import '../../../resources/app_drawables.dart';
// import '../../../retrofit/api_request.dart';
// import '../../../retrofit/api_service.dart';
// import '../../../retrofit/apis.dart';
// import '../../../retrofit/headers.dart';
// import '../../../utils/location_service.dart';
//
// class DoorStepAcceptedOrderController extends MainController {
//   RxBool isExpanded = false.obs;
//   RxList<DoorStepReports> acceptedOrderList = <DoorStepReports>[].obs;
//   RxString latitude = ''.obs;
//   RxString longitude = ''.obs;
//   late Position currentPosition;
//   RxString buttonText = 'Start'.obs;
//   RxString verificationText = ''.obs;
//   TextEditingController otp1Controller = TextEditingController();
//   TextEditingController otp2Controller = TextEditingController();
//   TextEditingController otp3Controller = TextEditingController();
//   TextEditingController otp4Controller = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     getDriverCurrentLocation();
//     getAcceptedOrdersFromDB();
//   }
//
//   //door step getting driver accepted orders from api and save to local db
//   getAcceptedOrdersFromApi() async {
//     dynamic body = {'start_date': DateTime.now().toString()};
//     String reqBody =
//         await request(body: body, key: PrefManager().getDriverCode.toString());
//     final result = await ApiService().postMethod(
//         reqBody,
//         doorStepHeader,
//         PrefManager().getDeviceId.toString() +
//             PrefManager().getDriverCode.toString(),
//         Apis.DOOR_STEP_ACCEPTED_ORDER);
//     if (result!.status!) {
//       dynamic dataResult = result.data;
//       for (int i = 0; i < dataResult.length; i++) {
//         final jsonEncode = json.encode(dataResult[i]);
//         final jsonDecode = json.decode(jsonEncode);
//         final doorStepReport = DoorStepReports.fromJson(jsonDecode);
//         acceptedOrderList.add(doorStepReport);
//       }
//       saveAcceptedOrdersToDB();
//     } else {
//       ///snackbar
//     }
//   }
//
//   //save door step driver accepted orders to local db
//   saveAcceptedOrdersToDB() async {
//     final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
//     box.put(DatabaseConstants.dbDoorstepReports, acceptedOrderList.toList());
//   }
//
//   //getting driver accepted orders from local db
//   getAcceptedOrdersFromDB() async {
//     final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
//     List<DoorStepReports> listDB = box
//         .get(DatabaseConstants.dbDoorstepReports)
//         .toList()
//         .cast<DoorStepReports>();
//     if (listDB.isNotEmpty) {
//       List<DoorStepReports> acceptedList = listDB
//           .where((element) => element.orderStatus == AppStrings.txtAccepted)
//           .toList()
//           .cast<DoorStepReports>();
//       acceptedOrderList.value = acceptedList;
//     } else {
//       getAcceptedOrdersFromApi();
//     }
//   }
//
//   //updating accepted order status
//   driverStatusUpdate(String orderId, String orderStatus) async {
//     dynamic reqBody = await doorStepOrderStatusBody(
//         orderId: orderId, orderStatus: orderStatus);
//     final result = await ApiService().postMethod(
//         reqBody,
//         doorStepHeader,
//         PrefManager().getDeviceId.toString() +
//             PrefManager().getDriverCode.toString(),
//         Apis.ORDER_STATUS_UPDATE);
//     if (result!.status!) {
//     } else {
//       ///snackBar
//     }
//   }
//
//   //updating driver current location every 5 min
//   driverCurrentLocationUpdate(String orderId) async {
//     dynamic reqBody = await doorStepAgentLocationBody(
//         orderId: orderId, latitude: latitude.value, longitude: longitude.value);
//     final result = await ApiService().postMethod(
//         reqBody,
//         doorStepHeader,
//         PrefManager().getDeviceId.toString() +
//             PrefManager().getDriverCode.toString(),
//         Apis.AGENT_LOCATION_TRACKING);
//     if (!result!.status!) {
//       ///snackbar
//     }
//   }
//
//   //getting driver current location
//   getDriverCurrentLocation() async {
//     currentPosition = await getUserCurrentLocation();
//     latitude.value = currentPosition.latitude.toString();
//     longitude.value = currentPosition.longitude.toString();
//   }
//
//   //driver canceling accepted order before starting
//   driverCancelOrder(String orderId, int index) async {
//     dynamic body = await doorStepOrderRejectedBody(orderId: orderId);
//     String reqBody =
//         await request(body: body, key: PrefManager().getDriverCode.toString());
//     final result = await ApiService().postMethod(
//         reqBody,
//         doorStepHeader,
//         PrefManager().getDeviceId.toString() +
//             PrefManager().getDriverCode.toString(),
//         Apis.ORDER_CANCEL_BY_AGENT);
//     if (result!.status!) {
//       acceptedOrderList.removeAt(index);
//     } else {
//       ///snackBar
//     }
//   }
//
//   //setting icons
//   setOrderIcon(String category) {
//     switch (category) {
//       case 'ic_atm_withdrawal':
//         return AppDrawable.filePath + AppDrawable.atmWithdrawalLight;
//       case 'ic_deposit':
//         return AppDrawable.filePath + AppDrawable.deposit;
//       case 'ic_dth':
//         return AppDrawable.filePath + AppDrawable.dth;
//       case 'ic_electricity':
//         return AppDrawable.filePath + AppDrawable.electricity;
//       case 'ic_fast_tag':
//         return AppDrawable.filePath + AppDrawable.fastag;
//       case 'ic_gas':
//         return AppDrawable.filePath + AppDrawable.dsGas;
//       case 'ic_landline':
//         return AppDrawable.filePath + AppDrawable.landlinePostpaid;
//       case 'ic_mobile_recharge':
//         return AppDrawable.filePath + AppDrawable.mobileRecharge;
//       case 'ic_money_transfer':
//         return AppDrawable.filePath + AppDrawable.moneyTransfer;
//       case 'ic_water':
//         return AppDrawable.filePath + AppDrawable.dsWater;
//     }
//   }
//
//   //open map
//   static void navigateTo(double lat, double lng) async {
//     var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
//     if (await canLaunch(uri.toString())) {
//       await launch(uri.toString());
//     } else {
//       throw 'Could not launch ${uri.toString()}';
//     }
//   }
//
//   validateOtpFields(String orderId) async {
//     if (otp1Controller.text.isNotEmpty &&
//         otp2Controller.text.isNotEmpty &&
//         otp3Controller.text.isNotEmpty &&
//         otp4Controller.text.isNotEmpty) {
//       verifyOtp(orderId);
//     } else {}
//   }
//
//   verifyOtp(String orderId) async {
//     dynamic body = await doorStepOtpVerifyBody(
//         otp: otp1Controller.text +
//             otp2Controller.text +
//             otp3Controller.text +
//             otp4Controller.text,
//         orderId: orderId);
//     final result = await ApiService().postMethod(body, doorStepHeader,
//         PrefManager().getDeviceId.toString(), Apis.ORDER_VERIFICATION);
//     if (result!.status!) {
//     } else {
//       ///snackBar
//     }
//   }
//
//   setValueToController(String otp) async {
//     List<String> otpList = [];
//     otpList = otp.split('');
//     otp1Controller.value = TextEditingValue(text: otpList[0].toString());
//     otp2Controller.value = TextEditingValue(text: otpList[1].toString());
//     otp3Controller.value = TextEditingValue(text: otpList[2].toString());
//     otp4Controller.value = TextEditingValue(text: otpList[3].toString());
//   }
// }
