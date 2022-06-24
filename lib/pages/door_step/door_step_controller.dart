import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoorStepController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }
}
