import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/pages/home/home_controller.dart';
import 'package:atm_flutter_app/pages/money_transfer/add_transaction/money_transfer_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/add_transaction/money_transfer_page.dart';
import 'package:atm_flutter_app/pages/qr_code/qr_code_generate/qr_code_binding.dart';
import 'package:atm_flutter_app/pages/qr_code/qr_code_generate/qr_code_generate_page.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/button_widget/home_toggle_button_widget.dart';
import 'package:atm_flutter_app/widgets/card_widget/bbps_category_card.dart';
import 'package:atm_flutter_app/widgets/card_widget/password_dialog_card_widget.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:atm_flutter_app/widgets/drawer/home_navigation_drawer.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        drawer: const SizedBox(
          child: HomeNavigationDrawer(),
          width: 250,
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Image.asset(
            AppDrawable.filePath + AppDrawable.atmLogoCropped,
            color: Theme.of(context).textTheme.bodyText1!.color!,
            height: 40,
            width: 100,
          ),
          leading: GestureDetector(
            child: Image.asset(
              AppDrawable.filePath + AppDrawable.menuIcon,
              height: 15,
              width: 15,
            ),
            onTap: () => _drawerKey.currentState!.openDrawer(),
          ),
          actions: [
            Visibility(
              visible: false,
              child: Obx(
                () => HomeToggleButtonWidget(
                    value: controller.toggleValue.value,
                    onItemTap: controller.onItemTap),
              ),
            )
          ],
        ),
        body: Obx(
          () => LoadingOverlay(
            isLoading: controller.isLoading.value,
            progressIndicator: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
              strokeWidth: 3,
            ),
            opacity: 0.5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        elevation: 10,
                        shape: const CircleBorder(),
                        child: Container(
                          height: 199,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: SvgPicture.asset(
                                    AppDrawable.filePath +
                                        AppDrawable.ellipseSmall,
                                    height: 50,
                                    width: 50,
                                    color: AppColors.whiteFade,
                                    fit: BoxFit.cover,
                                  )),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: SvgPicture.asset(
                                    AppDrawable.filePath +
                                        AppDrawable.ellipseBig,
                                    height: 100,
                                    width: 100,
                                    color: AppColors.whiteFade,
                                    fit: BoxFit.cover,
                                  )),
                              Positioned(
                                  top: 40,
                                  left: 30,
                                  right: 30,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                          text: 'hi'.tr +
                                              ', ' +
                                              PrefManager()
                                                  .getCustomerName
                                                  .toString(),
                                          textColor: AppColors.white),
                                      TextWidget(
                                        text: 'rupee'.tr +
                                            PrefManager()
                                                .getWalletMoney
                                                .toString(),
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!,
                                        textSize: 28,
                                        textStyle: FontWeight.bold,
                                      ),
                                      TextWidget(
                                          text: 'your_wallet_money'.tr,
                                          textColor: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color!),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // TextWidget(text: 'recharge'.tr, textColor: AppColors.black),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child:
                  Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: PrefManager().getMoneyTransfer!,
                          child: GestureDetector(
                            onTap: () {
                              if (PrefManager()
                                          .getMoneyTransferPassword
                                          .toString() ==
                                      'null' ||
                                  PrefManager()
                                          .getMoneyTransferPassword
                                          .toString() ==
                                      '') {
                                Get.to(() => const MoneyTransferPage(),
                                    binding: MoneyTransferBinding());
                              } else {
                                passwordDialog(
                                    AppStrings.txtMoneyTransfer, '', '');
                              }
                            },
                            child: BBPSCategoryCardWidget(
                                image: AppDrawable.moneyTransfer,
                                title: 'send_money'.tr),
                          ),
                        ),
                        Visibility(
                          visible: PrefManager().getQR!,
                          child: GestureDetector(
                            onTap: () {
                              if (PrefManager().getQRPassword.toString() ==
                                      'null' ||
                                  PrefManager().getQRPassword.toString() ==
                                      '') {
                                Get.to(() => QRCodeGeneratePage(),
                                    binding: QRCodeBinding());
                              } else {
                                passwordDialog(AppStrings.txtQR, '', '');
                              }
                            },
                            child: SizedBox(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: SizedBox(
                                  // height: 70,
                                  width: 80,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          AppDrawable.filePath +
                                              AppDrawable.qrCode,
                                          fit: BoxFit.contain,
                                          color: Theme.of(context).primaryColor,
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                      TextWidget(
                                        text: 'qr'.tr,
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .color!,
                                        textSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: PrefManager().getBBPS!,
                    child: Column(
                      children: [
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                  text: 'Recharge',
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .color!,
                                  textSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 6,
                                child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 0.5,
                                            crossAxisSpacing: 0.5),
                                    itemCount: controller.rechargeList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        child: BBPSCategoryCardWidget(
                                            image: controller
                                                .rechargeList[index].catImage,
                                            title: controller
                                                .rechargeList[index].catName),
                                        onTap: () {
                                          if (PrefManager()
                                                      .getBBBPSPassword
                                                      .toString() ==
                                                  'null' ||
                                              PrefManager()
                                                      .getBBBPSPassword
                                                      .toString() ==
                                                  '') {
                                            controller.gotoNextPage(
                                                controller.rechargeList[index]
                                                    .catName,
                                                controller.rechargeList[index]
                                                    .catImage);
                                          } else {
                                            passwordDialog(
                                                AppStrings.txtBBPS,
                                                controller.rechargeList[index]
                                                    .catName,
                                                controller.rechargeList[index]
                                                    .catImage);
                                          }
                                        },
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                  text: 'Bills',
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .color!,
                                  textSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 3,
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 0.5,
                                            crossAxisSpacing: 0.5),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.billList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        child: BBPSCategoryCardWidget(
                                            image: controller
                                                .billList[index].catImage,
                                            title: controller
                                                .billList[index].catName),
                                        onTap: () {
                                          if (PrefManager()
                                                      .getBBBPSPassword
                                                      .toString() ==
                                                  'null' ||
                                              PrefManager()
                                                      .getBBBPSPassword
                                                      .toString() ==
                                                  '') {
                                            controller.gotoNextPage(
                                                controller
                                                    .billList[index].catName,
                                                controller
                                                    .billList[index].catImage);
                                          } else {
                                            passwordDialog(
                                                AppStrings.txtBBPS,
                                                controller
                                                    .billList[index].catName,
                                                controller
                                                    .billList[index].catImage);
                                          }
                                        },
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                  text: 'Finance',
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .color!,
                                  textSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 3,
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    // scrollDirection: Axis.horizontal,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 0.5,
                                      mainAxisSpacing: 0.5,
                                      crossAxisCount: 4,
                                    ),
                                    itemCount: controller.financialList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        child: BBPSCategoryCardWidget(
                                            image: controller
                                                .financialList[index].catImage,
                                            title: controller
                                                .financialList[index].catName),
                                        onTap: () {
                                          if (PrefManager()
                                                      .getBBBPSPassword
                                                      .toString() ==
                                                  'null' ||
                                              PrefManager()
                                                      .getBBBPSPassword
                                                      .toString() ==
                                                  '') {
                                            controller.gotoNextPage(
                                                controller.financialList[index]
                                                    .catName,
                                                controller.financialList[index]
                                                    .catImage);
                                          } else {
                                            passwordDialog(
                                                AppStrings.txtBBPS,
                                                controller.financialList[index]
                                                    .catName,
                                                controller.financialList[index]
                                                    .catImage);
                                          }
                                        },
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                  text: 'Others',
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .color!,
                                  textSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 3,
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 0.5,
                                      crossAxisSpacing: 0.5,
                                    ),
                                    // scrollDirection: Axis.horizontal,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.otherList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        child: BBPSCategoryCardWidget(
                                            image: controller
                                                .otherList[index].catImage,
                                            title: controller
                                                .otherList[index].catName),
                                        onTap: () {
                                          if (PrefManager()
                                                      .getBBBPSPassword
                                                      .toString() ==
                                                  'null' ||
                                              PrefManager()
                                                      .getBBBPSPassword
                                                      .toString() ==
                                                  '') {
                                            controller.gotoNextPage(
                                                controller
                                                    .otherList[index].catName,
                                                controller
                                                    .otherList[index].catImage);
                                          } else {
                                            passwordDialog(
                                                AppStrings.txtBBPS,
                                                controller
                                                    .otherList[index].catName,
                                                controller
                                                    .otherList[index].catImage);
                                          }
                                        },
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    margin: const EdgeInsets.only(bottom: 0.0),
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: TextWidget(
                              text: 'report'.tr,
                              textColor:
                                  Theme.of(context).textTheme.subtitle1!.color!,
                              textSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: SizedBox(
                              // height: 90,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 0.5,
                                    crossAxisSpacing: 0.5,
                                  ),
                                  // scrollDirection: Axis.horizontal,
                                  itemCount: controller.reportList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      child: BBPSCategoryCardWidget(
                                          // padding: 5.0,
                                          image: controller
                                              .reportList[index].catImage,
                                          title: controller
                                              .reportList[index].catName),
                                      onTap: () => controller.goToReportPage(
                                          controller.reportList[index].catName,
                                          controller
                                              .reportList[index].catImage),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void passwordDialog(
      String service, String categoryName, String categoryImage) {
    Get.defaultDialog(
      title: 'enter_the_password_to_login'.tr,
      titleStyle:
          TextStyle(color: Theme.of(Get.context!).textTheme.bodyText2!.color!),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => TextWidget(
                text: controller.password.value, textColor: AppColors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasswordDialogCardWidget(
                onTap: controller.onButtonTap,
                text: '1',
              ),
              PasswordDialogCardWidget(
                onTap: controller.onButtonTap,
                text: '2',
              ),
              PasswordDialogCardWidget(
                onTap: controller.onButtonTap,
                text: '3',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasswordDialogCardWidget(
                onTap: controller.onButtonTap,
                text: '4',
              ),
              PasswordDialogCardWidget(
                onTap: controller.onButtonTap,
                text: '5',
              ),
              PasswordDialogCardWidget(
                onTap: controller.onButtonTap,
                text: '6',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasswordDialogCardWidget(
                onTap: controller.onButtonTap,
                text: '7',
              ),
              PasswordDialogCardWidget(
                onTap: controller.onButtonTap,
                text: '8',
              ),
              PasswordDialogCardWidget(
                onTap: controller.onButtonTap,
                text: '9',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: controller.onTextDelete,
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Card(
                    elevation: 3,
                    child: Center(
                      child: Icon(
                        Icons.backspace,
                        size: 20,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              PasswordDialogCardWidget(
                onTap: controller.onButtonTap,
                text: '0',
              ),
            ],
          ),
        ],
      ),
      cancel: ButtonWidget(
        label: 'cancel'.tr,
        width: 100,
        clicked: false,
        btnColor: Theme.of(Get.context!).primaryColor,
        onTap: onCancelTap,
      ),
      confirm: ButtonWidget(
        label: 'login'.tr,
        width: 100,
        clicked: false,
        btnColor: Theme.of(Get.context!).primaryColor,
        onTap: () => onItemTap(service, categoryName, categoryImage),
      ),
    );
  }

  void onCancelTap() {
    Get.back();
    controller.password.value = '';
  }

  void onItemTap(String service, String categoryName, String categoryImage) {
    if (service == AppStrings.txtMoneyTransfer) {
      if (PrefManager().getMoneyTransferPassword == controller.password.value) {
        Get.back();
        Get.to(() => const MoneyTransferPage(),
            binding: MoneyTransferBinding());
      } else {
        commonSnackBar('Entered wrong password!');
      }
    }
    if (service == AppStrings.txtBBPS) {
      if (PrefManager().getBBBPSPassword == controller.password.value) {
        Get.back();
        controller.gotoNextPage(categoryName, categoryImage);
      } else {
        commonSnackBar('Entered wrong password!');
      }
    }
    if (service == AppStrings.txtQR) {
      if (PrefManager().getQRPassword == controller.password.value) {
        Get.back();
        Get.to(() => QRCodeGeneratePage(), binding: QRCodeBinding());
      } else {
        commonSnackBar('Entered wrong password!');
      }
    }
  }
}
