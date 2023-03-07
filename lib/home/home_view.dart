import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mood/calendar/calendar_view.dart';
import 'package:flutter_mood/home/home_logic.dart';
import 'package:flutter_mood/routers/route.dart';
import 'package:flutter_mood/setting/setting_view.dart';
import 'package:flutter_mood/utils/storage.dart';
import 'package:flutter_mood/utils/ui/base_scaffold.dart';
import 'package:flutter_mood/utils/ui/button.dart';
import 'package:flutter_mood/utils/ui/decoration.dart';
import 'package:flutter_mood/utils/ui/loading.dart';
import 'package:flutter_mood/utils/ui/slider_indicator.dart';
import 'package:flutter_mood/utils/ui/text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeLogic logic;

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    logic = Get.put(HomeLogic());
    super.initState();
    // Storage().remove('mood');
  }

  String toTwo(int int) {
    if (int < 10) return '0$int';
    return int.toString();
  }

  static String _getWeek(int week, {String prefix = '周'}) {
    String result = '';
    switch (week) {
      case 1:
        result = '$prefix一';
        break;
      case 2:
        result = '$prefix二';
        break;
      case 3:
        result = '$prefix三';
        break;
      case 4:
        result = '$prefix四';
        break;
      case 5:
        result = '$prefix五';
        break;
      case 6:
        result = '$prefix六';
        break;
      case 7:
        result = '$prefix日';
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          PageView(
            children: logic.colorList
                .map((e) => Container(
                      color: e,
                      alignment: const Alignment(0.0, -0.2),
                      child: Image.asset(
                        'assets/png/${logic.imgList[logic.colorList.indexOf(e)]}.png',
                        width: 250.w,
                      ),
                    ))
                .toList(),
            onPageChanged: logic.onPageChanged,
          ),
          Positioned(
            right: 30.w,
            top: ScreenUtil().statusBarHeight,
            child: Column(
              children: [
                _buildButton('日历', () => CommonRoute.open(const CalendarPage())),
                SizedBox(height: 20.w),
                _buildButton('设置', () => CommonRoute.open(SettingPage())),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: kToolbarHeight + 20.w, left: 20.w),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget.oneLine(
                            text: toTwo(DateTime.now().month) + '/' + toTwo(DateTime.now().day),
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 15.w),
                          TextWidget.oneLine(
                              text: '${DateTime.now().year}',
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                      Container(
                        width: 1.w,
                        height: 85.w,
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                      ),
                      TextWidget.moreLine(
                          text: '周\n${_getWeek(DateTime.now().weekday, prefix: '')}',
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 250.w + 25.w),
            child: Center(
              child: GetBuilder<HomeLogic>(
                id: 'indicator',
                builder: (logic) {
                  return SliderIndicatorWidget(
                    length: logic.imgList.length,
                    currentIndex: logic.currentIndex,
                    isCircle: true,
                    width: 8.w,
                    height: 8.w,
                    spacing: 8.w,
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 15.w,
            right: 15.w,
            bottom: 145.w,
            child: Container(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '心情如何？随手记下来吧~',
                  hintStyle: TextStyle(fontSize: 15, color: Colors.white),
                ),
                style: const TextStyle(fontSize: 15, color: Colors.white),
                maxLines: 5,
                controller: _textEditingController,
                focusNode: _focusNode,
              ),
              decoration: CommonDecoration.getShapeDecoration(radius: 10.w, bg: Colors.white.withOpacity(0.3)),
            ),
          ),
          Positioned(
            left: 15.w,
            right: 15.w,
            bottom: 55.w,
            child: ButtonWidget.text(
              '记录今日心情',
              height: 60.w,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.white,
              alignment: Alignment.center,
              borderRadius: 12.w,
              onTap: () async {
                if (_textEditingController.text.isEmpty) return;
                List<String> saved = Storage().getList('mood', defaultValue: []);
                int index = saved.indexWhere(
                    (element) => HomeLogic.isSameDay(jsonDecode(element)['date'], DateTime.now().toString()));
                if (index < 0) {
                  saved.add(jsonEncode({
                    'index': logic.currentIndex.toString(),
                    'date': DateTime.now().toString(),
                  }));
                  await Storage().setList('mood', saved);
                  _textEditingController.text = '';
                  _focusNode.unfocus();
                  Loading.toast('记录成功');
                } else {
                  Loading.toast('今日已记录');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String title, VoidCallback onTap) {
    return ButtonWidget(
      child: Column(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            alignment: Alignment.center,
            decoration: CommonDecoration.getShapeDecoration(
              bg: Colors.white.withOpacity(0.3),
              radius: 12.w,
            ),
            child: SvgPicture.asset('assets/svg/$title.svg', width: 23.w),
          ),
          SizedBox(height: 8.w),
          TextWidget.oneLine(text: title, fontSize: 13, color: Colors.white),
        ],
      ),
      onTap: onTap,
      hasInkWell: false,
    );
  }
}
