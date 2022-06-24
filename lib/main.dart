import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/money_transfer/bank_name.dart';
import 'package:atm_flutter_app/model/server.dart';
import 'package:atm_flutter_app/pages/settings/settings_controller.dart';
import 'package:atm_flutter_app/pages/splash_screen/splash_screen_binding.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/resources/app_theme.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/routes/pages.dart';
import 'package:atm_flutter_app/utils/push_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'helper/device.dart';
import 'language/translation_service.dart';
import 'model/bbps/bbps_category.dart';
import 'model/bbps/bbps_report.dart';
import 'model/bbps/biller.dart';
import 'model/bbps/circle.dart';
import 'model/door_step/door_step_report.dart';
import 'model/money_transfer/money_transfer_report.dart';
import 'model/money_transfer/purpose.dart';
import 'model/qr/qr_report.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  _registerService();
  await Hive.initFlutter();
  _registerHiveAdapter();
  await Firebase.initializeApp();
  await SunmiPrinter.initPrinter();
  // String? deviceId = await Device().getUserId();
  // PrefManager().setDeviceId(deviceId!);
  await PushNotificationService().setupInteractedMessage();
  if (PrefManager().getLanguage == null) {
    PrefManager().setLanguage('English');
  }
  runApp(MyApp());
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    Log().logs('received-------', 'message');
  }
}

void _registerService() {
  Get.lazyPut(() => ApiService());
  Get.lazyPut(() => DatabaseOperations());
}

void _registerHiveAdapter() {
  if (!Hive.isAdapterRegistered(BankNameAdapter().typeId)) {
    Hive.registerAdapter(BankNameAdapter());
  }
  if (!Hive.isAdapterRegistered(BBPSCategoryAdapter().typeId)) {
    Hive.registerAdapter(BBPSCategoryAdapter());
  }
  if (!Hive.isAdapterRegistered(BBPSReportAdapter().typeId)) {
    Hive.registerAdapter(BBPSReportAdapter());
  }
  if (!Hive.isAdapterRegistered(CircleAdapter().typeId)) {
    Hive.registerAdapter(CircleAdapter());
  }
  if (!Hive.isAdapterRegistered(DoorStepReportsAdapter().typeId)) {
    Hive.registerAdapter(DoorStepReportsAdapter());
  }
  if (!Hive.isAdapterRegistered(MoneyTransferReportAdapter().typeId)) {
    Hive.registerAdapter(MoneyTransferReportAdapter());
  }
  if (!Hive.isAdapterRegistered(PurposeAdapter().typeId)) {
    Hive.registerAdapter(PurposeAdapter());
  }
  if (!Hive.isAdapterRegistered(QRReportAdapter().typeId)) {
    Hive.registerAdapter(QRReportAdapter());
  }
  if (!Hive.isAdapterRegistered(BillerAdapter().typeId)) {
    Hive.registerAdapter(BillerAdapter());
  }
  if (!Hive.isAdapterRegistered(AuthenticatorAdapter().typeId)) {
    Hive.registerAdapter(AuthenticatorAdapter());
  }
  if (!Hive.isAdapterRegistered(ServerAdapter().typeId)) {
    Hive.registerAdapter(ServerAdapter());
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final box = GetStorage();

  final SettingsController _settingsController = Get.put(SettingsController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String? theme = PrefManager().getTheme ?? AppStrings.themeDefault;
    _settingsController.onThemeSelected(theme);
    return Obx(
      () => GetMaterialApp(
        theme: _changeTheme(_settingsController.changeTheme),
        // color: AppColors.colorsPrimary,
        title: 'app_name'.tr,
        initialRoute: AppStrings.pSplashPage,
        initialBinding: SplashScreenBinding(),
        getPages: AppPages().routes,
        locale: LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        // theme: AppThemes.lightThemeData,
        // darkTheme: AppThemes.darkThemeData,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.leftToRightWithFade,
      ),
    );
  }

  _changeTheme(String? themeName) {
    switch (themeName) {
      case AppStrings.txtRossoCorsa:
        return AppTheme.rossoCorsaTheme;
      case AppStrings.txtFlame:
        return AppTheme.flameTheme;
      case AppStrings.txtLightningYellow:
        return AppTheme.lightningYellowTheme;
      case AppStrings.txtRhino:
        return AppTheme.rhinoTheme;
      case AppStrings.txtYaleBlue:
        return AppTheme.yaleBlueTheme;
      case AppStrings.txtBlueIvy:
        return AppTheme.blueIvyTheme;
      case AppStrings.txtDodgerBlue:
        return AppTheme.dodgerBlueTheme;
      case AppStrings.txtShamrockGreenVColor:
        return AppTheme.shamrockGreenVColorTheme;
      case AppStrings.txtLightForestGreen:
        return AppTheme.lightForestGreenTheme;
      case AppStrings.txtJungleGreen:
        return AppTheme.jungleGreenTheme;
      case AppStrings.txtPaleOliveGreen:
        return AppTheme.paleOliveGreenTheme;
      case AppStrings.txtShipGrey:
        return AppTheme.shipGreyTheme;
      case AppStrings.txtGreyishPurple:
        return AppTheme.greyishPurpleTheme;
      case AppStrings.txtLightEggplant:
        return AppTheme.lightEggplantTheme;
      case AppStrings.txtPersianPink:
        return AppTheme.persianPinkTheme;
      case AppStrings.txtDark:
        return AppTheme.darkTheme;
      case AppStrings.txtLight:
        return AppTheme.lightTheme;
      case AppStrings.themeDefault:
        return AppTheme.defaultTheme;
      default:
        return AppTheme.defaultTheme;
    }
  }
}
