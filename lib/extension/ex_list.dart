import 'package:flutter_mood/extension/index.dart';

extension ExList on List<String> {
  /// 通过数组快速拼接字符串
  String appendByCharacter(String separator) {
    if (isEmpty) return '';
    String result = reduce((value, element) {
      if (element.notEmpty) {
        return value + separator + element;
      }
      return value;
    });
    if (result.notEmpty && result.startsWith(separator)) {
      result = result.substring(separator.length, result.length);
    }
    return result;
  }
}
