import 'package:Smartpay/core/services/navigation_service.dart';
import 'package:Smartpay/core/services/storage-service.dart';
import 'package:Smartpay/ui/sign_in/sign_in_view_model.dart';
import 'package:Smartpay/ui/sign_up/sign_up_view_model.dart';
import 'package:Smartpay/ui/verify_otp/email-verification.vm.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.I;

dependenciesInjectorSetup() {
  //View Model
  getIt.registerFactory<SignInViewModel>(() => SignInViewModel());
  getIt.registerFactory<SignUpViewModel>(() => SignUpViewModel());
  getIt.registerFactory<EmailVerificationViewModel>(() => EmailVerificationViewModel());

  // Services
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<StorageService>(() => StorageService());

}
