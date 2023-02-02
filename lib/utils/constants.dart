
import 'package:flutter/material.dart';

class AppStrings {
  static String appName = 'Smartpay';
  static String smart = 'Smart';
  static String pay = 'pay.';
}

class Sized16Container extends StatelessWidget {
  final Widget? child;
  final Decoration? decoration;

  const Sized16Container({super.key, this.child, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}

class AppImages{
  static const String appSplashLogo = "assets/images/ic_splash_logo.svg";
}