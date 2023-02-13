import 'package:Smartpay/theme/theme_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialAuthButtons extends StatelessWidget {
  Function()? onPressed;
  final String icon;

  SocialAuthButtons(
      {Key? key,
        required this.onPressed,
        required this.icon,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(
              vertical: 2.5,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ThemeConfig.btnBorderColor,
            ),
          ),
          child: Center(
              child: SvgPicture.asset(
                icon,
              )
          ),
        ));
  }
}