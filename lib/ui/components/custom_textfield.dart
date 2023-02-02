import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTextField extends StatelessWidget {
  final Widget? suffix;
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType keyboardType;
  List<TextInputFormatter>? inputFormatters;

  AppTextField(
      {Key? key,
      required this.hint,
      this.suffix,
      this.controller,
      this.onChanged,
      this.obscureText = false,
      required this.keyboardType,
      this.inputFormatters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      child: TextField(
        autocorrect: false,
        obscureText: obscureText,
        controller: controller,
        onChanged: (value) => onChanged!(value),
        keyboardType: keyboardType,
        autofocus: false,
        cursorColor: ThemeConfig.darkColor,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: ThemeConfig.greyColor.withOpacity(0.1),
          hintStyle: TextStyle(
              fontFamily: AppStrings.fontFamily,
              color: ThemeConfig.greyColor,
              fontSize: AppFontSizes.titleFontSize16,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
              height: 1.5),
          labelStyle: TextStyle(
              fontFamily: AppStrings.fontFamily,
              color: ThemeConfig.darkColor,
              fontSize: AppFontSizes.titleFontSize16,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
              height: 1.5,
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.transparent),
              borderRadius: BorderRadius.all(
                  Radius.circular(16.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ThemeConfig.darkAccent),
            borderRadius: const BorderRadius.all(
                Radius.circular(16.0)),),
          contentPadding: const EdgeInsets.only(left: 16, right: 16,),
          suffixIcon: suffix,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class AppPasswordField extends StatefulWidget {
  final Widget? icon;
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const AppPasswordField({
    Key? key,
    required this.hint,
    this.icon,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      child: TextField(
        autocorrect: false,
        obscureText: obscureText,
        obscuringCharacter: '●',
        cursorColor: ThemeConfig.darkColor,
        controller: widget.controller,
        onChanged: (value) => widget.onChanged!(value),
        keyboardType: TextInputType.visiblePassword,
        autofocus: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: ThemeConfig.greyColor.withOpacity(0.1),
          hintText: widget.hint,
          hintStyle: TextStyle(
              fontFamily: AppStrings.fontFamily,
              color: ThemeConfig.greyColor,
              fontSize: AppFontSizes.titleFontSize16,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
              height: 1.5),
          labelStyle: TextStyle(
            fontFamily: AppStrings.fontFamily,
            color: ThemeConfig.darkColor,
            fontSize: AppFontSizes.titleFontSize16,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            height: 1.5,
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.transparent),
              borderRadius: BorderRadius.all(
                  Radius.circular(16.0))),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeConfig.darkAccent),
            borderRadius: const BorderRadius.all(
                Radius.circular(16.0)),),
          contentPadding: const EdgeInsets.only(left: 16, right: 16,),
          prefixIcon: widget.icon,
          border: InputBorder.none,
          suffixIcon: Container(
            width: 24, height: 24,
            child: IconButton(
              color: ThemeConfig.greyColor,
              onPressed: _togglePasswordView,
              icon: obscureText
                  ? SvgPicture.asset(AppImages.visibilityOff)
                  : const Icon(Icons.visibility),
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
