import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_sub_category/bbps_sub_catgory_controller.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/widgets/textfield_widget/search_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/button_widget/icon_button_widget.dart';
import '../../../../widgets/text_widget/text_widget.dart';

class BBPSSubCategoryPage extends GetView<BBPSSubCategoryController> {
  const BBPSSubCategoryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                  flex: 0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: IconButtonWidget(
                                  icon: Icons.arrow_back_ios,
                                  iconSize: 25,
                                  iconColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  onTap: Get.back,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              AppDrawable.filePath + AppDrawable.bbpsBillLogo,
                              height: 40,
                              width: 40,
                              fit: BoxFit.contain,
                            ),
                          ))
                    ],
                  )),
              Expanded(
                  flex: 0,
                  child: Container(
                    alignment: Alignment.center,
                    // color: Theme.of(context).primaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextWidget(
                              text: controller.categoryTitle.value,
                              textColor:
                                  Theme.of(context).textTheme.bodyText1!.color!,
                              textSize: 18,
                              textStyle: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SearchTextFieldWidget(
                                  rounded: 5.0,
                                  hint: 'search_here'.tr,
                                  controller: controller.searchController),
                            )),
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        topLeft: Radius.circular(25.0),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : RefreshIndicator(
                            backgroundColor:
                                Theme.of(context).textTheme.bodyText1!.color,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: controller.bbpsCategoryList.isEmpty
                                  ? Center(
                                      child: TextWidget(
                                          text: 'no_data_found'.tr,
                                          textSize: 20,
                                          textColor: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .color!),
                                    )
                                  : ListView.builder(
                                      itemCount:
                                          controller.bbpsCategoryList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          child: ListTile(
                                            tileColor: const Color(0XFFF7F7F7),
                                            leading: CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              backgroundImage: NetworkImage(
                                                controller
                                                    .bbpsCategoryList[index]
                                                    .billerLogo
                                                    .toString(),
                                              ),
                                            ),
                                            title: TextWidget(
                                                text: controller
                                                    .bbpsCategoryList[index]
                                                    .billerName
                                                    .toString(),
                                                textColor: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .color!),
                                            onTap: () =>
                                                controller.onBillerTap(index),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                            onRefresh: () {
                              return Future.delayed(const Duration(seconds: 1),
                                  () {
                                controller.getBillerFromApi();
                              });
                            }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
