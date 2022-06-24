import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/row_text_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: TextWidget(
            text: 'view_profile'.tr.toUpperCase(),
            textColor: Theme.of(context).textTheme.bodyText1!.color!),
        leading: IconButtonWidget(
          onTap: Get.back,
          icon: Icons.arrow_back_ios,
          iconSize: 25,
          iconColor: Theme.of(context).textTheme.bodyText1!.color!,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: CircleAvatar(
                radius: 65,
                backgroundImage: AssetImage(
                  AppDrawable.filePath + AppDrawable.defaultProfileImg,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextWidget(
                                text: PrefManager().getCustomerName.toString(),
                                textColor: AppColors.black,
                                textSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RowTextWidget(
                          textfield: 'address'.tr,
                          text: PrefManager().getShopAddress.toString() +
                              PrefManager().getShopAddressLine.toString(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RowTextWidget(
                          textfield: 'email'.tr,
                          text: PrefManager().getCustomerEmail.toString(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RowTextWidget(
                          textfield: 'contact'.tr,
                          text: PrefManager().getCustomerMobile.toString(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RowTextWidget(
                          textfield: 'locking_amount'.tr,
                          text: PrefManager().getLockingAmount.toString(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RowTextWidget(
                          textfield: 'gstn'.tr,
                          text: PrefManager().getShopGstNo.toString(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RowTextWidget(
                          textfield: 'device_serial_no'.tr,
                          text: PrefManager().getDeviceId.toString(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
