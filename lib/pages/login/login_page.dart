import 'package:atm_flutter_app/pages/login/login_controller.dart';
import 'package:atm_flutter_app/pages/sync/sync_binding.dart';
import 'package:atm_flutter_app/pages/sync/sync_page.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/button_widget/login_icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/textfield_widget/underline_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginWidget(
        deviceIdController: controller.deviceIdController,
        passwordController: controller.passwordController,
      ),
    );
  }
}

class LoginWidget extends GetView<LoginController> {
  final box = GetStorage();

  LoginWidget(
      {Key? key,
      required TextEditingController deviceIdController,
      required TextEditingController passwordController})
      : _deviceIdController = deviceIdController,
        _passwordController = passwordController,
        super(key: key);
  final TextEditingController _passwordController;
  final TextEditingController _deviceIdController;

  final List<String> userList = [AppStrings.txtMerchant, AppStrings.txtDriver];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: const EdgeInsets.all(25.0),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'assets/icons/atm_bharath_logo.png',
                            width: 70,
                            height: 70,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        UnderlineTextFieldWidget(
                          enabled: false,
                          validate: controller.deviceIdValidate.value,
                          errorText: 'device_id_required'.tr,
                          hint: 'device_serial_no'.tr,
                          labelText: 'device_serial_no'.tr,
                          controller: _deviceIdController,
                          suffix: const SizedBox(),
                          type: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => UnderlineTextFieldWidget(
                            enabled: true,
                            textCapital: TextCapitalization.characters,
                            suffix: const SizedBox(),
                            type: TextInputType.text,
                            errorText: 'customer_code_required'.tr,
                            validate: controller.custCodeValidate.value,
                            labelText: 'customer_code'.tr,
                            controller: _passwordController,
                            hint: 'customer_code'.tr,
                          ),
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LoginIconButtonWidget(
                                  selected: controller.isMerchant.value,
                                  icon: Icons.shopping_cart_rounded,
                                  userTypeText: AppStrings.txtMerchant,
                                  iconSize: 15,
                                  iconColor: Theme.of(context).primaryColor,
                                  containerColor:
                                      Theme.of(context).primaryColor,
                                  onTap: controller.userTypeOnTap,
                                ),
                                LoginIconButtonWidget(
                                  selected: controller.isDriver.value,
                                  icon: Icons.delivery_dining,
                                  userTypeText: AppStrings.txtDriver,
                                  iconSize: 15,
                                  iconColor: Theme.of(context).primaryColor,
                                  containerColor:
                                      Theme.of(context).primaryColor,
                                  onTap: controller.userTypeOnTap,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => ButtonWidget(
                            onTap: _onLoginTap,
                            label: 'login'.tr,
                            width: 150,
                            btnColor: Theme.of(context).primaryColor,
                            clicked: controller.btnClicked.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: IconButton(
                    onPressed: controller.goToServerPage,
                    icon: ImageIcon(
                      const AssetImage(
                          AppDrawable.filePath + AppDrawable.serverImage),
                      size: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _onLoginTap() async {
    FocusScope.of(Get.context!).unfocus();
    if (controller.deviceIdController.text.isNotEmpty &&
        controller.passwordController.text.isNotEmpty) {
      controller.btnClicked.value = true;
      bool success = await controller.loginUser();
      if (success) {
        controller.btnClicked.value = false;
        Get.off(() => const SyncPage(), binding: SyncBinding());
      }
    } else {
      controller.custCodeValidate.value = false;
      controller.deviceIdValidate.value = false;
    }
  }
}
