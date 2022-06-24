// import 'package:atm_flutter_app/pages/door_step/accepted_order/door_step_accepted_order_controller.dart';
// import 'package:atm_flutter_app/pages/door_step/accepted_order/qr_code_scan_and_verify/door_step_qr_code_scan_and_verify.dart';
// import 'package:atm_flutter_app/resources/app_colors.dart';
// import 'package:atm_flutter_app/resources/app_strings.dart';
// import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../model/door_step/door_step_report.dart';
//
// class DoorStepAcceptedOrderPage
//     extends GetView<DoorStepAcceptedOrderController> {
//   String exTile = "GST";
//   bool active = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//           itemCount: controller.acceptedOrderList.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: const [
//                         Expanded(
//                             flex: 0,
//                             child: Icon(
//                               Icons.person,
//                               size: 25,
//                               color: Colors.grey,
//                             )),
//                         Expanded(
//                             flex: 1,
//                             child: TextWidget(
//                               text: 'name',
//                               textColor: Colors.grey,
//                               align: TextAlign.start,
//                             )),
//                         Expanded(
//                             flex: 1,
//                             child: TextWidget(
//                               text: '8089839408',
//                               textColor: Colors.grey,
//                               align: TextAlign.end,
//                             )),
//                         Expanded(
//                             flex: 0,
//                             child: Icon(
//                               Icons.phone,
//                               size: 25,
//                               color: Colors.grey,
//                             )),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       const Expanded(
//                           flex: 0,
//                           child: Icon(
//                             Icons.location_pin,
//                             size: 20,
//                             color: Colors.grey,
//                           )),
//                       Expanded(
//                           flex: 1,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               TextWidget(
//                                   text: controller
//                                       .acceptedOrderList[index].address
//                                       .toString(),
//                                   textColor: AppColors.black),
//                               TextWidget(
//                                   text: controller
//                                       .acceptedOrderList[index].buildingType
//                                       .toString(),
//                                   textColor: AppColors.grey),
//                               TextWidget(
//                                   text: controller
//                                       .acceptedOrderList[index].landmark
//                                       .toString(),
//                                   textColor: AppColors.grey),
//                             ],
//                           )),
//                     ],
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(10.0),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15.0)),
//                     child: Obx(
//                       () => ExpansionPanelList(
//                         elevation: 0,
//                         expansionCallback: (panelIndex, bool isExpanded) {
//                           exTile = 'GST';
//                           active = !controller.isExpanded.value;
//                           controller.isExpanded.value = active;
//                         },
//                         children: [
//                           ExpansionPanel(
//                             headerBuilder: (context, bool isExpanded) {
//                               return Container(
//                                 margin: const EdgeInsets.all(10.0),
//                                 padding: const EdgeInsets.only(left: 60.0),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15.0)),
//                                 alignment: Alignment.center,
//                                 child: const TextWidget(
//                                   text: AppStrings.txtGSTInfo,
//                                   textColor: AppColors.colorPrimaryDark,
//                                   textSize: 15,
//                                 ),
//                               );
//                             },
//                             body: expansionBody(
//                                 context,
//                                 controller.acceptedOrderList[index].product!
//                                     .toList()),
//                             isExpanded: controller.isExpanded.value,
//                             canTapOnHeader: true,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Expanded(flex: 1, child: Container()),
//                       Expanded(
//                         flex: 0,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             height: 30,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               border:
//                                   Border.all(color: AppColors.red, width: 2),
//                             ),
//                             child: ElevatedButton(
//                                 style: ButtonStyle(
//                                   backgroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                           AppColors.text),
//                                   shape: MaterialStateProperty.all<
//                                       RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                   ),
//                                 ),
//                                 onPressed: () {},
//                                 child: const TextWidget(
//                                   text: AppStrings.txtReject,
//                                   textColor: AppColors.white,
//                                   textSize: 12,
//                                 )),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 0,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             height: 30,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               border:
//                                   Border.all(color: AppColors.green, width: 2),
//                             ),
//                             child: ElevatedButton(
//                                 style: ButtonStyle(
//                                   backgroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                           AppColors.greenish),
//                                   shape: MaterialStateProperty.all<
//                                       RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                   ),
//                                 ),
//                                 onPressed: () {},
//                                 child: const TextWidget(
//                                   text: AppStrings.txtAccept,
//                                   textColor: AppColors.white,
//                                   textSize: 12,
//                                 )),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             );
//           }),
//     );
//   }
//
//   Widget expansionBody(BuildContext context, List<Product> productList) {
//     return Container(
//         height: 200,
//         margin: const EdgeInsets.all(10.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: ListView.builder(
//             itemCount: productList.length,
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(
//                 leading: SizedBox(
//                   height: 60,
//                   width: 60,
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     alignment: AlignmentDirectional.centerEnd,
//                     fit: StackFit.loose,
//                     children: <Widget>[
//                       Positioned(
//                         right: 0,
//                         child: CircleAvatar(
//                             backgroundColor: AppColors.white,
//                             radius: 35,
//                             backgroundImage: AssetImage(controller.setOrderIcon(
//                                 productList[index].imageName.toString()))),
//                       ),
//                       Positioned(
//                         left: 0,
//                         child: CircleAvatar(
//                             backgroundColor: AppColors.white,
//                             radius: 35,
//                             backgroundImage: AssetImage(controller.setOrderIcon(
//                                 productList[index].imageName.toString()))),
//                       )
//                     ],
//                   ),
//                 ),
//                 title: TextWidget(
//                     text: productList[index].productName.toString(),
//                     textColor: AppColors.black),
//                 subtitle: TextWidget(
//                     text: productList[index].amount.toString(),
//                     textColor: AppColors.black),
//               );
//             }));
//   }
//
//   verificationDialog(String orderId) {
//     Get.defaultDialog(
//         title: AppStrings.txtVerifyOrder,
//         content: Column(
//           children: [
//             const TextWidget(
//                 text: AppStrings.txtVerifyText, textColor: Colors.black),
//             Row(
//               children: [
//                 TextFieldWidget(
//                     enabled: true,
//                     hint: '',
//                     controller: controller.otp1Controller,
//                     validate: false),
//                 TextFieldWidget(
//                     enabled: true,
//                     hint: '',
//                     controller: controller.otp2Controller,
//                     validate: false),
//                 TextFieldWidget(
//                     enabled: true,
//                     hint: '',
//                     controller: controller.otp3Controller,
//                     validate: false),
//                 TextFieldWidget(
//                     enabled: true,
//                     hint: '',
//                     controller: controller.otp4Controller,
//                     validate: false)
//               ],
//             ),
//           ],
//         ),
//         onConfirm: () async {
//           Get.back();
//           final otp = await Get.to(() => DoorStepQRCodeScanAndVerify());
//           controller.setValueToController(otp);
//         },
//         onCancel: () {
//           controller.validateOtpFields(orderId);
//         },
//         confirm: const TextWidget(
//             text: AppStrings.txtScanQR, textColor: Colors.black),
//         cancel: const TextWidget(
//             text: AppStrings.txtVerify, textColor: Colors.black),
//         barrierDismissible: true);
//   }
// }
