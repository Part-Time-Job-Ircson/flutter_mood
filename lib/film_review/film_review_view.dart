import 'package:flutter/material.dart';
import 'package:flutter_mood/film_review/film_review_add.dart';
import 'package:flutter_mood/routers/route.dart';
import 'package:flutter_mood/utils/storage.dart';
import 'package:flutter_mood/utils/ui/base_scaffold.dart';
import 'package:flutter_mood/utils/ui/button.dart';
import 'package:flutter_mood/utils/ui/text.dart';
import 'package:flutter_mood/utils/values/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String filmReviewKey = 'filmReview';

class FilmReviewPage extends StatefulWidget {
  const FilmReviewPage({Key? key}) : super(key: key);

  @override
  State<FilmReviewPage> createState() => _FilmReviewPageState();
}

class _FilmReviewPageState extends State<FilmReviewPage> {
  late List<String> lists = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    setState(() {
      lists = Storage().getList(filmReviewKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleStr: '影评',
      actions: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 16),
          child: ButtonWidget.text(
            '写影评',
            fontSize: 16,
            textColor: AppColors.textLevelOne,
            onTap: () => CommonRoute.open(const FilmReviewAddPage(), back: getData),
            hasInkWell: false,
          ),
        ),
      ],
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.w),
            child: TextWidget.moreLine(
              text: lists[index],
              fontSize: 16,
              color: AppColors.textLevelOne,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Container(height: 1, color: AppColors.grayEe),
        itemCount: lists.length,
      ),
    );
  }
}
