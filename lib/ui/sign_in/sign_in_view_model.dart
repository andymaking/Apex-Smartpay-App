import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/domain/model/login_user.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/custom_dialog.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:Smartpay/utils/validations.dart';
import 'package:flutter/cupertino.dart';

class SignInViewModel extends BaseViewModel {
  final userRepository = getIt<UserRepository>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String email = "";
  String savedEmail = "";

  //String token = "";
  String password = "";
  String savedPassword = "";
  String message = "";
  String errorMessage = "";
  bool isValidSignIn = false;

  ViewState _state = ViewState.idle;

  @override
  ViewState get viewState => _state;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  setEmail(String mail) {
    email = mail;
    notifyListeners();
  }

  setPassword(String pwd) {
    password = pwd;
    notifyListeners();
  }

  void validSignIn() {
    isValidSignIn = isValidEmails(email)
        && isValidPasswords(password);
    notifyListeners();
  }

  void getSavedPinEmailAndPassword() async {
    savedEmail = await sharedPreference.getEmail();
    savedPassword = await sharedPreference.getPassword();
    notifyListeners();
  }

  Future<void> verifySignIn(BuildContext context) async {
    if (email.isNotEmpty &&
        savedEmail.isNotEmpty &&
        email == savedEmail &&
        password.isNotEmpty &&
        savedPassword.isNotEmpty &&
        password == savedPassword) {
      signIn(context);
    } else {
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title: "Incorrect login details, kindly cross check and try again",
            isError: true,
            onPressed: () {},
          ));
    }
  }

  Future<LoginUserResponse?> signIn(BuildContext context) async {
    try {
      setViewState(ViewState.loading);
      var response = await userRepository.login(email, password);
      sharedPreference.saveIsLoggedIn(true);
      sharedPreference.saveToken("${response?.data?.token}");
      setViewState(ViewState.success);
      navigationService.navigateToReplace(AppRoutes.home);
      return response;
    } catch (error) {
      setViewState(ViewState.error);
      setError(error.toString());
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title: errorMessage,
            isError: true,
            onPressed: () {},
          ));
    }
  }
}
