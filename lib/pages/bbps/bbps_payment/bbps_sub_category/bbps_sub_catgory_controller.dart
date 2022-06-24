import 'dart:convert';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_details/bbps_bill_details_binding.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_details/bbps_bill_details_page.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../constants/database_constants.dart';
import '../../../../helper/log.dart';
import '../../../../helper/prefManager.dart';
import '../../../../model/bbps/bbps_category.dart';
import '../../../../model/bbps/biller.dart';
import '../../../../resources/app_drawables.dart';
import '../../../../resources/app_strings.dart';
import '../../../../retrofit/api_service.dart';
import '../../../../retrofit/apis.dart';
import '../../../../retrofit/body.dart';
import '../../../../retrofit/headers.dart';
import '../../../../utils/aes_encryption.dart';
import '../../../../utils/api_req_res_format.dart';
import '../../../../widgets/dialog_box_widget/snack_bar.dart';

class BBPSSubCategoryController extends MainController {
  dynamic arguments = Get.arguments;

  final TextEditingController searchController = TextEditingController();
  RxList<BBPSCategory> bbpsCategoryList = <BBPSCategory>[].obs;
  RxList<Biller> operatorSeriesList = <Biller>[].obs;
  RxList<Authenticator> authenticatorList = <Authenticator>[].obs;
  RxList<BBPSCategory> billersList = <BBPSCategory>[].obs;
  RxList<Authenticator> parameterList = <Authenticator>[].obs;
  List<BBPSCategory> categoryList = [];
  RxList<bool> authValidateList = RxList();
  RxList<BBPSCategory> dbBillerList = RxList();
  RxBool isLoading = false.obs;
  RxString categoryLogo = ''.obs;
  RxString categoryTitle = ''.obs;
  RxString categoryImg = AppDrawable.broadband.obs;
  RxString index = ''.obs;
  String senderName = '';
  String senderMobile = '';

  @override
  void onInit() {
    super.onInit();
    categoryTitle.value = arguments[AppStrings.txtCategory].toString();
    categoryImg.value = arguments[AppStrings.txtCategoryImage].toString();
    senderName = arguments[AppStrings.txtSenderName] ?? '';
    senderMobile = arguments[senderMobile] ?? '';
    setCategoryImage();
    searchController.addListener(() {
      searchCategory(searchController.text);
    });
    getBiller();
  }

  ///search biller data
  Future<void> searchCategory(String value) async {
    List<BBPSCategory> bbpsSearchList = [];
    bbpsSearchList.addAll(bbpsCategoryList.value);
    if (value.isNotEmpty) {
      List<BBPSCategory> searchList = [];
      bbpsSearchList.forEach((element) {
        if (element.billerName
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase())) {
          searchList.add(element);
        }
      });
      bbpsCategoryList.clear();
      bbpsCategoryList.addAll(searchList);
    } else {
      bbpsCategoryList.addAll(categoryList);
    }
  }

  ///getting biller data from db or server
  void getBiller() async {
    bool isTableEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbBillers);
    if (isTableEmpty) {
      getBillerFromDB();
    } else {
      getBillerFromApi();
    }
  }

  ///getting biller data from server
  Future<void> getBillerFromApi() async {
    isLoading.value = true;
    dynamic body = await bbpsBillerBody(categoryName: categoryTitle.toString());
    final jsonBody = json.encode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    final result = await ApiService().postMethod(
        reqBody,
        commonHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.OPERATOR_LIST);
    if (result!.data != null) {
      if (result.status!) {
        _getBillerListFromDB();
        bbpsCategoryList.clear();
        categoryList.clear();
        dynamic dataResult = result.data;
        isLoading.value = false;
        for (int i = 0; i < dataResult.length; i++) {
          final jsonEncoded = json.encode(dataResult[i]);
          final jsonDecoded = json.decode(jsonEncoded);
          final billerCategory = BBPSCategory.fromJson(jsonDecoded);
          bbpsCategoryList.add(billerCategory);
          billersList.add(billerCategory);
        }
        categoryList = bbpsCategoryList;
        _addToBillerListTableDB();
      } else {
        isLoading.value = false;
        commonSnackBar(result.message!);
      }
    } else {
      isLoading.value = false;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///adding biller data to db
  _addToBillerListTableDB() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    billersList.addAll(dbBillerList);
    box.put(DatabaseConstants.dbBillers, billersList.toList());
  }

  ///getting biller data from db
  Future getBillerFromDB() async {
    bbpsCategoryList.clear();
    categoryList.clear();
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    List<BBPSCategory> billerListDB =
        box.get(DatabaseConstants.dbBillers).toList().cast<BBPSCategory>();
    dbBillerList.value = billerListDB;
    List<BBPSCategory> billerList = billerListDB
        .where((element) =>
            element.billerCategory.toString() == categoryTitle.value)
        .toList()
        .cast<BBPSCategory>();
    isLoading.value = false;
    bbpsCategoryList.value = billerList;
    List<Authenticator> authList = [];
    for (var element in billerList) {
      authList.addAll(element.authenticators!);
    }
    if (bbpsCategoryList.isEmpty) {
      getBillerFromApi();
    } else {
      categoryList = bbpsCategoryList;
    }
  }

  ///getting biller data list from db
  void _getBillerListFromDB() async {
    // isLoading.value = true;
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool isTableEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbBillers);
    List<BBPSCategory> billList = [];
    if (isTableEmpty) {
      billList =
          box.get(DatabaseConstants.dbBillers).toList().cast<BBPSCategory>();
      billersList.value = billList;
    }
  }

  ///item click
  void onBillerTap(int i) {
    Get.to(() => const BBPSBillDetailsPage(),
        binding: BBPSBillDetailsBinding(),
        arguments: {
          AppStrings.txtCategoryList: bbpsCategoryList[i],
          AppStrings.txtCategory: categoryTitle.value,
          AppStrings.txtSenderName: senderName,
          AppStrings.txtSenderMobile: senderMobile,
        });
  }

  ///setting category image from using category type
  void setCategoryImage() {
    switch (categoryTitle.value) {
      case 'DTH':
        categoryImg.value = AppDrawable.dth;
        break;
      case 'FASTag':
        categoryImg.value = AppDrawable.fastag;
        break;
      case 'Electricity':
        categoryImg.value = AppDrawable.electricity;
        break;
      case 'Piped Gas':
        categoryImg.value = AppDrawable.pipelineGas;
        break;
      case 'LPG Cylinder':
        categoryImg.value = AppDrawable.cylinder;
        break;
      case 'Water':
        categoryImg.value = AppDrawable.pipelineWater;
        break;
      case 'Broadband':
        categoryImg.value = AppDrawable.broadband;
        break;
      case 'Landline':
        categoryImg.value = AppDrawable.landlinePostpaid;
        break;
      case 'Cable TV':
        categoryImg.value = AppDrawable.cableTv;
        break;
      case 'Postpaid':
        categoryImg.value = AppDrawable.mobilePostpaid;
        break;
      case 'Insurance':
        categoryImg.value = AppDrawable.insurance;
        break;
      case 'Loan':
        categoryImg.value = AppDrawable.loan;
        break;
      case 'Credit Card':
        categoryImg.value = AppDrawable.creditCard;
        break;
      case 'Tax':
        categoryImg.value = AppDrawable.municipalTax;
        break;
      case 'Municipal Services':
        categoryImg.value = AppDrawable.municipalService;
        break;
      case 'Hospital':
        categoryImg.value = AppDrawable.hospital;
        break;
      case 'Housing Society':
        categoryImg.value = AppDrawable.housingSociety;
        break;
      case 'Subscription':
        categoryImg.value = AppDrawable.subscriptionFee;
        break;
      case 'Donation':
        categoryImg.value = AppDrawable.donation;
        break;
      case 'Clubs And Associations':
        categoryImg.value = AppDrawable.clubsAndAssociations;
        break;
    }
  }
}
