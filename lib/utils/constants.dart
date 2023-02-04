import 'package:Smartpay/domain/model/country_model.dart';
import 'package:flutter/material.dart';

class AppStrings {
  static String fontFamily = 'SF Pro Display';

  static String appName = 'Smartpay';
  static String smart = 'Smart';
  static String pay = 'pay.';
  static String email = "Email";
  static String smartPay = 'Smartpay';
  static String password = "Password";
  static String hiThere = 'Hi There! 👋';
  static String verifyItsYou = 'Verify it’s you';
  static String confirm = "Confirm";
  static String signUp = "Sign Up";
  static String signIn = "Sign In";
  static String createA = "Create a ";
  static String account = "account";
  static String yourself = "yourself";
  static String fullName = "Full name";
  static String userName = "Username";
  static String country = "Select Country";
  static String forgotPassword = "Forgot Password?";
  static String dontHaveAnAccount = "Don’t have an account? ";
  static String alreadyHaveAnAccount = "Already have an account? ";
  static String welcomeBack = "Welcome back, Sign in to your account";
  static String weSentACode = "We send a code to ( %s ). "
      "Enter it here to verify your identity";
  static String heyThereTellUs = "Hey there! tell us a bit \nabout ";

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
  static const String dropdownIcon = "assets/images/ic_drop_down.svg";
  static const String searchIcon = "assets/images/ic_search.svg";
  static const String usaIcon = "assets/images/ic_usa.svg";
  static const String chinaIcon = "assets/images/ic_china.svg";
  static const String indonesiaIcon = "assets/images/ic_indonesia.svg";
  static const String netherLandIcon = "assets/images/ic_netherlands.svg";
  static const String singaporeIcon = "assets/images/ic_singapore.svg";
  static const String ukIcon = "assets/images/ic_uk.svg";
  static const String icCheck = "assets/images/ic_check.svg";

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

const String icUsaIcon = "assets/images/ic_usa.svg";
const String icChinaIcon = "assets/images/ic_china.svg";
const String icIndonesiaIcon = "assets/images/ic_indonesia.svg";
const String icNetherLandIcon = "assets/images/ic_netherlands.svg";
const String icSingaporeIcon = "assets/images/ic_singapore.svg";
const String icUkIcon = "assets/images/ic_uk.svg";

final dummyCountryFlagList = [icUsaIcon, icUkIcon, icSingaporeIcon, icChinaIcon,
icNetherLandIcon, icIndonesiaIcon, icUsaIcon, icUkIcon, icSingaporeIcon, icChinaIcon,
  icNetherLandIcon, icIndonesiaIcon,];

final dummyCountryCodeList = ["US", "UK", "SG",
  "CN", "NL", "ID", "US", "UK", "SG",
  "CN", "NL", "ID", ];

final dummyCountryNameList = ["United States", "United Kingdom", "Singapore",
  "China", "Netherland", "Indonesia", "United States", "United Kingdom", "Singapore",
  "China", "Netherland", "Indonesia",];

class DemoCountryValues {
  static final List<CountryModel> countries = [
    const CountryModel(
      id: "1",
      countryName: "United States",
      countryFlag: icUsaIcon,
      countryCode: "US",
    ),
    const CountryModel(
      id: "2",
      countryName: "United Kingdom",
      countryFlag: icUkIcon,
      countryCode: "UK",
    ),
    const CountryModel(
      id: "3",
      countryName: "Singapore",
      countryFlag: icSingaporeIcon,
      countryCode: "SG",
    ),
    const CountryModel(
      id: "4",
      countryName: "China",
      countryFlag: icChinaIcon,
      countryCode: "CN",
    ),
    const CountryModel(
      id: "5",
      countryName: "Netherland",
      countryFlag: icNetherLandIcon,
      countryCode: "NL",
    ),
    const CountryModel(
      id: "6",
      countryName: "Indonesia",
      countryFlag: icIndonesiaIcon,
      countryCode: "ID",
    ),
  ];
}