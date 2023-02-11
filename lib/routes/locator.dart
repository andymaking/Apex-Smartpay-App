import 'package:Smartpay/data/cache/user.cache.dart';
import 'package:Smartpay/data/core/network/NetworkService.dart';
import 'package:Smartpay/data/core/network_config.dart';
import 'package:Smartpay/data/remote/user_remote.dart';
import 'package:Smartpay/data/remote/user_remote_impl.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/data/repository/user_repository_impl.dart';
import 'package:Smartpay/data/services/navigation_service.dart';
import 'package:Smartpay/data/services/storage-service.dart';
import 'package:Smartpay/domain/model/token_meta_data.dart';
import 'package:Smartpay/ui/create_user_info/get_user_info_view_model.dart';
import 'package:Smartpay/ui/dashboard/dashboard_view_model.dart';
import 'package:Smartpay/ui/enter_pin/enter_pin_view_model.dart';
import 'package:Smartpay/ui/set_pin/set_pin_view_model.dart';
import 'package:Smartpay/ui/sign_in/sign_in_view_model.dart';
import 'package:Smartpay/ui/sign_up/sign_up_view_model.dart';
import 'package:Smartpay/ui/verify_otp/email_verification_view_model.dart';
import 'package:Smartpay/utils/sharedpreferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

GetIt getIt = GetIt.I;

dependenciesInjectorSetup() async {
  //initialize WidgetsFlutterBinding
  WidgetsFlutterBinding.ensureInitialized();

  //Interceptors configuration
  getIt.registerFactory(() {
    Dio dio = Dio();
    return dio;
  });

  //View Model
  getIt.registerFactory<SignInViewModel>(() => SignInViewModel());
  getIt.registerFactory<SignUpViewModel>(() => SignUpViewModel());
  getIt.registerFactory<EmailVerificationViewModel>(() => EmailVerificationViewModel());
  getIt.registerFactory<GetUserInfoViewModel>(() => GetUserInfoViewModel());
  getIt.registerFactory<SetUserPinViewModel>(() => SetUserPinViewModel());
  getIt.registerFactory<EnterUserPinViewModel>(() => EnterUserPinViewModel());
  getIt.registerFactory<DashBoardViewModel>(() => DashBoardViewModel());

  // Services
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<StorageService>(() => StorageService());
  getIt.registerLazySingleton<SharedPreference>(() => SharedPreference());
  getIt.registerLazySingleton<NetworkService>(() => NetworkService());
  getIt.registerLazySingleton<UserRemoteImpl>(() => UserRemoteImpl(getIt<Dio>()));

  getIt.registerFactory<UserRemote>(() => UserRemoteImpl(getIt<Dio>()));
  getIt.registerFactory<UserRepository>(
          () => UserRepositoryImpl(getIt<UserRemote>()));
}
