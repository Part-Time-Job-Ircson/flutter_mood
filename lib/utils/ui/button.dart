import 'package:flutter/material.dart';
import 'package:flutter_mood/utils/ui/decoration.dart';
import 'package:flutter_mood/utils/ui/text.dart';
import 'package:flutter_mood/utils/values/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonWidgetType {
  none, // 无
  text, // 文字按钮
  icon, // 图标按钮
  textIcon, // 文字/图标
}

/// 按钮
class ButtonWidget extends StatelessWidget {
  /// 按钮类型
  final ButtonWidgetType type;

  /// tap 事件
  final Function()? onTap;

  /// 长按事件
  final Function()? onLongPress;

  /// 文字字符串
  final String? text;

  /// 子组件
  final Widget? child;

  /// 图标
  final Widget? icon;

  /// 圆角
  final double? borderRadius;

  /// 背景色
  final Color? backgroundColor;

  /// 边框色
  final Color? borderColor;

  /// 边框线宽
  final double? borderWidth;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 内边距
  final EdgeInsets? padding;

  /// 对齐方式
  final Alignment? alignment;

  /// 渐变
  final Gradient? gradient;

  final bool hasInkWell;

  const ButtonWidget({
    Key? key,
    this.type = ButtonWidgetType.none,
    this.onTap,
    this.text,
    this.borderRadius,
    this.child,
    this.backgroundColor,
    this.icon,
    this.borderColor,
    this.width,
    this.height,
    this.onLongPress,
    this.borderWidth,
    this.padding,
    this.alignment,
    this.hasInkWell = true,
    this.gradient,
  }) : super(key: key);

  /// 文字
  ButtonWidget.text(
    this.text, {
    Key? key,
    this.type = ButtonWidgetType.text,
    this.onTap,
    this.onLongPress,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    this.borderRadius,
    this.backgroundColor,
    this.icon,
    this.borderColor,
    this.width,
    this.height,
    this.borderWidth,
    this.padding,
    this.alignment,
    this.hasInkWell = true,
    this.gradient,
  })  : child = TextWidget.oneLine(
          text: text!,
          fontSize: fontSize,
          color: textColor ?? AppColors.textLevelOne,
          fontWeight: fontWeight,
        ),
        super(key: key);

  /// 图标
  const ButtonWidget.icon(
    this.icon, {
    Key? key,
    this.type = ButtonWidgetType.icon,
    this.onTap,
    this.text,
    this.borderRadius,
    this.backgroundColor,
    this.child,
    this.borderColor,
    this.width,
    this.height,
    this.onLongPress,
    this.borderWidth,
    this.padding,
    this.alignment,
    this.hasInkWell = true,
    this.gradient,
  }) : super(key: key);

  /// 文字 / 图标
  ButtonWidget.textIcon(
    this.text,
    this.icon, {
    Key? key,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    double? spacing,
    this.type = ButtonWidgetType.textIcon,
    this.onTap,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.onLongPress,
    this.borderWidth,
    this.padding,
    this.alignment,
    this.hasInkWell = true,
    this.gradient,
  })  : child = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget.oneLine(
              text: text!,
              fontSize: fontSize,
              color: textColor ?? AppColors.textLevelOne,
              fontWeight: fontWeight,
            ),
            SizedBox(width: spacing ?? 5.w),
            icon!,
          ],
        ),
        super(key: key);

  /// 图标 / 文字
  ButtonWidget.iconText(
    this.icon,
    this.text, {
    Key? key,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    double? spacing,
    this.type = ButtonWidgetType.textIcon,
    this.onTap,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.onLongPress,
    this.borderWidth,
    this.padding,
    this.alignment,
    this.hasInkWell = true,
    this.gradient,
  })  : child = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon!,
            SizedBox(width: spacing ?? 5.w),
            TextWidget.oneLine(
              text: text!,
              fontSize: fontSize,
              color: textColor ?? AppColors.textLevelOne,
              fontWeight: fontWeight,
            ),
          ],
        ),
        super(key: key);

  // 子元素
  Widget? get _child {
    switch (type) {
      case ButtonWidgetType.icon:
        return icon;
      default:
        return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: CommonDecoration.getShapeDecoration(
          bg: backgroundColor,
          borderWidth: borderWidth,
          borderColor: borderColor,
          radius: borderRadius ?? 0,
          gradient: gradient,
        ),
        child: InkResponse(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
          highlightShape: BoxShape.rectangle,
          highlightColor: hasInkWell ? Colors.black12 : Colors.transparent,
          splashColor: hasInkWell ? Colors.black12 : Colors.transparent,
          radius: hasInkWell ? 1000 : 0,
          containedInkWell: true,
          child: Container(
            width: width,
            height: height,
            padding: padding,
            alignment: alignment,
            child: _child,
          ),
        ),
      ),
    );
  }
}
