import 'package:Smartpay/ui/components/route_error_page.dart';
import 'package:Smartpay/ui/congats/congratulations.dart';
import 'package:Smartpay/ui/create_user_info/get_user_info.dart';
import 'package:Smartpay/ui/set_pin/set_pin.dart';
import 'package:Smartpay/ui/sign_in/sign_in.dart';
import 'package:Smartpay/ui/sign_up/sign_up.dart';
import 'package:Smartpay/ui/verify_otp/verify_email_otp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static const home = '/home';
  static const signIn = '/signIn';
  static const signUp = '/signUp';
  static const onBoarding = '/onBoarding';
  static const verifyOtp = '/verifyOtp';
  static const getUserInfo = '/createUserInfo';
  static const setUserPin = '/setUserPin';
  static const congrats = '/congrats';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // E.g Navigator.of(context).pushNamed(AppRoutes.theScreenYouAreGoingTo);
    switch (settings.name) {
      // case AppRoutes.home:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => HomePage(),
      //     settings: settings,
      //     fullscreenDialog: true,
      //   );
      case AppRoutes.signIn:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SignInScreen(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.signUp:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SignUpScreen(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.verifyOtp:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const EmailVerification(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.getUserInfo:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const GetUserInfoScreen(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.setUserPin:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SetUserPinScreen(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.congrats:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const Congratulations(),
          settings: settings,
          fullscreenDialog: true,
        );

      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ErrorPage(),
          settings: settings,
          fullscreenDialog: true,
        );
    }
  }
}
