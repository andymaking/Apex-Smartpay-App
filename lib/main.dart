import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/ui/splash_screen/splash_screen.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'core/services/navigation_service.dart';
import 'core/services/storage-service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //setup dependency injector
  dependenciesInjectorSetup();
  StorageService storageService = getIt<StorageService>();
  runApp(const MyApp());
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
