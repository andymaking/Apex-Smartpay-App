
import 'package:flutter/material.dart';

class AppStrings {
  static String appName = 'Smartpay';
  static String smart = 'Smart';
  static String pay = 'pay.';
}

class Sized24Container extends StatelessWidget {
  final Widget? child;
  final Decoration? decoration;

  const Sized24Container({super.key, this.child, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: child,
    );
  }
}

class AppImages{
  static const String appSplashLogo = "assets/images/ic_splash_logo.svg";
  static const String slide1Image = "assets/images/slide1.png";
  static const String slide2Image = "assets/images/slide2.png";
}