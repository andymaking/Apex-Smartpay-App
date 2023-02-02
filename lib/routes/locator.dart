import 'package:Smartpay/core/services/navigation_service.dart';
import 'package:Smartpay/core/services/storage-service.dart';
import 'package:Smartpay/ui/sign_in/sign_in_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.I;

dependenciesInjectorSetup() {
  //View Model
  getIt.registerFactory<SignInViewModel>(() => SignInViewModel());

  // Services
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<StorageService>(() => StorageService());

}
