import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeLogic extends GetxController {
  final List<Color> colorList = const [
    Color(0XFFF4CA59),
    Color(0XFFE58C62),
    Color(0XFFE1649B),
    Color(0XFFE19959),
    Color(0XFF6297E2),
    Color(0XFFB757E1),
    Color(0XFF9BDE6B),
  ];

  final List<String> imgList = List.generate(7, (index) => index.toString());

  int currentIndex = 0;

  void onPageChanged(int index) {
    currentIndex = index;
    update(['indicator']);
  }

  static bool isSameDay(String day1, String day2) {
    DateTime d1 = _format(day1);
    DateTime d2 = _format(day2);
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  static DateTime _format(String time) {
    try {
      return DateFormat('yyyy-MM-dd').parse(time);
    } catch (e) {
      return DateTime.now();
    }
  }
}
