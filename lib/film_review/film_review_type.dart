import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mood/film_review/film_review_add.dart';
import 'package:flutter_mood/routers/route.dart';
import 'package:flutter_mood/utils/ui/base_scaffold.dart';
import 'package:flutter_mood/utils/ui/button.dart';
import 'package:flutter_mood/utils/ui/decoration.dart';
import 'package:flutter_mood/utils/ui/text.dart';
import 'package:flutter_mood/utils/values/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FilmReviewTypePage extends StatefulWidget {
  const FilmReviewTypePage({Key? key}) : super(key: key);

  @override
  State<FilmReviewTypePage> createState() => _FilmReviewTypePageState();
}

class _FilmReviewTypePageState extends State<FilmReviewTypePage> {
  List<String> titles = ['电影', '电视剧', '动漫', '综艺', '最新韩剧', '经典韩剧', '少儿', '纪录片', '专题', '电视直播'];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleStr: '类型',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
        child: LayoutBuilder(
          builder: (_, BoxConstraints constraints) {
            double width = (constraints.maxWidth - 10.w) / 2;
            return Wrap(
              spacing: 10.w,
              runSpacing: 10.w,
              children: titles
                  .map((e) => ButtonWidget(
                        child: Container(
                          width: width.floorToDouble(),
                          height: 60.w,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: CommonDecoration.getShapeDecoration(bg: AppColors.black, radius: 8.w),
                          child: Row(
                            children: [
                              Expanded(child: TextWidget.oneLine(text: e, color: AppColors.white, fontSize: 15)),
                              SvgPicture.asset('assets/svg/$e.svg', width: 30.w),
                            ],
                          ),
                        ),
                        onTap: () {
                          Get.find<FilmReviewAddLogic>().updateType(e);
                          CommonRoute.close();
                        },
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
