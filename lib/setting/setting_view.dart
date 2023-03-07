import 'package:flutter/material.dart';
import 'package:flutter_mood/utils/package.dart';
import 'package:flutter_mood/utils/ui/base_scaffold.dart';
import 'package:flutter_mood/utils/ui/button.dart';
import 'package:flutter_mood/utils/ui/decoration.dart';
import 'package:flutter_mood/utils/ui/text.dart';
import 'package:flutter_mood/utils/values/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final SettingLogic logic = Get.put(SettingLogic());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleStr: '设置',
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 20.w, 16.w, 0),
        itemCount: logic.titles.length,
        itemBuilder: (BuildContext context, int index) {
          Widget? right;
          if (index == 0) {
            right = Obx(() {
              return TextWidget.oneLine(text: logic.version.value, fontSize: 13, color: AppColors.textLevelThree);
            });
          }
          if (index == 1) {
            right = const TextWidget.oneLine(text: '0.0M', fontSize: 13, color: AppColors.textLevelThree);
          }
          return _buildItem(logic.icons[index], logic.titles[index], right: right);
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 15.w),
      ),
    );
  }

  Widget _buildItem(String icon, String title, {Widget? right, VoidCallback? onTap}) {
    return ButtonWidget(
      child: Container(
        height: 50.w,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        decoration:
            CommonDecoration.getShadow(bg: Colors.white, radius: 12.w, shadowColor: Colors.black.withOpacity(0.1)),
        child: Row(
          children: [
            SvgPicture.asset(icon, width: 20.w),
            SizedBox(width: 10.w),
            Expanded(child: TextWidget.oneLine(text: title, fontSize: 15, color: AppColors.textLevelOne)),
            right ?? SvgPicture.asset('assets/svg/圈圈向右箭头.svg', width: 20.w),
          ],
        ),
      ),
      onTap: onTap,
      hasInkWell: false,
    );
  }
}

class SettingLogic extends GetxController {
  List<String> titles = ['当前版本', '清除缓存', '关于我们', '用户协议'];
  List<String> icons = ['assets/svg/版本.svg', 'assets/svg/删除.svg', 'assets/svg/关于我们.svg', 'assets/svg/用户协议.svg'];

  var version = ''.obs;

  @override
  void onReady() async {
    super.onReady();
    PackageInfoUtils utils = PackageInfoUtils();
    version.value = await utils.getVersion();
  }
}
