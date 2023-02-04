import 'package:Smartpay/core/network_config.dart';
import 'package:Smartpay/core/services/navigation_service.dart';
import 'package:Smartpay/core/services/storage-service.dart';
import 'package:Smartpay/ui/create_user_info/get_user_info_view_model.dart';
import 'package:Smartpay/ui/set_pin/set_pin_view_model.dart';
import 'package:Smartpay/ui/sign_in/sign_in_view_model.dart';
import 'package:Smartpay/ui/sign_up/sign_up_view_model.dart';
import 'package:Smartpay/ui/verify_otp/email_verification_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

GetIt getIt = GetIt.I;

dependenciesInjectorSetup() {
  //initialize WidgetsFlutterBinding

  //Interceptors configuration
  getIt.registerFactory(() {
    Dio dio = Dio();
    dio.options.headers['Client-Id'] = NetworkConfig.CLIENT_ID;
    dio.options.headers['Client-key'] = NetworkConfig.CLIENT_KEY;
    dio.options.headers['Client-Secret'] = NetworkConfig.CLIENT_SECRET;
    dio.interceptors.add(PrettyDioLogger());
    // customization what should print on logs
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return dio;
  });

  //View Model
  getIt.registerFactory<SignInViewModel>(() => SignInViewModel());
  getIt.registerFactory<SignUpViewModel>(() => SignUpViewModel());
  getIt.registerFactory<EmailVerificationViewModel>(() => EmailVerificationViewModel());
  getIt.registerFactory<GetUserInfoViewModel>(() => GetUserInfoViewModel());
  getIt.registerFactory<SetUserPinViewModel>(() => SetUserPinViewModel());

  // Services
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<StorageService>(() => StorageService());

}
