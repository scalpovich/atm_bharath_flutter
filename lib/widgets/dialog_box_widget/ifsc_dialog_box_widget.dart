import 'package:atm_flutter_app/model/money_transfer/bank_name.dart';
import 'package:atm_flutter_app/pages/money_transfer/add_transaction/money_transfer_controller.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/textfield_widget/underline_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

// class IFSCDialogBoxWidget extends StatelessWidget {
//   IFSCDialogBoxWidget(
//       {Key? key, required this.clicked, required this.value, this.onTap})
//       : super(key: key);
//
//   final VoidCallback? onTap;
//   final String clicked;
//   String value;
//
//   MoneyTransferController controller = Get.find<MoneyTransferController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
//       child: Container(
//         height: 270,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.0),
//           color: Theme.of(context).textTheme.bodyText1!.color!,
//         ),
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SizedBox(
//                 // height: 40,
//                 child: TypeAheadField<BankName?>(
//                   suggestionsCallback: controller.bankListFromDB,
//                   itemBuilder: (context, BankName? suggestion) {
//                     final bankName = suggestion!;
//                     return ListTile(
//                       title: Text(
//                         bankName.bankName,
//                         style: TextStyle(
//                             color:
//                                 Theme.of(context).textTheme.subtitle1!.color!),
//                       ),
//                     );
//                   },
//                   onSuggestionSelected: (BankName? suggestion) {
//                     controller.bankController.value =
//                         TextEditingValue(text: suggestion!.bankName);
//                     controller.bankName.value = suggestion.bankName;
//                   },
//                   noItemsFoundBuilder: (context) => const ListTile(
//                     title: Text('No bank found'),
//                   ),
//                   textFieldConfiguration: TextFieldConfiguration(
//                     controller: controller.bankController,
//                     style: TextStyle(
//                       color: Theme.of(context).textTheme.subtitle1!.color!,
//                     ),
//                     maxLines: null,
//                     keyboardType: TextInputType.multiline,
//                     decoration: InputDecoration(
//                         counterText: '',
//                         labelText: AppStrings.txtBank,
//                         labelStyle: TextStyle(
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.normal,
//                             color:
//                                 Theme.of(context).textTheme.subtitle1!.color!),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0))),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: UnderlineTextFieldWidget(
//                 enabled: true,
//                 validate: true,
//                 errorText: AppStrings.txtBranchRequired,
//                 hint: AppStrings.txtBranch,
//                 labelText: AppStrings.txtBranch,
//                 controller: controller.branchController,
//                 suffix: const SizedBox(),
//                 type: TextInputType.text,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: UnderlineTextFieldWidget(
//                   enabled: true,
//                   suffix: const SizedBox(),
//                   type: TextInputType.text,
//                   validate: true,
//                   errorText: AppStrings.txtStateRequired,
//                   hint: AppStrings.txtState,
//                   labelText: AppStrings.txtState,
//                   controller: controller.stateController),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: UnderlineTextFieldWidget(
//                   enabled: true,
//                   validate: true,
//                   suffix: const SizedBox(),
//                   type: TextInputType.text,
//                   errorText: AppStrings.txtDistrictRequired,
//                   labelText: AppStrings.txtDistrict,
//                   hint: AppStrings.txtDistrict,
//                   controller: controller.districtController),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 3.0),
//               child: ButtonWidget(
//                 label: 'submit'.tr,
//                 width: 100,
//                 onTap: onTap,
//                 btnColor: Theme.of(context).primaryColor,
//                 clicked: false,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
