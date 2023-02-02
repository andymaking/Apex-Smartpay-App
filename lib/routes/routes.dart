import 'package:Smartpay/ui/components/route_error_page.dart';
import 'package:Smartpay/ui/sign_in/sign_in.dart';
import 'package:Smartpay/ui/sign_up/sign_up.dart';
import 'package:Smartpay/ui/verify_otp/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static const home = '/home';
  static const signIn = '/signIn';
  static const signUp = '/signUp';
  static const onBoarding = '/onBoarding';
  static const verifyOtp = '/verifyOtp';
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

      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ErrorPage(),
          settings: settings,
          fullscreenDialog: true,
        );
    }
  }
}
