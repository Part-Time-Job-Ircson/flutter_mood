import 'package:flutter/material.dart';
import 'package:flutter_mood/utils/ui/decoration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// slider indicator 指示器
class SliderIndicatorWidget extends StatelessWidget {
  /// 个数
  final int length;

  /// 当前位置
  final int currentIndex;

  /// 选中颜色
  final Color? selectedColor;

  /// 未选中颜色
  final Color? unselectedColor;

  /// 是否圆形
  final bool isCircle;

  /// 对齐方式
  final MainAxisAlignment alignment;

  ///宽
  final double? width;

  ///高
  final double? height;

  ///间距
  final double? spacing;

  const SliderIndicatorWidget({
    Key? key,
    required this.length,
    required this.currentIndex,
    this.isCircle = false,
    this.alignment = MainAxisAlignment.center,
    this.height,
    this.width,
    this.spacing,
    this.selectedColor,
    this.unselectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: List.generate(
        length,
        (index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: spacing ?? 3.w),
            width: !isCircle ? (width ?? 30.w) : (width ?? 6.w),
            height: !isCircle ? (height ?? 3.w) : (height ?? 6.w),
            decoration: CommonDecoration.getShapeDecoration(
              bg: currentIndex == index
                  ? (selectedColor ?? Colors.white)
                  : (unselectedColor ?? Colors.white.withOpacity(0.3)),
              radius: isCircle ? (width ?? 6.w) : 3.w,
            ),
          );
        },
      ),
    );
  }
}
