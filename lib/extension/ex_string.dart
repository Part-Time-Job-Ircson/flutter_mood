import 'package:flutter/material.dart';

/// 扩展 String
extension ExString on String {
  /// 生成 Color
  Color get toColor {
    return Color(int.parse(this, radix: 16) | 0xFF000000);
  }
}

extension ExNullString on String? {
  /// 返回默认字符串
  String getAuto(String hint) {
    return empty ? hint : this!;
  }

  /// 字符串是否为空
  bool get empty {
    return !notEmpty;
  }

  /// 字符串是否非空
  bool get notEmpty {
    return this != null && this!.isNotEmpty;
  }

  /// 字符串比较
  bool equals(String? temp) {
    if (empty) return false;
    if (temp.empty) return false;
    return this == temp;
  }
}
