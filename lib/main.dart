import 'dart:async';

import 'package:Smartpay/data/services/navigation_service.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/ui/splash_screen/splash_screen.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oktoast/oktoast.dart';

void main() async {
  //setup dependency injector
  dependenciesInjectorSetup();
  runZonedGuarded(() {
    runApp(const ProviderScope(child: MyApp()));
  }, (dynamic error, dynamic stack) {
    print(error);
    print(stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: ScreenUtilInit(
      designSize: const Size(395, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: getIt<NavigationService>().navigatorKey,
          title: AppStrings.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: AppRouter.generateRoute,
          home: const SplashScreen(),
        );
      },
    ));
  }
}
