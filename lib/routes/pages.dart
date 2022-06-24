import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_details/bbps_bill_details_binding.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_details/bbps_bill_details_page.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_payment/bbps_bills_payment_binding.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_payment/bbps_bills_payment_page.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_sub_category/bbps_sub_category_binding.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_sub_category/bbps_sub_category_page.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_number/mobile_number_binding.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_number/mobile_number_page.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_operator/mobile_operator_binding.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_operator/mobile_operator_page.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/recharge/mobile_recharge_binding.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/recharge/mobile_recharge_page.dart';
import 'package:atm_flutter_app/pages/bbps/payment_history/report/bbps_report_binding.dart';
import 'package:atm_flutter_app/pages/bbps/payment_history/report/bbps_report_page.dart';
import 'package:atm_flutter_app/pages/bbps/payment_history/report_details/bbps_payment_details_page.dart';
import 'package:atm_flutter_app/pages/bbps/show_bill/bbps_show_bill_binding.dart';
import 'package:atm_flutter_app/pages/bbps/show_bill/bbps_show_bill_page.dart';
import 'package:atm_flutter_app/pages/home/home_binding.dart';
import 'package:atm_flutter_app/pages/home/home_page.dart';
import 'package:atm_flutter_app/pages/login/login_binding.dart';
import 'package:atm_flutter_app/pages/login/login_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/account_search/money_transfer_account_search_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/account_search/money_transfer_account_search_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/add_transaction/money_transfer_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/add_transaction/money_transfer_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/fee_submit/money_transfer_fee_submit.dart';
import 'package:atm_flutter_app/pages/money_transfer/fee_submit/money_transfer_fee_submit_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/ifsc_search/ifsc_search_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/ifsc_search/ifsc_search_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/mobile_search/mobile_search_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/mobile_search/mobile_search_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/name_search/money_transfer_name_search_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/name_search/money_transfer_name_search_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/payment/payment_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/payment/payment_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/report/money_transfer_report_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/report/money_transfer_report_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/report_details/money_transfer_report_summary_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/report_details/money_transfer_report_summary_page.dart';
import 'package:atm_flutter_app/pages/profile/profile_page.dart';
import 'package:atm_flutter_app/pages/qr_code/qr_code_generate/qr_code_binding.dart';
import 'package:atm_flutter_app/pages/qr_code/qr_code_generate/qr_code_generate_page.dart';
import 'package:atm_flutter_app/pages/qr_code/report/qr_code_report_binding.dart';
import 'package:atm_flutter_app/pages/qr_code/report/qr_code_report_page.dart';
import 'package:atm_flutter_app/pages/qr_code/report_details/qr_code_report_summary_binding.dart';
import 'package:atm_flutter_app/pages/qr_code/report_details/qr_code_report_summary_page.dart';
import 'package:atm_flutter_app/pages/server/server_binding.dart';
import 'package:atm_flutter_app/pages/server/server_page.dart';
import 'package:atm_flutter_app/pages/settings/settings_binding.dart';
import 'package:atm_flutter_app/pages/settings/settings_page.dart';
import 'package:atm_flutter_app/pages/splash_screen/splash_scree_page.dart';
import 'package:atm_flutter_app/pages/sync/sync_binding.dart';
import 'package:atm_flutter_app/pages/sync/sync_page.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:get/get.dart';

import '../pages/bbps/mobile_recharge_page/operator_page/operator_binding.dart';
import '../pages/bbps/mobile_recharge_page/operator_page/operator_page.dart';
import '../pages/splash_screen/splash_screen_binding.dart';
import '../pages/splash_screen/splash_screen_controller.dart';

class AppPages {
  final routes = [
    GetPage(
        name: AppStrings.pSplashPage,
        page: () => SplashScreenPage(),
        binding: SplashScreenBinding()),
    GetPage(
        name: AppStrings.pLoginPage,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: AppStrings.pHomePage,
        page: () => HomePage(),
        binding: HomeBinding()),
    GetPage(name: AppStrings.pProfilePage, page: () => const ProfilePage()),
    GetPage(
        name: AppStrings.pSyncPage,
        page: () => const SyncPage(),
        binding: SyncBinding()),
    GetPage(
        name: AppStrings.pSettingsPage,
        page: () => const SettingsPage(),
        binding: SettingsBinding()),
    GetPage(
        name: AppStrings.pMoneyTransferPage,
        page: () => const MoneyTransferPage(),
        binding: MoneyTransferBinding()),
    GetPage(
        name: AppStrings.pAccountNoSearchPage,
        page: () => const MoneyTransferAccountSearchPage(),
        binding: MoneyTransferAccountSearchBinding()),
    GetPage(
        name: AppStrings.pNameSearchPage,
        page: () => const MoneyTransferNameSearchPage(),
        binding: MoneyTransferNameSearchBinding()),
    GetPage(
        name: AppStrings.pMobileSearchPage,
        page: () => const MobileSearchPage(),
        binding: MobileSearchBinding()),
    GetPage(
        name: AppStrings.pIFSCSearchPage,
        page: () => const IFSCSearchPage(),
        binding: IFSCSearchBinding()),
    GetPage(
        name: AppStrings.pPaymentPage,
        page: () => PaymentPage(),
        binding: PaymentBinding()),
    GetPage(
        name: AppStrings.pFeeSubmitPage,
        page: () => const MoneyTransferFeeSubmit(),
        binding: MoneyTransferFeeSubmitBinding()),
    GetPage(
        name: AppStrings.pMoneyTransferReportPage,
        page: () => const MoneyTransferReportPage(),
        binding: MoneyTransferReportBinding()),
    GetPage(
        name: AppStrings.pMoneyTransferReportDetailsPage,
        page: () => const MoneyTransferReportSummaryPage(),
        binding: MoneyTransferReportSummaryBinding()),
    GetPage(
        name: AppStrings.pQRCodePage,
        page: () => QRCodeGeneratePage(),
        binding: QRCodeBinding()),
    GetPage(
        name: AppStrings.pQRReportPage,
        page: () => QRCodeReportPage(),
        binding: QRCodeReportBinding()),
    GetPage(
        name: AppStrings.pQRReportDetailsPage,
        page: () => QRCodeReportSummaryPage(),
        binding: QRCodeReportSummaryBinding()),
    GetPage(
        name: AppStrings.pBBPSSubCategoryPage,
        page: () => const BBPSSubCategoryPage(),
        binding: BBPSSubCategoryBinding()),
    GetPage(
        name: AppStrings.pBBPSDetailsPage,
        page: () => const BBPSBillDetailsPage(),
        binding: BBPSBillDetailsBinding()),
    GetPage(
        name: AppStrings.pBBPSPaymentPage,
        page: () => const BBPSBillsPaymentPage(),
        binding: BBPSBillsPaymentBinding()),
    GetPage(
        name: AppStrings.pBBPSMobileDetailsPage,
        page: () => const MobileNumberPage(),
        binding: MobileNumberBinding()),
    GetPage(
        name: AppStrings.pBBPSMobileOperatorPage,
        page: () => const OperatorPage(),
        binding: OperatorBinding()),
    GetPage(
        name: AppStrings.pBBPSMobilePlanPage,
        page: () => const MobileOperatorPage(),
        binding: MobileOperatorBinding()),
    GetPage(
        name: AppStrings.pBBPSMobileRechargePage,
        page: () => const MobileRechargePage(),
        binding: MobileRechargeBinding()),
    GetPage(
        name: AppStrings.pBBPSShowBillPage,
        page: () => const BBPSShowBillPage(),
        binding: BBPSShowBillBinding()),
    GetPage(
        name: AppStrings.pBBPSDetailsPage,
        page: () => BBPSReportPage(),
        binding: BBPSReportBinding()),
    GetPage(
        name: AppStrings.pBBPSReportDetailsPage,
        page: () => const BBPSPaymentDetailsPage(),
        binding: BBPSBillsPaymentBinding()),
    GetPage(
        name: AppStrings.pServerPage,
        page: () => const ServerPage(),
        binding: ServerBinding()),
  ];
}
