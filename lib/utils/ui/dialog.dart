import 'package:flutter/material.dart';
import 'package:flutter_mood/extension/index.dart';
import 'package:flutter_mood/utils/ui/button.dart';
import 'package:flutter_mood/utils/ui/text.dart';
import 'package:flutter_mood/utils/values/colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonDialog {
  static void oneButton({
    String title = '温馨提示',
    String description = '',
    String confirmTitle = '确定',
    VoidCallback? onConfirm,
    String? tag,
    VoidCallback? onDismiss,
  }) {
    SmartDialog.show(
      builder: (context) {
        return Container(
          width: ScreenUtil().screenWidth - 30.w,
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8.w)),
          padding: EdgeInsets.fromLTRB(20.w, 15.w, 20.w, 25.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title.notEmpty) ...[
                TextWidget.moreLine(text: title, fontSize: 18, color: AppColors.textLevelOne),
                SizedBox(height: 20.w),
              ],
              if (description.notEmpty) ...[
                TextWidget.moreLine(text: description, fontSize: 15, color: AppColors.textLevelOne),
                SizedBox(height: 25.w),
              ],
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ButtonWidget.text(
                        confirmTitle,
                        textColor: AppColors.white,
                        borderColor: AppColors.primary,
                        backgroundColor: AppColors.primary,
                        borderWidth: 0.5,
                        borderRadius: 45.w,
                        height: 45.w,
                        alignment: Alignment.center,
                        onTap: () {
                          onConfirm?.call();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      backDismiss: false,
      clickMaskDismiss: false,
      tag: tag,
      onDismiss: onDismiss,
    );
  }

  static void twoButton({
    String title = '温馨提示',
    String description = '',
    String cancelTitle = '取消',
    String confirmTitle = '确定',
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    Widget? descriptionWidget,
    String? tag,
    VoidCallback? onDismiss,
  }) {
    SmartDialog.show(
      builder: (context) {
        List<Widget> children = [];

        /// 标题
        if (title.notEmpty) {
          children.addAll([
            TextWidget.moreLine(text: title, fontSize: 18, color: AppColors.textLevelOne),
            SizedBox(height: 20.w),
          ]);
        }

        /// 描述
        if (descriptionWidget != null) {
          children.addAll([
            descriptionWidget,
            SizedBox(height: 25.w),
          ]);
        } else {
          if (description.notEmpty) {
            children.addAll([
              TextWidget.moreLine(text: description, fontSize: 15, color: AppColors.textLevelOne),
              SizedBox(height: 25.w),
            ]);
          }
        }

        return Container(
          width: ScreenUtil().screenWidth - 30.w,
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8.w)),
          padding: EdgeInsets.fromLTRB(20.w, 15.w, 20.w, 25.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (children.isNotEmpty) ...children,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ButtonWidget.text(
                        cancelTitle,
                        textColor: AppColors.primary,
                        borderColor: AppColors.primary,
                        borderWidth: 0.5,
                        borderRadius: 45.w,
                        height: 45.w,
                        alignment: Alignment.center,
                        onTap: () {
                          SmartDialog.dismiss();
                          onCancel?.call();
                        },
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: ButtonWidget.text(
                        confirmTitle,
                        textColor: AppColors.white,
                        borderColor: AppColors.primary,
                        backgroundColor: AppColors.primary,
                        borderWidth: 0.5,
                        borderRadius: 45.w,
                        height: 45.w,
                        alignment: Alignment.center,
                        onTap: () async {
                          await SmartDialog.dismiss();
                          onConfirm?.call();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      backDismiss: false,
      clickMaskDismiss: false,
      tag: tag,
      onDismiss: onDismiss,
    );
  }
}
