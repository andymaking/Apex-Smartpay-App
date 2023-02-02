import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppToolbar extends StatelessWidget {
  const AppToolbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Sized24Container(
      child: SizedBox(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(AppImages.appBackBtn)),
      ),
    );
  }
}
