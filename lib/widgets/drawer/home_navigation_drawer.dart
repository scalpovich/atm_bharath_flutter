import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/pages/login/login_binding.dart';
import 'package:atm_flutter_app/pages/login/login_page.dart';
import 'package:atm_flutter_app/pages/profile/profile_page.dart';
import 'package:atm_flutter_app/pages/settings/settings_page.dart';
import 'package:atm_flutter_app/pages/sync/sync_binding.dart';
import 'package:atm_flutter_app/pages/sync/sync_page.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pages/settings/settings_binding.dart';
import '../button_widget/button_widget.dart';

class HomeNavigationDrawer extends StatelessWidget {
  const HomeNavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DrawerHeader(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        AppDrawable.filePath + AppDrawable.atmLogoCropped,
                        height: 60,
                        width: 95,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: Center(
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      'view_profile'.tr,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle1!.color!,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Get.to(() => const ProfilePage());
                    },
                  ),
                ),
              ),
              // const Divider(
              //   color: AppColors.grey,
              //   thickness: 0.5,
              // ),
              SizedBox(
                height: 45,
                child: ListTile(
                  leading: Icon(
                    Icons.sync,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'sync'.tr,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1!.color!,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Get.to(() => const SyncPage(), binding: SyncBinding());
                  },
                ),
              ),
              SizedBox(
                height: 45,
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'settings'.tr,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1!.color!,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Get.offAll(() => const SettingsPage(),
                        binding: SettingsBinding());
                  },
                ),
              ),
              SizedBox(
                height: 45,
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'logout'.tr,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1!.color!,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () => logoutDialog(),
                ),
              ),
            ],
          ),
        ));
  }

  void logoutDialog() {
    Get.defaultDialog(
        title: '',
        content: TextWidget(
            text: 'logout_dialog'.tr,
            textColor: Theme.of(Get.context!).textTheme.subtitle1!.color!),
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
          onTap: onLogoutTap,
        ));
  }

  void onCancelTap() {
    Get.back();
  }

  void onLogoutTap() {
    PrefManager().setLoginFlag(false);
    PrefManager().setBBPS(false);
    PrefManager().setDoorStep(false);
    PrefManager().setMoneyTransfer(false);
    PrefManager().setQR(false);
    PrefManager().setSyncFlag(false);
    Get.offAll(() => const LoginPage(), binding: LoginBinding());
  }
}
