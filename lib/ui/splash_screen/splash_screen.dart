import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;


  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.setUserPin);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
              child: SvgPicture.asset(AppImages.appSplashLogo),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: Text.rich(TextSpan(
                      text: AppStrings.smart,
                      semanticsLabel: AppStrings.smart,
                      style: TextStyle(
                        fontFamily: AppStrings.fontFamily,
                        color: ThemeConfig.darkColor,
                        fontSize: AppFontSizes.headingFontSize32,
                        fontWeight: FontWeight.w600,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                      text: AppStrings.pay,
                      semanticsLabel: AppStrings.pay,
                      style: TextStyle(
                        fontFamily: AppStrings.fontFamily,
                        color: ThemeConfig.darkAccent,
                        fontSize: AppFontSizes.headingFontSize32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]))),
            )
          ],
        ),
      ),
    );
  }
}
