import 'package:Smartpay/ui/splash_screen/splash_screen.dart';
import 'package:Smartpay/utils/app_fonts.dart';
import 'package:Smartpay/utils/app_provider.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppProvider()),
        ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget? child){
        return MaterialApp(
          key: appProvider.key,
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}

