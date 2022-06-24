import 'dart:convert';
import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/bbps/bbps_report.dart';
import 'package:atm_flutter_app/model/bbps/bbps_status.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_sub_category/bbps_sub_category_binding.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_sub_category/bbps_sub_category_page.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_number/mobile_number_page.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/headers.dart';
import 'package:atm_flutter_app/utils/aes_encryption.dart';
import 'package:atm_flutter_app/utils/api_req_res_format.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:atm_flutter_app/utils/print_receipt.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import '../../../../resources/app_drawables.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/button_widget/button_widget.dart';
import '../../../home/home_binding.dart';
import '../../../home/home_page.dart';
import '../../mobile_recharge_page/mobile_number/mobile_number_binding.dart';

class BBPSPaymentDetailsController extends MainController {
  dynamic arguments = Get.arguments;
  RxString paymentId = ''.obs;
  RxString senderName = ''.obs;
  RxString senderMobile = ''.obs;
  RxString subscriberId = ''.obs;
  RxString parameterName = ''.obs;
  RxString parameterValue = ''.obs;
  RxString bbpsRefNo = ''.obs;
  RxString billerName = ''.obs;
  RxString billerID = ''.obs;
  RxString billDate = ''.obs;
  RxString billAmount = ''.obs;
  RxString convFee = ''.obs;
  RxDouble totalAmount = 0.0.obs;
  RxString paymentChannel = ''.obs;
  RxString paymentMode = ''.obs;
  RxString traceId = ''.obs;
  RxString refNo = ''.obs;
  RxString category = ''.obs;
  RxString categoryImage = ''.obs;
  RxString status = ''.obs;
  RxBool isLoading = false.obs;
  RxBool home = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bindingPrinter();
    getReportDetails();
  }

  ///binding printer
  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  ///setting report details
  void getReportDetails() async {
    String dateFormat;
    String dateReplace =
        arguments[AppStrings.txtBillDate].toString().replaceAll('T', ' ');
    List<String> replaceList = dateReplace.split('+');
    DateTime changeDate = DateTime.parse(replaceList[0].toString());
    String transDate = DateFormat('yyyy-MM-dd').format(changeDate).toString();
    DateTime date = DateTime.parse(transDate);
    dateFormat = DateFormat('dd-MM-yyyy').format(date).toString();
    paymentId.value = arguments[AppStrings.txtPaymentId] ?? '';
    senderName.value = arguments[AppStrings.txtSenderName] ?? '';
    senderMobile.value =
        await decryptMobileNo(arguments[AppStrings.txtSenderMobile]);
    subscriberId.value =
        await decryptMobileNo(arguments[AppStrings.txtParameterValue]);
    bbpsRefNo.value = arguments[AppStrings.txtBBPSRefNo] ?? '';
    billerName.value = arguments[AppStrings.txtBillerName] ?? '';
    billerID.value = arguments[AppStrings.txtBillerId] ?? '';
    billDate.value = dateFormat;
    billAmount.value = arguments[AppStrings.txtBillAmount];
    convFee.value = arguments[AppStrings.txtConvFee] ?? '0';
    paymentChannel.value = arguments[AppStrings.txtPaymentChannel] ?? '';
    paymentMode.value = arguments[AppStrings.txtPaymentMode] ?? '';
    parameterName.value = arguments[AppStrings.txtParameterName] ?? '';
    parameterName.value.replaceAll('[', '');
    parameterName.value.replaceAll(']', '');
    totalAmount.value = (double.parse(billAmount.value.toString())) +
        double.parse(convFee.value);
    traceId.value = arguments[AppStrings.txtTraceId];
    refNo.value = arguments['ref_no'].toString();
    category.value = arguments[AppStrings.txtCategory].toString();
    setCategoryImage(category.value);
    Log().logs('category::', category.value.toString());
    status.value = arguments[AppStrings.txtStatus].toString();
    home.value = arguments['home'];
    if (status.value == 'PENDING') {
      isLoading.value = true;
      getStatusFromApi();
    }
  }

  ///decrypt mobile number
  Future<String> decryptMobileNo(String value) async {
    String mobileNo = await AesEncryption()
        .decrypt(value.toString(), PrefManager().getCustomerCode.toString());
    return mobileNo;
  }

  ///repeat button click function
  void onRepeatTap() {
    Get.defaultDialog(
        title: '',
        content: TextWidget(
            text: 'repeat_payment_dialog'.tr, textColor: AppColors.black),
        cancel: ButtonWidget(
          label: 'cancel'.tr,
          width: 100,
          clicked: false,
          btnColor: Theme.of(Get.context!).primaryColor,
          onTap: onCancelTap,
        ),
        confirm: ButtonWidget(
          label: 'ok'.tr,
          width: 100,
          btnColor: Theme.of(Get.context!).primaryColor,
          clicked: false,
          onTap: onOkTap,
        ));
  }

  ///cancel function
  void onCancelTap() {
    Get.back();
  }

  ///ok click function
  void onOkTap() {
    if (category.value == AppStrings.txtMobilePrepaid) {
      Get.off(() => const MobileNumberPage(),
          binding: MobileNumberBinding(),
          arguments: {
            AppStrings.txtSenderName: senderName.value,
            AppStrings.txtSenderMobile: senderMobile.value,
            AppStrings.txtMobileNo: parameterValue.value,
          });
    } else {
      Get.off(() => const BBPSSubCategoryPage(),
          binding: BBPSSubCategoryBinding(),
          arguments: {
            AppStrings.txtSenderName: senderName.value,
            AppStrings.txtSenderMobile: senderMobile.value,
            AppStrings.txtCategory: category,
          });
    }
  }

  ///checking status from server
  void getStatusFromApi() async {
    dynamic body = {
      'reference_no': refNo.value,
      'payment_id': paymentId.value,
      'trace_id': traceId.value,
      'mobile': senderMobile.value,
    };
    final jsonBody = jsonEncode(body);
    Log().logs('checkStat::', jsonBody.toString());
    Log().logs('Header::', commonHeader.toString());
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    dynamic result = await ApiService().postMethod(
        reqBody,
        commonHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.BBPS_CHECK_STATUS);
    isLoading.value = false;
    if (result != null) {
      if (result.status!) {
        final jsonEncodeRes = jsonEncode(result.data);
        final jsonDecodeRes = jsonDecode(jsonEncodeRes);
        final responseData = BBPSStatus.fromJson(jsonDecodeRes);
        if (responseData.billerStatus == 'SUCCESS') {
          String money =
              PrefManager().getWalletMoney.toString().replaceAll(',', '');
          List<String> wallet = money.split('.');
          String walletMoney = wallet[0];
          double finalAmount = double.parse(walletMoney) -
              double.parse(responseData.paymentAmount.toString());
          String? userWallet = Utils().convertDecimal(finalAmount);
          PrefManager().setWalletMoney(userWallet.toString());
        }
        await updateStatus(responseData);
        status.value = responseData.billerStatus.toString();
      } else {
        commonSnackBar(result.message!);
      }
    } else {
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///update status in db after response
  Future<void> updateStatus(BBPSStatus bbpsStatus) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbBBPSReports);
    dynamic res = box.get(DatabaseConstants.dbBBPSReports);
    if (res != null) {
      List<BBPSReport> bbpsList =
          box.get(DatabaseConstants.dbBBPSReports).toList().cast<BBPSReport>();
      final index = bbpsList.indexWhere((element) =>
          element.transactionId.toString() ==
          bbpsStatus.transactionId.toString());
      final bbpsReport = BBPSReport(
          transactionId: bbpsList[index].transactionId,
          transactionDate: bbpsList[index].transactionDate,
          commissionAmount: bbpsList[index].commissionAmount,
          status: bbpsStatus.billerStatus,
          type: bbpsList[index].type,
          cess: bbpsList[index].cess,
          sgst: bbpsList[index].sgst,
          cgst: bbpsList[index].cgst,
          fromName: bbpsList[index].fromName,
          transferMode: bbpsList[index].transferMode,
          amount: bbpsList[index].amount,
          endCstmrName: bbpsList[index].endCstmrName,
          endCstmrMob: bbpsList[index].endCstmrMob,
          benefAccNo: bbpsList[index].benefAccNo,
          benfIfsc: bbpsList[index].benfIfsc,
          billerLogo: bbpsList[index].billerLogo,
          statusDescription: bbpsList[index].statusDescription,
          tranType: bbpsList[index].tranType,
          parameterName: bbpsList[index].parameterName,
          parameterValue: bbpsList[index].parameterValue,
          bbpsRefNo: bbpsList[index].bbpsRefNo,
          billerName: bbpsList[index].billerName,
          billerId: bbpsList[index].billerId,
          convFee: bbpsList[index].convFee,
          isBillerBbps: bbpsList[index].isBillerBbps,
          paymentChannel: AppStrings.txtAgent,
          referenceNo: bbpsList[index].referenceNo,
          billerCategory: bbpsList[index].billerCategory,
          authCount: bbpsList[index].authCount,
          paymentId: bbpsList[index].paymentId,
          traceId: bbpsList[index].traceId);
      bbpsList.insert(index, bbpsReport);
      bbpsList.removeAt(index + 1);
      box.put(DatabaseConstants.dbBBPSReports, bbpsList);
    }
  }

  ///printing report details after payment success
  void onPrintTap() {
    PrintReceipt().bbpsReceiptPrint(
        paymentId.value,
        senderMobile.value,
        parameterName.value,
        subscriberId.value,
        bbpsRefNo.value,
        billerName.value,
        billerID.value,
        billDate.value,
        double.parse(convFee.value),
        billAmount.value,
        paymentChannel.value);
  }

  Future<bool> onBackPressed() async {
    {
      if (home.value) {
        Get.off(() => HomePage(), binding: HomeBinding());
        return false;
      } else {
        Get.back();
        return false;
      }
    }
  }

  ///setting category image from using category type
  void setCategoryImage(String categoryTitle) {
    switch (categoryTitle) {
      case 'Mobile Prepaid':
        categoryImage.value = AppDrawable.mobileRecharge;
        break;
      case 'DTH':
        categoryImage.value = AppDrawable.dth;
        break;
      case 'FASTag':
        categoryImage.value = AppDrawable.fastag;
        break;
      case 'Electricity':
        categoryImage.value = AppDrawable.electricity;
        break;
      case 'Piped Gas':
        categoryImage.value = AppDrawable.pipelineGas;
        break;
      case 'LPG Cylinder':
        categoryImage.value = AppDrawable.cylinder;
        break;
      case 'Water':
        categoryImage.value = AppDrawable.pipelineWater;
        break;
      case 'Broadband':
        categoryImage.value = AppDrawable.broadband;
        break;
      case 'Landline':
        categoryImage.value = AppDrawable.landlinePostpaid;
        break;
      case 'Cable TV':
        categoryImage.value = AppDrawable.cableTv;
        break;
      case 'Postpaid':
        categoryImage.value = AppDrawable.mobilePostpaid;
        break;
      case 'Insurance':
        categoryImage.value = AppDrawable.insurance;
        break;
      case 'Loan':
        categoryImage.value = AppDrawable.loan;
        break;
      case 'Credit Card':
        categoryImage.value = AppDrawable.creditCard;
        break;
      case 'Tax':
        categoryImage.value = AppDrawable.municipalTax;
        break;
      case 'Municipal Services':
        categoryImage.value = AppDrawable.municipalService;
        break;
      case 'Hospital':
        categoryImage.value = AppDrawable.hospital;
        break;
      case 'Housing Society':
        categoryImage.value = AppDrawable.housingSociety;
        break;
      case 'Subscription':
        categoryImage.value = AppDrawable.subscriptionFee;
        break;
      case 'Donation':
        categoryImage.value = AppDrawable.donation;
        break;
      case 'Clubs And Associations':
        categoryImage.value = AppDrawable.clubsAndAssociations;
        break;
    }
  }
}
