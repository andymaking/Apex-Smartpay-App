import 'package:Smartpay/theme/theme_config.dart';
import 'package:flutter/material.dart';

class AppFontsStyle {
  static String fontFamily = 'SF Pro Display';
  static double headingFontSize32 = 32.0;
  static double headingFontSize24 = 24.0;
  static double headingFontSize22 = 22.0;
  static double headingFontSize20 = 20.0;
  static double titleFontSize18 = 18.0;
  static double titleFontSize16 = 16.0;
  static double titleNormalSize14 = 14.0;
  static double textCaptionSize12 = 12.0;

  static Widget getAppTextView(text,
      {size, color, textAlign, TextDecoration? textDecoration}) {
    final displayText = text.toString().toLowerCase() == "null" ? "" : text;
    final textSize = size == null ? null : double.parse(size.toString());
    return Text(displayText,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
          fontFamily: AppFontsStyle.fontFamily,
          color: color ?? ThemeConfig.greyColor,
          fontSize: textSize ?? AppFontsStyle.titleFontSize16,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          decoration: textDecoration ?? TextDecoration.none,
          height: 1.5,
          letterSpacing: 0.3,
        ));
  }

  static Widget getAppTextViewBold(text,
      {size, color, textAlign, weight, TextDecoration? textDecoration}) {
    final textSize = size == null ? null : double.parse(size.toString());
    return Text(text,
        textAlign: textAlign ?? TextAlign.left,
        style: TextStyle(
          fontFamily: AppFontsStyle.fontFamily,
          color: color ?? ThemeConfig.darkColor,
          fontSize: textSize ?? AppFontsStyle.headingFontSize24,
          fontWeight: weight ?? FontWeight.w600,
          fontStyle: FontStyle.normal,
          decoration: textDecoration ?? TextDecoration.none,
        ));
  }
}
