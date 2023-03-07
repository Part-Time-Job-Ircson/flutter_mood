import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonRoute {
  static void open<T>(
    T page, {
    bool preventDuplicates = false,
    VoidCallback? back,
    Transition? transition,
    Duration? duration,
    bool fullscreenDialog = false,
  }) {
    Get.to(
      () => page,
      preventDuplicates: preventDuplicates,
      transition: transition,
      duration: duration,
      fullscreenDialog: fullscreenDialog,
    )?.whenComplete(() => back?.call());
  }

  ///关闭路由
  static close() => Get.back();
}
