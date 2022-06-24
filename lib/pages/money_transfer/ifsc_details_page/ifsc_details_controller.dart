import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/database_constants.dart';
import '../../../model/money_transfer/bank_name.dart';
import '../../../resources/app_strings.dart';
import '../ifsc_search/ifsc_search_binding.dart';
import '../ifsc_search/ifsc_search_page.dart';

class IFSCDetailsController extends MainController {
  final TextEditingController bankController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController stateController =
      TextEditingController(text: 'Kerala');
  final TextEditingController districtController = TextEditingController();
  RxString bankName = ''.obs;

  Future<List<BankName>> bankListFromDB(String searchQuery) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    List<BankName> bankList = [];
    bool isTableNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbBankList);
    if (isTableNotEmpty) {
      List<BankName> bankListsDb =
          box.get(DatabaseConstants.dbBankList).toList().cast<BankName>();
      bankList = bankListsDb
          .where((element) => element.bankName
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    }
    return bankList;
  }

  void ifscSearch() async {
    bankController.clear();
    // Get.back();
    dynamic data = await Get.to(() => const IFSCSearchPage(),
        binding: IFSCSearchBinding(),
        arguments: {
          AppStrings.txtBankName: bankName.value,
          AppStrings.txtBranch: branchController.text,
          AppStrings.txtState: stateController.text,
          AppStrings.txtDistrict: districtController.text
        });
    if (data != null) {
      Get.back(result: {AppStrings.txtIFSCCode: data[AppStrings.txtIFSCCode]});
    }
  }
}
