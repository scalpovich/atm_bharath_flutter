import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/pages/home/home_binding.dart';
import 'package:atm_flutter_app/pages/home/home_page.dart';
import 'package:atm_flutter_app/pages/server/server_binding.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:atm_flutter_app/widgets/textfield_widget/underline_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../language/translation_service.dart';
import '../server/server_page.dart';

class SettingsController extends GetxController {
  final TextEditingController qrTimeController =
      TextEditingController(text: '60');
  final TextEditingController syncDurationController =
      TextEditingController(text: '2');
  final TextEditingController timeoutController =
      TextEditingController(text: '60');

  final appTheme = AppStrings.themeDefault.obs;
  get changeTheme => appTheme.value;

  final List<ThemeModel> themeList = [
    ThemeModel(AppStrings.themeDefault, AppColors.colorsPrimary),
    ThemeModel(AppStrings.txtRossoCorsa, AppColors.rossoCorsa),
    ThemeModel(AppStrings.txtFlame, AppColors.flame),
    ThemeModel(AppStrings.txtLightningYellow, AppColors.lightningYellow),
    ThemeModel(AppStrings.txtRhino, AppColors.rhino),
    ThemeModel(AppStrings.txtYaleBlue, AppColors.yaleBlue),
    ThemeModel(AppStrings.txtBlueIvy, AppColors.blueIvy),
    ThemeModel(AppStrings.txtDodgerBlue, AppColors.dodgerBlue),
    ThemeModel(
        AppStrings.txtShamrockGreenVColor, AppColors.shamrockGreenVColor),
    ThemeModel(AppStrings.txtLightForestGreen, AppColors.lightForestGreen),
    ThemeModel(AppStrings.txtJungleGreen, AppColors.jungleGreen),
    ThemeModel(AppStrings.txtPaleOliveGreen, AppColors.paleOliveGreen),
    ThemeModel(AppStrings.txtShipGrey, AppColors.shipGrey),
    ThemeModel(AppStrings.txtGreyishPurple, AppColors.greyishPurple),
    ThemeModel(AppStrings.txtLightEggplant, AppColors.lightEggplant),
    ThemeModel(AppStrings.txtPersianPink, AppColors.persianPink),
    ThemeModel(AppStrings.txtDark, AppColors.dark),
    ThemeModel(AppStrings.txtLight, AppColors.light),
  ];

  ///change Sync click dialog
  void onChangeSyncTap(BuildContext context) {
    Get.defaultDialog(
      title: 'change_sync_durations'.tr,
      contentPadding: context.mediaQueryViewInsets,
      titleStyle: TextStyle(color: Theme.of(context).primaryColor),
      content: SizedBox(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    height: 40,
                    width: 200,
                    child: UnderlineTextFieldWidget(
                      controller: syncDurationController,
                      labelText: 'Months in between 0-4',
                      enabled: true,
                      validate: true,
                      suffix: const SizedBox(),
                      type: TextInputType.number,
                      hint: '',
                    )),
              ]),
            ),
          ],
        ),
      ),
      cancel: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonWidget(
          label: 'close'.tr,
          width: 100,
          height: 35,
          btnColor: Theme.of(context).primaryColor,
          clicked: false,
          onTap: onCancelTap,
        ),
      ),
      confirm: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonWidget(
          label: 'set'.tr,
          width: 100,
          height: 35,
          btnColor: Theme.of(context).primaryColor,
          clicked: false,
          onTap: changeSyncTap,
        ),
      ),
    );
  }

  void onCancelTap() {
    Get.back();
  }

  void changeSyncTap() {
    PrefManager().setSyncDuration(timeoutController.text);
    Get.back();
    commonSnackBar('sync_duration_toast'.tr);
    syncDurationController.clear();
  }

  ///change qr time dialog
  void onChangeQRTimeTap(BuildContext context) {
    Get.defaultDialog(
      title: 'change_qr_show_time'.tr,
      contentPadding: context.mediaQueryViewInsets,
      titleStyle: TextStyle(color: Theme.of(context).primaryColor),
      content: SizedBox(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    height: 40,
                    width: 200,
                    child: UnderlineTextFieldWidget(
                      controller: qrTimeController,
                      labelText: 'Seconds in between 60-120',
                      enabled: true,
                      validate: true,
                      suffix: const SizedBox(),
                      type: TextInputType.number,
                      hint: '',
                    )),
              ]),
            ),
          ],
        ),
      ),
      cancel: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonWidget(
          label: 'close'.tr,
          width: 100,
          height: 35,
          btnColor: Theme.of(context).primaryColor,
          clicked: false,
          onTap: onCancelTap,
        ),
      ),
      confirm: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonWidget(
          label: 'set'.tr,
          btnColor: Theme.of(context).primaryColor,
          width: 100,
          height: 35,
          clicked: false,
          onTap: onChangeQRTap,
        ),
      ),
      onCancel: () => Get.back(),
      onConfirm: () {},
    );
  }

  void onChangeQRTap() {
    PrefManager().setQRTimeout(qrTimeController.text);
    Get.back();
    commonSnackBar('qr_time_toast'.tr);
    qrTimeController.clear();
  }

  ///change server
  void onChangeServerTap() {
    Get.to(() => const ServerPage(), binding: ServerBinding());
  }

  ///change server timeout time dialog
  void onChangeTimeoutTap(BuildContext context) {
    Get.defaultDialog(
      title: 'change_server_timeout_time'.tr,
      contentPadding: context.mediaQueryViewInsets,
      titleStyle: TextStyle(color: Theme.of(context).primaryColor),
      content: SizedBox(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    height: 40,
                    width: 200,
                    child: UnderlineTextFieldWidget(
                      controller: timeoutController,
                      labelText: 'Seconds in between 60-600',
                      enabled: true,
                      validate: true,
                      suffix: const SizedBox(),
                      type: TextInputType.number,
                      hint: '',
                    )),
              ]),
            ),
          ],
        ),
      ),
      cancel: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonWidget(
          label: 'close'.tr,
          btnColor: Theme.of(context).primaryColor,
          width: 100,
          clicked: false,
          onTap: onCancelTap,
        ),
      ),
      confirm: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonWidget(
          label: 'set'.tr,
          btnColor: Theme.of(context).primaryColor,
          width: 100,
          clicked: false,
          onTap: changeTimeoutTap,
        ),
      ),
    );
  }

  ///change language dialog
  void onChangeLanguage(BuildContext context) {
    String lang = PrefManager().getLanguage.toString();
    Get.defaultDialog(
      title: 'select_language'.tr,
      titleStyle: TextStyle(color: Theme.of(context).primaryColor),
      contentPadding: context.mediaQueryViewInsets,
      content: SizedBox(
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width: 150,
              child: GestureDetector(
                child: Card(
                  color: lang != 'English'
                      ? Theme.of(context).textTheme.bodyText1!.color
                      : Theme.of(context).primaryColor,
                  child: Center(
                    child: TextWidget(
                        text: 'english'.tr,
                        textColor: lang != 'English'
                            ? AppColors.black
                            : AppColors.white),
                  ),
                ),
                onTap: () => onLanguageTap('English'),
              ),
            ),
            SizedBox(
              height: 40,
              width: 150,
              child: GestureDetector(
                child: Card(
                  color: lang != 'Hindi'
                      ? Theme.of(context).textTheme.bodyText1!.color
                      : Theme.of(context).primaryColor,
                  child: Center(
                    child: TextWidget(
                        text: 'hindi'.tr,
                        textColor: lang != 'Hindi'
                            ? AppColors.black
                            : AppColors.white),
                  ),
                ),
                onTap: () => onLanguageTap('Hindi'),
              ),
            ),
            SizedBox(
              height: 40,
              width: 150,
              child: GestureDetector(
                child: Card(
                  color: lang != 'Malayalam'
                      ? Theme.of(context).textTheme.bodyText1!.color
                      : Theme.of(context).primaryColor,
                  child: Center(
                    child: TextWidget(
                        text: 'malayalam'.tr,
                        textColor: lang != 'Malayalam'
                            ? AppColors.black
                            : AppColors.white),
                  ),
                ),
                onTap: () => onLanguageTap('Malayalam'),
              ),
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: GestureDetector(
                child: Card(
                  color: lang != 'Marathi'
                      ? Theme.of(context).textTheme.bodyText1!.color
                      : Theme.of(context).primaryColor,
                  child: Center(
                    child: TextWidget(
                        text: 'marathi'.tr,
                        textColor: lang != 'Marathi'
                            ? AppColors.black
                            : AppColors.white),
                  ),
                ),
                onTap: () => onLanguageTap('Marathi'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onLanguageTap(String language) async {
    PrefManager().setLanguage(language);
    LocalizationService().changeLocale(language);
    Get.back();
  }

  void changeTimeoutTap() async {
    PrefManager().setTimeoutTime(timeoutController.text + '000');
    Get.back();
    commonSnackBar('server_time_toast'.tr);
    timeoutController.clear();
  }

  ///change theme dialog
  void onChangeTheme(BuildContext context) {
    Get.defaultDialog(
      title: 'select_theme'.tr,
      titleStyle:
          TextStyle(color: Theme.of(context).textTheme.bodyText2!.color!),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 15),
                itemCount: themeList.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      onThemeSelected(themeList[index].themeName);
                      Get.back();
                      Get.to(() => HomePage(), binding: HomeBinding());
                    },
                    child: Card(
                      color: themeList[index].theme,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(55.0),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void onThemeSelected(String theme) {
    appTheme.value = theme;
    PrefManager().setTheme(appTheme.value);
    // Get.back();
  }
}

class ThemeModel {
  String themeName;
  Color theme;

  ThemeModel(this.themeName, this.theme);
}
