import 'package:flutter/material.dart';

class AppStrings {
  static String fontFamily = 'SF Pro Display';

  static String appName = 'Smartpay';
  static String smart = 'Smart';
  static String pay = 'pay.';
  static String email = "Email";
  static String password = "Password";
  static String hiThere = 'Hi There! 👋';
  static String signUp = "Sign Up";
  static String signIn = "Sign In";
  static String forgotPassword = "Forgot Password?";
  static String dontHaveAnAccount = "Don’t have an account? ";
  static String welcomeBack = "Welcome back, Sign in to your account";
}

class Sized24Container extends StatelessWidget {
  final Widget? child;
  final Decoration? decoration;

  const Sized24Container({super.key, this.child, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: child,
    );
  }
}

class AppImages {
  static const String appSplashLogo = "assets/images/ic_splash_logo.svg";
  static const String appBackBtn = "assets/images/ic_back_btn.svg";
  static const String visibilityOff = "assets/images/ic_visibility_off.svg";
  static const String or = "assets/images/ic_or.svg";
  static const String googleLogo = "assets/images/ic_google_logo.svg";
  static const String appleLogo = "assets/images/ic_apple_logo.svg";
}

class AppFontSizes {
  static double headingFontSize32 = 32.0;
  static double headingFontSize24 = 24.0;
  static double headingFontSize22 = 22.0;
  static double headingFontSize20 = 20.0;
  static double titleFontSize18 = 18.0;
  static double titleFontSize16 = 16.0;
  static double titleNormalSize14 = 14.0;
  static double textCaptionSize12 = 12.0;
  static double textCaptionSize10 = 10.0;
}