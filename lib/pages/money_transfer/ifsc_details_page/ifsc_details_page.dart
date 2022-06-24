import 'package:atm_flutter_app/pages/money_transfer/ifsc_details_page/ifsc_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../../model/money_transfer/bank_name.dart';
import '../../../resources/app_strings.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/text_widget/text_widget.dart';
import '../../../widgets/textfield_widget/underline_text_field_widget.dart';

class IFSCDetailsPage extends GetView<IFSCDetailsController> {
  const IFSCDetailsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: TextWidget(
            text: 'ifsc_search'.tr.toUpperCase(),
            textColor: Theme.of(context).appBarTheme.titleTextStyle!.color!),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                // height: 40,
                child: TypeAheadField<BankName?>(
                  suggestionsCallback: controller.bankListFromDB,
                  itemBuilder: (context, BankName? suggestion) {
                    final bankName = suggestion!;
                    return ListTile(
                      title: Text(
                        bankName.bankName,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.subtitle1!.color!),
                      ),
                    );
                  },
                  onSuggestionSelected: (BankName? suggestion) {
                    controller.bankController.value =
                        TextEditingValue(text: suggestion!.bankName);
                    controller.bankName.value = suggestion.bankName;
                  },
                  noItemsFoundBuilder: (context) => const ListTile(
                    title: Text('No bank found'),
                  ),
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: controller.bankController,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1!.color!,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        counterText: '',
                        labelText: AppStrings.txtBank,
                        labelStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                            color:
                                Theme.of(context).textTheme.subtitle1!.color!),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: UnderlineTextFieldWidget(
                enabled: true,
                validate: true,
                errorText: AppStrings.txtBranchRequired,
                hint: AppStrings.txtBranch,
                labelText: AppStrings.txtBranch,
                controller: controller.branchController,
                suffix: const SizedBox(),
                type: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: UnderlineTextFieldWidget(
                  enabled: true,
                  suffix: const SizedBox(),
                  type: TextInputType.text,
                  validate: true,
                  errorText: AppStrings.txtStateRequired,
                  hint: AppStrings.txtState,
                  labelText: AppStrings.txtState,
                  controller: controller.stateController),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: UnderlineTextFieldWidget(
                  enabled: true,
                  validate: true,
                  suffix: const SizedBox(),
                  type: TextInputType.text,
                  errorText: AppStrings.txtDistrictRequired,
                  labelText: AppStrings.txtDistrict,
                  hint: AppStrings.txtDistrict,
                  controller: controller.districtController),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: ButtonWidget(
                label: 'submit'.tr,
                width: 100,
                onTap: controller.ifscSearch,
                btnColor: Theme.of(context).primaryColor,
                clicked: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
