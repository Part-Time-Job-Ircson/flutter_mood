import 'package:flutter/material.dart';

class CommonDecoration {
  ///简单的一个装饰器，只要用于一个按钮的样式，背景+描边（圆角）
  static Decoration getShapeDecoration({
    Color? bg,
    double radius = 90,
    Color? borderColor,
    double? borderWidth,
    BorderStyle borderStyle = BorderStyle.solid,
    DecorationImage? image,
    Gradient? gradient,
    List<BoxShadow>? shadows,
  }) {
    return ShapeDecoration(
        color: bg,
        image: image,
        gradient: gradient,
        shadows: shadows,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: borderColor != null && borderWidth != null
              ? BorderSide(
                  color: borderColor,
                  width: borderWidth,
                  style: borderStyle,
                )
              : BorderSide.none,
        ));
  }

  ///获取某个方向的划线,主要用于自定义某个描边
  static Decoration getBorder({
    Color? bg,
    BorderSide? left,
    BorderSide? top,
    BorderSide? right,
    BorderSide? bottom,
    DecorationImage? image,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return BoxDecoration(
      color: bg,
      image: image,
      boxShadow: boxShadow,
      gradient: gradient,
      backgroundBlendMode: backgroundBlendMode,
      shape: shape,
      border: Border(
        left: left ?? BorderSide.none,
        top: top ?? BorderSide.none,
        right: right ?? BorderSide.none,
        bottom: bottom ?? BorderSide.none,
      ),
    );
  }

  ///获取某个方向的圆角,主要用于自定义某个圆角
  static Decoration getRadius({
    Color? bg,
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
    double all = 0,
    DecorationImage? image,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    BoxShape shape = BoxShape.rectangle,
  }) {
    var borderRadius = all > 0
        ? BorderRadius.all(Radius.circular(all))
        : BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
          );
    return BoxDecoration(
      color: bg,
      image: image,
      boxShadow: boxShadow,
      gradient: gradient,
      backgroundBlendMode: backgroundBlendMode,
      shape: shape,
      borderRadius: borderRadius,
    );
  }

  ///获取一个阴影装饰
  static Decoration getShadow({
    Color bg = const Color(0xFFFFFFFF),
    Color borderColor = const Color(0xFFFFFFFF),
    double borderWidth = 0.5,
    double radius = 90,
    Color shadowColor = const Color(0xFFFFFFFF),
    Offset shadowOffset = Offset.zero,
    double shadowBlurRadius = 6,
    List<BoxShadow>? boxShadow,
  }) {
    boxShadow ??= [
      BoxShadow(
        color: shadowColor,
        offset: shadowOffset,
        blurRadius: shadowBlurRadius,
      )
    ];
    return BoxDecoration(
      color: bg,
      border: Border.fromBorderSide(BorderSide(
        color: borderColor,
        width: borderWidth,
        style: BorderStyle.solid,
      )),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      boxShadow: boxShadow,
    );
  }
}
