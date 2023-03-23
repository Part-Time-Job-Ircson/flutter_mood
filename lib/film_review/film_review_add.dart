import 'package:flutter/material.dart';
import 'package:flutter_mood/extension/index.dart';
import 'package:flutter_mood/film_review/film_review_type.dart';
import 'package:flutter_mood/film_review/film_review_view.dart';
import 'package:flutter_mood/routers/route.dart';
import 'package:flutter_mood/utils/storage.dart';
import 'package:flutter_mood/utils/ui/base_scaffold.dart';
import 'package:flutter_mood/utils/ui/button.dart';
import 'package:flutter_mood/utils/ui/decoration.dart';
import 'package:flutter_mood/utils/ui/loading.dart';
import 'package:flutter_mood/utils/ui/text.dart';
import 'package:flutter_mood/utils/values/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilmReviewAddPage extends StatefulWidget {
  const FilmReviewAddPage({Key? key}) : super(key: key);

  @override
  State<FilmReviewAddPage> createState() => _FilmReviewAddPageState();
}

class _FilmReviewAddPageState extends State<FilmReviewAddPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FilmReviewAddLogic logic = Get.put(FilmReviewAddLogic());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      scaffoldBackgroundColor: AppColors.grayEe,
      titleStr: '写影评',
      actions: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 16),
          child: ButtonWidget.text(
            '保存',
            fontSize: 16,
            textColor: AppColors.textLevelOne,
            onTap: () async {
              if (logic.type.empty) {
                Loading.toast('请选择影片类型');
                return;
              }

              if (_textEditingController.text.empty) {
                Loading.toast('请输入影评文字信息');
                return;
              }

              List<String> lists = Storage().getList(filmReviewKey);
              lists.add(_textEditingController.text);
              await Storage().setList(filmReviewKey, lists);
              Loading.toast('添加成功');
              CommonRoute.close();
            },
            hasInkWell: false,
          ),
        ),
      ],
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 20.w, 16.w, 0),
            child: ButtonWidget(
              child: Container(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                height: 50.w,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const TextWidget.oneLine(
                      text: '影评类型：',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLevelOne,
                    ),
                    GetBuilder<FilmReviewAddLogic>(
                      builder: (logic) {
                        return TextWidget.oneLine(
                          text: logic.type.notEmpty ? logic.type : '选择影片类型',
                          fontSize: 16,
                          color: logic.type.notEmpty ? AppColors.textLevelOne : AppColors.textLevelThree,
                        );
                      },
                    ),
                  ],
                ),
                decoration: CommonDecoration.getShapeDecoration(radius: 10.w, bg: Colors.white),
              ),
              onTap: () => CommonRoute.open(const FilmReviewTypePage(), back: () {}),
              hasInkWell: false,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16.w, 20.w, 16.w, 0),
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextWidget.oneLine(
                  text: '添加影评文字',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textLevelOne,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入影评文字信息',
                    hintStyle: TextStyle(fontSize: 15, color: AppColors.textLevelThree),
                  ),
                  style: const TextStyle(fontSize: 15, color: AppColors.textLevelOne),
                  maxLines: 5,
                  controller: _textEditingController,
                  focusNode: _focusNode,
                ),
              ],
            ),
            decoration: CommonDecoration.getShapeDecoration(radius: 10.w, bg: Colors.white),
          ),
        ],
      ),
    );
  }
}

class FilmReviewAddLogic extends GetxController {
  String type = '';

  void updateType(String type) {
    this.type = type;
    update();
  }
}
