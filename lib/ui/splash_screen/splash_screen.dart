import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/utils/app_fonts.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.appSplashLogo),
            const SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: Text.rich(
                      TextSpan(
                          text: AppStrings.smart,
                          semanticsLabel: AppStrings.smart,
                          style: TextStyle(
                            fontFamily: AppFontsStyle.fontFamily,
                            color: ThemeConfig.darkColor,
                            fontSize: AppFontsStyle.headingFontSize32,
                            fontWeight: FontWeight.w600,),
                          children: <TextSpan>[
                            TextSpan(
                              text: AppStrings.pay,
                              semanticsLabel: AppStrings.pay,
                              style: TextStyle(
                              fontFamily: AppFontsStyle.fontFamily,
                              color: ThemeConfig.darkAccent,
                              fontSize: AppFontsStyle.headingFontSize32,
                              fontWeight: FontWeight.w600,),
                            ),
                          ]
                      )
                  )
              ),
            )
          ],
        ),
    ),);
  }
}