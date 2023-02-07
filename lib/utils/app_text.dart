import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';

class AppTextView {

  static Widget getAppTextView(text,
      {size, color, textAlign, weight, height, letterSpacing, TextDecoration? textDecoration}) {
    final displayText = text.toString().toLowerCase() == "null" ? "" : text;
    final textSize = size == null ? null : double.parse(size.toString());
    return Text(displayText,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
            fontFamily: AppStrings.fontFamily,
            color: color ?? ThemeConfig.greyColor,
            fontSize: textSize ?? AppFontSizes.titleFontSize16,
            fontWeight: weight ?? FontWeight.w400,
            fontStyle: FontStyle.normal,
            decoration: textDecoration ?? TextDecoration.none,
            height: height ?? 1.5,  letterSpacing: letterSpacing ?? 0.3
        ));
  }

  static Widget getAppTextViewBold(text,
      {size, color, textAlign, weight, height, letterSpacing, TextDecoration? textDecoration}) {
    final textSize = size == null ? null : double.parse(size.toString());
    return Text(text,
        textAlign: textAlign ?? TextAlign.left,
        style: TextStyle(
          fontFamily: AppStrings.fontFamily,
          color: color ?? ThemeConfig.darkColor,
          fontSize: textSize ?? AppFontSizes.headingFontSize24,
          fontWeight: weight ?? FontWeight.w600,
          fontStyle: FontStyle.normal,
          decoration: textDecoration ?? TextDecoration.none,
            height: height ?? 1.3,  letterSpacing: letterSpacing ?? -0.2
        ));
  }
}
