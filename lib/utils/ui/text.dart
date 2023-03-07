import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget.oneLine({
    Key? key,
    required this.text,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.maxLines = 1,
    this.softWrap = false,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign,
    this.height,
  }) : super(key: key);

  const TextWidget.moreLine({
    Key? key,
    required this.text,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
    this.softWrap = true,
    this.overflow,
    this.textAlign,
    this.height = 1.5,
  }) : super(key: key);

  /// 文字字符串
  final String text;

  /// 样式
  final TextStyle? style;

  /// 颜色
  final Color? color;

  /// 字号
  final double? fontSize;

  /// 字重
  final FontWeight? fontWeight;

  /// 最大行数
  final int? maxLines;

  /// 自动换行
  final bool? softWrap;

  /// 溢出
  final TextOverflow? overflow;

  /// 对齐方式
  final TextAlign? textAlign;

  /// 行间距
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (text == '') return const SizedBox();
    return Text(
      text,
      style: style?.copyWith(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
          ) ??
          TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
          ),
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      textAlign: textAlign,
    );
  }
}
