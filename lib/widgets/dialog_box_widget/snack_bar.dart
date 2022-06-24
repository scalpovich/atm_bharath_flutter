import 'package:flutter/material.dart';
import 'package:get/get.dart';

void commonSnackBar(String message) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color: Theme.of(Get.context!).textTheme.bodyText1!.color!,
      ),
    ),
    backgroundColor: Theme.of(Get.context!).primaryColor,
    elevation: 10,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
  ));
}
