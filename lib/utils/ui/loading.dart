import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mood/utils/values/colors.dart';

/// 提示框
class Loading {
  static const int _milliseconds = 500; // 提示 延迟毫秒, 提示体验 秒关太快
  static const int _dismissMilliseconds = 100; // dismiss 延迟毫秒

  Loading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: _dismissMilliseconds) // 关闭延迟
      ..indicatorType = EasyLoadingIndicatorType.ring // 指示器类型
      ..loadingStyle = EasyLoadingStyle.custom // loading样式 自定义
      ..indicatorSize = 35.0 // 指示器大小
      ..lineWidth = 2 // 进度条宽度
      ..radius = 10.0 // 圆角
      ..progressColor = AppColors.black // 进度条颜色
      ..backgroundColor = Colors.black.withOpacity(0.7) // 背景颜色
      ..indicatorColor = AppColors.black // 指示器颜色
      ..textColor = Colors.white // 文字颜色
      ..maskColor = Colors.black.withOpacity(0.6) // 遮罩颜色
      ..userInteractions = false // 用户交互
      ..dismissOnTap = false; // 点击关闭
  }

  // 显示
  static void show([String? text]) {
    EasyLoading.instance.userInteractions = false; // 屏蔽交互操作
    if (!EasyLoading.isShow) {
      EasyLoading.show(status: text);
    }
  }

  // 错误
  static void error([String? text]) {
    Future.delayed(
      const Duration(milliseconds: _milliseconds),
      () => EasyLoading.showError(text ?? 'Error'),
    );
  }

  // 成功
  static void success([String? text]) {
    Future.delayed(
      const Duration(milliseconds: _milliseconds),
      () => EasyLoading.showSuccess(text ?? 'Success'),
    );
  }

  // toast
  static void toast(String text) {
    EasyLoading.showToast(text, duration: const Duration(milliseconds: 1000));
  }

  // 关闭
  static Future<void> dismiss() async {
    await Future.delayed(
      const Duration(milliseconds: _dismissMilliseconds),
      () {
        EasyLoading.instance.userInteractions = true; // 恢复交互操作
        EasyLoading.dismiss();
      },
    );
  }

  ///返回[predicate]结果，如果true，则toast [msg]
  static bool predicate(bool Function() predicate, String msg) {
    bool result = predicate.call();
    if (result) toast(msg);
    return result;
  }
}
