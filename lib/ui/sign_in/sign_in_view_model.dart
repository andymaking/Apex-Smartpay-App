import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/core/table_constants.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/domain/model/login_user.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/custom_dialog.dart';
import 'package:Smartpay/ui/components/toast.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInViewModel extends BaseViewModel {
  final userRepository = getIt<UserRepository>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String email = "";
  String token = "";
  String password = "";
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
    isValidSignIn = email.isNotEmpty && password.isNotEmpty;
    notifyListeners();
  }

  Future<String?> signIn(String email,String password,
      BuildContext context) async {
    try {
      setViewState(ViewState.loading);
      var response = await userRepository.login(email, password);
      setLogin(true);
      setViewState(ViewState.success);
      token = response.toString();

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
  setLogin(val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('log', val);
    notifyListeners();
  }

}
