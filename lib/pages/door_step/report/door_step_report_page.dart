import 'package:atm_flutter_app/pages/door_step/report/door_step_report_controller.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/card_widget/money_transfer_report_card_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoorStepReportPage extends GetView<DoorStepReportController> {
  DoorStepReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              actions: const [
                Text('data'),
              ],
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                // print('constraints=' + constraints.toString());
                // top = constraints.biggest.height;
                return FlexibleSpaceBar(
                    centerTitle: true,
                    title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        //opacity: top == MediaQuery.of(context).padding.top + kToolbarHeight ? 1.0 : 0.0,
                        opacity: 1.0,
                        child: Text(
                          'top'.toString(),
                          style: const TextStyle(fontSize: 12.0),
                        )),
                    background: Container(
                      color: AppColors.colorsPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          TextWidget(
                              text: 'from date', textColor: AppColors.white),
                          TextWidget(text: 'to', textColor: AppColors.white),
                          TextWidget(
                              text: 'to date', textColor: AppColors.white),
                          IconButtonWidget(
                              icon: Icons.keyboard_arrow_down_outlined,
                              iconColor: AppColors.white,
                              iconSize: 24)
                        ],
                      ),
                    ));
              })),
        ];
      },
      body: Obx(
        () => ListView.builder(
          itemCount: controller.reportList.length,
          controller: controller.scrollController,
          itemBuilder: (context, index) {
            return ReportCardWidget(
              title: '',
              text: '',
              mode: '',
              status: 'failed',
              transactionNo: 'money transfer',
              transactionDate: '123456',
              amount: '10',
              onTap: () {
                // Get.to(() => Door());
              },
            );
            // return Container(
            //   child: Text("List Item: " + index.toString()),
            //   decoration: BoxDecoration(
            //     color: AppColors.grey,
            //     borderRadius: BorderRadius.circular(10.0),
            //   ),
            //   padding: const EdgeInsets.all(5.0),
            //   margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            // );
          },
        ),
      ),
    ));
  }
}
