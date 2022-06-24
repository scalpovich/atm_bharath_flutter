import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/model/server.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../widgets/button_widget/button_widget.dart';
import '../../widgets/text_widget/text_widget.dart';

class ServerController extends MainController {
  RxList<Server> serverList = <Server>[].obs;
  final TextEditingController serverUrlController = TextEditingController();
  RxInt currentServerIndex = 0.obs;
  RxInt defaultIndex = 0.obs;

  ///get server list from db
  void getServerListFromDB() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    dynamic list = box.get(DatabaseConstants.dbServerList);
    if (list != null) {
      List<Server> listServer =
          box.get(DatabaseConstants.dbServerList).toList().cast<Server>();
      serverList.addAll(listServer);
      defaultIndex.value =
          listServer.indexWhere((element) => element.serverStatus!);
    } else {}
  }

  ///server selected
  void onItemSelected(int index) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    final i = serverList.indexWhere((element) => element.serverStatus!);
    dynamic server = Server(serverList[i].id, serverList[i].serverUrl, false,
        serverList[i].serverState);
    serverList.insert(i, server);
    serverList.removeAt(i + 1);
    dynamic server1 = Server(serverList[index].id, serverList[index].serverUrl,
        true, serverList[index].serverState);
    serverList.insert(index, server1);
    serverList.removeAt(index + 1);
    box.put(DatabaseConstants.dbServerList, serverList.toList());
    PrefManager().setBaseUrl(serverList[index].serverUrl.toString());
    commonSnackBar('server_updated'.tr);
    Get.back();
  }

  void doNothing(bool value) async {}

  ///server delete
  void onItemDelete(int index) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    if (serverList[index].serverState == 'E') {
      if (serverList[index].serverStatus!) {
        final i = serverList
            .indexWhere((element) => element.serverState.toString() == 'D');
        dynamic server = Server(
            1, 'https://api.atmbharath.in/MoneyTrfNew/MoneyTrf/', true, 'D');
        serverList.insert(i, server);
        serverList.removeAt(i + 1);
        serverList.removeAt(index);
        box.put(DatabaseConstants.dbServerList, serverList.toList());
        PrefManager()
            .setBaseUrl('https://api.techlogica.com/moneytrftest/moneytrf/');
      } else {
        serverList.removeAt(index);
        box.put(DatabaseConstants.dbServerList, serverList.toList());
      }
    } else {
      ///snackBar
    }
    Log().logs('base---', PrefManager().getBaseUrl.toString());
  }

  ///adding server to db
  void addServerToDB() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    dynamic server =
        Server(serverList.length, serverUrlController.text, true, 'E');
    dynamic index = serverList.indexWhere((element) =>
        element.serverUrl.toString() == PrefManager().getBaseUrl.toString());
    dynamic server2 = Server(serverList[index].id, serverList[index].serverUrl,
        false, serverList[index].serverState);
    serverList.insert(index, server2);
    serverList.removeAt(index + 1);
    serverList.insert(serverList.length, server);
    box.put(DatabaseConstants.dbServerList, serverList.toList());
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    getServerListFromDB();
  }

  @override
  void onReady() {
    super.onReady();
    // alertPop();
  }

  // void alertPop() {
  //   Get.defaultDialog(
  //     title: 'Hint!',
  //     titleStyle: TextStyle(color: Theme.of(Get.context!).primaryColor),
  //     content: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             TextWidget(
  //                 text: 'slide_right_select_server'.tr,
  //                 textColor: Theme.of(Get.context!).primaryColor),
  //             Icon(
  //               Icons.arrow_forward,
  //               size: 30,
  //               color: Theme.of(Get.context!).primaryColor,
  //             )
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(
  //               Icons.arrow_back,
  //               size: 30,
  //               color: Theme.of(Get.context!).primaryColor,
  //             ),
  //             TextWidget(
  //                 text: 'slide_left_delete_server'.tr,
  //                 textColor: Theme.of(Get.context!).primaryColor),
  //           ],
  //         )
  //       ],
  //     ),
  //     barrierDismissible: true,
  //     cancel: ButtonWidget(
  //       label: 'close'.tr,
  //       width: 80,
  //       btnColor: Theme.of(Get.context!).primaryColor,
  //       height: 35,
  //       clicked: false,
  //       onTap: Get.back,
  //     ),
  //   );
  // }

  void onchangeValue(bool? value, int index) async {
    // try {
    int index1 = serverList.indexWhere((element) => element.serverStatus!);
    dynamic server1 = Server(serverList[index1].id,
        serverList[index1].serverUrl, !value!, serverList[index1].serverState);
    serverList.insert(index1, server1);
    serverList.removeAt(index1 + 1);

    dynamic server2 = Server(serverList[index].id, serverList[index].serverUrl,
        value, serverList[index].serverState);
    serverList.insert(index, server2);
    serverList.removeAt(index + 1);
    commonSnackBar('Server updated - ${serverList[index1].serverUrl}');
  }
}
