import 'dart:async';

import 'package:atm_flutter_app/constants/prefs_constants.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/pages/home/home_binding.dart';
import 'package:atm_flutter_app/pages/home/home_page.dart';
import 'package:atm_flutter_app/pages/login/login_binding.dart';
import 'package:atm_flutter_app/pages/login/login_page.dart';
import 'package:atm_flutter_app/pages/splash_screen/splash_screen_controller.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashScreenPage extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Center(
                child: Image.asset(
                  AppDrawable.filePath + AppDrawable.atmBharathLogo,
                  width: 80,
                  height: 80,
                  color: Theme.of(context).primaryColor,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
              flex: 0,
              child: Obx(
                () => Visibility(
                  visible: !controller.hasConnection.value,
                  child: ColoredBox(
                    color: Theme.of(context).primaryColor,
                    child: SizedBox(
                      width: Get.width,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextWidget(
                                text: 'No Internet Connection!',
                                textColor: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!),
                          ),
                          Expanded(
                            flex: 0,
                            child: ButtonWidget(
                              label: 'Retry',
                              width: 70,
                              labelColor: Theme.of(context).primaryColor,
                              height: 35,
                              btnColor:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              clicked: false,
                              onTap: () => controller.checkInternetConnection(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
