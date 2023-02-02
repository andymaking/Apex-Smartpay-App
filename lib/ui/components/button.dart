import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/utils/app_fonts.dart';
import 'package:flutter/cupertino.dart';

class AppButton extends StatelessWidget {
  Function()? onPressed;
  String title;
  bool enabled;

  AppButton(
      {Key? key,
        required this.onPressed,
        required this.title,
        required this.enabled,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: enabled ? onPressed : null,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(
              vertical: 2.5,
              horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: enabled ? ThemeConfig.darkColor : ThemeConfig.darkColor.withOpacity(0.7),
          ),
          child: Center(
            child: AppFontsStyle.getAppTextViewBold(title, size:AppFontsStyle.titleFontSize16, color: ThemeConfig.lightPrimary)
          ),
        ));
  }
}