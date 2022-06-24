import 'package:atm_flutter_app/pages/home/home_binding.dart';
import 'package:atm_flutter_app/pages/home/home_page.dart';
import 'package:atm_flutter_app/pages/settings/settings_controller.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:atm_flutter_app/widgets/tile_widget/settings_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0)),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Image.asset(
          AppDrawable.filePath + AppDrawable.atmLogoCropped,
          color: Theme.of(context).appBarTheme.titleTextStyle!.color,
          height: 40,
          width: 100,
        ),
        leading: IconButtonWidget(
          icon: Icons.arrow_back_ios,
          iconSize: 25,
          iconColor: Theme.of(context).textTheme.bodyText1!.color!,
          onTap: () => Get.to(() => HomePage(), binding: HomeBinding()),
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SettingsListTileWidget(
                leadingIcon: Icons.sync,
                title: 'change_sync_duration'.tr,
                onTap: () => controller.onChangeSyncTap(context),
              ),
              SettingsListTileWidget(
                leadingIcon: Icons.qr_code,
                title: 'change_qr_time'.tr,
                onTap: () => controller.onChangeQRTimeTap(context),
              ),
              SettingsListTileWidget(
                leadingIcon: Icons.api,
                title: 'change_server'.tr,
                onTap: controller.onChangeServerTap,
              ),
              SettingsListTileWidget(
                leadingIcon: Icons.timer_outlined,
                title: 'change_timeout_time'.tr,
                onTap: () => controller.onChangeTimeoutTap(context),
              ),
              SettingsListTileWidget(
                leadingIcon: Icons.language,
                title: 'change_language'.tr,
                onTap: () => controller.onChangeLanguage(context),
              ),
              SettingsListTileWidget(
                leadingIcon: Icons.color_lens_outlined,
                title: 'change_theme'.tr,
                onTap: () => controller.onChangeTheme(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
