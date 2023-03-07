import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mood/home/home_logic.dart';
import 'package:flutter_mood/utils/storage.dart';
import 'package:flutter_mood/utils/ui/base_scaffold.dart';
import 'package:flutter_mood/utils/ui/decoration.dart';
import 'package:flutter_mood/utils/ui/text.dart';
import 'package:flutter_mood/utils/values/colors.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  late List<String> savedDateList = [];
  late List<int> currentMonthStatistics;

  ValueNotifier<bool> flag = ValueNotifier(false);
  void update() => flag.value = !flag.value;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    currentMonthStatistics = List.generate(7, (index) => 0);

    savedDateList = Storage().getList('mood', defaultValue: []);

    for (String element in savedDateList) {
      Map<String, dynamic> map = jsonDecode(element);
      DateTime day = DateFormat('yyyy-MM-dd').parse(map['date']);
      if (day.year == _focusedDay.year && day.month == _focusedDay.month) {
        int index = int.tryParse(map['index']) ?? 0;
        currentMonthStatistics[index]++;
      } else {
        continue;
      }
    }

    update();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleStr: '日历',
      child: Column(
        children: [
          TableCalendar(
            locale: 'zh_CN',
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) {
              int index = savedDateList
                  .indexWhere((element) => HomeLogic.isSameDay(day.toString(), jsonDecode(element)['date']));
              return index >= 0;
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, day1) => Center(
                child: Container(
                  decoration: CommonDecoration.getShapeDecoration(bg: AppColors.grayEe, radius: 38),
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  child: TextWidget.oneLine(text: day.day.toString()),
                ),
              ),
              selectedBuilder: (context, day, day1) {
                String index = '';
                for (var element in savedDateList) {
                  Map<String, dynamic> map = jsonDecode(element);
                  bool flag = HomeLogic.isSameDay(day.toString(), map['date']);
                  if (flag) index = map['index'];
                }
                return Center(child: Image.asset('assets/png/$index.png', width: 40));
              },
            ),
            calendarStyle: const CalendarStyle(isTodayHighlighted: false, outsideDaysVisible: false),
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              getData();
            },
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: CommonDecoration.getShapeDecoration(bg: AppColors.grayEe, radius: 12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                  child: Row(
                    children: const [
                      TextWidget.oneLine(text: '本月心情', fontSize: 18, color: AppColors.textLevelOne),
                      SizedBox(width: 10),
                      TextWidget.oneLine(text: '每月心情变化在这里统计', fontSize: 13, color: AppColors.textLevelThree),
                    ],
                  ),
                ),
                LayoutBuilder(builder: (_, constraints) {
                  double w = constraints.maxWidth / 7;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ValueListenableBuilder(
                      valueListenable: flag,
                      builder: (BuildContext context, value, Widget? child) {
                        return Wrap(
                          children: List.generate(
                            7,
                            (index) {
                              return SizedBox(
                                width: w.floor().toDouble(),
                                child: Column(
                                  children: [
                                    TextWidget.oneLine(
                                        text: currentMonthStatistics[index].toString(),
                                        fontSize: 14,
                                        color: Colors.orange),
                                    const SizedBox(height: 10),
                                    Image.asset('assets/png/$index.png', width: 40),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
