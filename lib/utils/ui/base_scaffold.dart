import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mood/routers/route.dart';
import 'package:flutter_mood/utils/ui/button.dart';
import 'package:flutter_mood/utils/ui/text.dart';
import 'package:flutter_mood/utils/values/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_mood/extension/index.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    Key? key,
    required this.child,
    this.title,
    this.titleStr,
    this.titleColor = AppColors.black,
    this.backIcon = 'assets/svg/back_gray.svg',
    this.backString = '返回',
    this.backColor = AppColors.black,
    this.onWillPop,
    this.actions,
    this.elevation = 0,
    this.scaffoldBackgroundColor = Colors.white,
    this.appbarBackgroundColor = AppColors.white,
    this.statusBarStyle = MainStatusBar.dark,
    this.appbarHeight,
    this.safeAreaBottom,
    this.safeAreaTop,
    this.resizeToAvoidBottomInset,
    this.touchHideKeyboard = true,
    this.hideBackBtn = false,
    this.titleSpacing,
  }) : super(key: key);

  final Widget child;
  final Widget? title;
  final String? titleStr;
  final Color titleColor;
  final String backIcon;
  final String backString;
  final Color backColor;
  final Function()? onWillPop;
  final List<Widget>? actions;
  final double? elevation;
  final Color scaffoldBackgroundColor;
  final Color appbarBackgroundColor;
  final double? appbarHeight;
  final bool? safeAreaBottom;
  final bool? safeAreaTop;
  final bool? resizeToAvoidBottomInset;
  final SystemUiOverlayStyle statusBarStyle;
  final bool touchHideKeyboard;
  final bool hideBackBtn;
  final double? titleSpacing;

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget? appBar;
    if (title != null || titleStr.notEmpty) {
      Widget? titleWidget = title;
      if (titleStr.notEmpty) {
        titleWidget = TextWidget.oneLine(
          text: titleStr!,
          fontSize: 17,
          color: titleColor,
          fontWeight: FontWeight.bold,
        );
      }
      Function() back = () {};
      if (onWillPop != null) {
        back = onWillPop!;
      } else {
        back = () => CommonRoute.close();
      }
      appBar = CommonRootUtils.buildAppBar(
        context,
        title: titleWidget,
        leading: hideBackBtn
            ? null
            : UnconstrainedBox(
                child: ButtonWidget.iconText(
                  SvgPicture.asset(backIcon, height: 20, width: 20, color: backColor),
                  backString,
                  onTap: back,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  textColor: backColor,
                  hasInkWell: false,
                  spacing: 0,
                ),
              ),
        actions: actions,
        elevation: elevation,
        backgroundColor: appbarBackgroundColor,
        statusBarStyle: statusBarStyle,
        titleSpacing: titleSpacing,
      );
    }
    var body = child;
    return CommonRootUtils.buildRoot(
      context,
      body,
      appBar: appBar,
      backgroundColor: scaffoldBackgroundColor,
      bottom: safeAreaBottom,
      top: safeAreaTop,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      statusBarStyle: statusBarStyle,
    );
  }
}

class CommonRootUtils {
  static Widget buildRoot(
    BuildContext context,
    Widget body, {
    PreferredSizeWidget? appBar,
    Color backgroundColor = Colors.white,
    bool? bottom,
    bool? top,
    bool? resizeToAvoidBottomInset,
    SystemUiOverlayStyle statusBarStyle = MainStatusBar.dark,
    bool touchHideKeyboard = true,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: touchHideKeyboard ? () => FocusManager.instance.primaryFocus?.unfocus() : null,
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
        backgroundColor: backgroundColor,
        appBar: appBar,
        body: appBar == null
            ? AnnotatedRegion<SystemUiOverlayStyle>(
                value: statusBarStyle,
                child: SafeArea(top: top ?? false, bottom: bottom ?? false, child: body),
              )
            : SafeArea(top: top ?? false, bottom: bottom ?? false, child: body),
      ),
    );
  }

  /// AppBar
  static PreferredSizeWidget buildAppBar(
    BuildContext context, {
    Widget? title,
    Widget? leading,
    List<Widget>? actions,
    SystemUiOverlayStyle statusBarStyle = MainStatusBar.dark,
    double? elevation,
    Color backgroundColor = AppColors.white,
    double? titleSpacing,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(44),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shadowColor: AppColors.grayEe,
        centerTitle: true,
        title: title,
        leading: leading,
        actions: actions,
        systemOverlayStyle: statusBarStyle,
        titleSpacing: titleSpacing,
      ),
    );
  }
}

class MainStatusBar {
  ///状态栏白色文字
  static const SystemUiOverlayStyle _light = SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFFFFFFFF),
    systemNavigationBarDividerColor: null,
    statusBarColor: Color(0x00000000),
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  ///状态栏黑色文字
  static const SystemUiOverlayStyle _dark = SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFFFFFFFF),
    systemNavigationBarDividerColor: null,
    statusBarColor: Color(0x00000000),
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  static void setStatusBar(bool white) => SystemChrome.setSystemUIOverlayStyle(white ? _light : _dark);

  static const SystemUiOverlayStyle light = _light;
  static const SystemUiOverlayStyle dark = _dark;
}
