import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/toast.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class SignUpViewModel extends BaseViewModel {
  final userRepository = getIt<UserRepository>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ViewState _state = ViewState.idle;
  @override
  ViewState get viewState => _state;
  String errorMessage = "";
  String email = "";
  bool isValidEmail = false;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  setEmail(String mail) {
    email = mail;
    notifyListeners();
  }

  showError() {
    if (email.isEmpty) {
      errorMessage = "${errorMessage}Please Enter your Email,  ";
    }
    showCustomToast(errorMessage);
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void validateEmailInput() {
    isValidEmail = isValidEmailPattern();
    notifyListeners();
  }

  bool isValidEmailPattern() {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  /// get user email token
  Future<String?> getEmailToken(String email) async {
    try {
      setViewState(ViewState.loading);
      var response = await userRepository.getEmailToken(email);
      setViewState(ViewState.success);
      sharedPreference.saveEmail(email);
      print("Showing email token response::: $response");
      return response;
    } catch (error) {
      setViewState(ViewState.error);
      setError(error.toString());
    }
  }
}
