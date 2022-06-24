import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_payment/bbps_bills_payment_binding.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_payment/bbps_bills_payment_page.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:get/get.dart';

class BBPSShowBillController extends GetxController {
  dynamic arguments = Get.arguments;
  final billLogo = ''.obs;
  final billerName = ''.obs;
  final category = ''.obs;
  final billId = ''.obs;
  final billStatus = ''.obs;
  final billNumber = ''.obs;
  final billPeriod = ''.obs;
  final netBillAmount = ''.obs;
  final customerName = ''.obs;
  final billAmount = ''.obs;
  final billDate = ''.obs;
  final billDueDate = ''.obs;
  final sourceRefNo = ''.obs;
  final categoryImage = ''.obs;

  List<String> bDate = [];
  List<String> bdDate = [];

  @override
  void onInit() {
    super.onInit();
    getBillInfo();
  }

  ///setting bill info
  void getBillInfo() async {
    categoryImage.value = arguments[AppStrings.txtCategoryImage].toString();
    billerName.value = arguments[AppStrings.txtBillerName].toString();
    billId.value = arguments[AppStrings.txtBillId].toString();
    billStatus.value = arguments[AppStrings.txtBillStatus].toString();
    billAmount.value = arguments[AppStrings.txtBillAmount].toString();
    customerName.value = arguments[AppStrings.txtCustomerName].toString();
    billPeriod.value = arguments[AppStrings.txtBillPeriod].toString();
    billDate.value = arguments[AppStrings.txtBillDate].toString();
    billDueDate.value = arguments[AppStrings.txtBillDueDate].toString();
    sourceRefNo.value = arguments[AppStrings.txtSourceRefNo].toString();
    category.value = arguments[AppStrings.txtCategory].toString();
    bDate = billDate.value.split('T');
    bdDate = billDueDate.value.split('T');
  }

  ///go to payment page when pay clicked
  void onTap() {
    Get.to(() => const BBPSBillsPaymentPage(),
        binding: BBPSBillsPaymentBinding(),
        arguments: {
          AppStrings.txtParameterValue: arguments[AppStrings.txtParameterValue],
          AppStrings.txtRequiredField: arguments[AppStrings.txtRequiredField],
          AppStrings.txtAuthCount: arguments[AppStrings.txtAuthCount],
          AppStrings.txtCategory: arguments[AppStrings.txtCategory],
          AppStrings.txtIpAddress: arguments[AppStrings.txtIpAddress],
          AppStrings.txtPostalCode: arguments[AppStrings.txtPostalCode],
          AppStrings.txtLatLng: arguments[AppStrings.txtLatLng],
          AppStrings.txtSenderMobile: arguments[AppStrings.txtSenderMobile],
          AppStrings.txtSenderName: arguments[AppStrings.txtSenderName],
          AppStrings.txtBillerName: arguments[AppStrings.txtBillerName],
          AppStrings.txtBillerId: arguments[AppStrings.txtBillerId],
          AppStrings.txtOperatorImage: categoryImage.value,
          AppStrings.txtPartialPay: arguments[AppStrings.txtPartialPay],
        });
  }
}
