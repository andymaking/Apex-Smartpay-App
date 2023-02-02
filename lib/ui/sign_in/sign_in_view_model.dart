import 'package:Smartpay/core/enum/view_state.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/toast.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/services/storage-service.dart';

class SignInViewModel extends BaseViewModel {
  StorageService storageService = getIt<StorageService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  setEmail(String mail) {
    email = mail;
    notifyListeners();
  }

  setPassword(String pwd) {
    password = pwd;
    notifyListeners();
  }

  void getValues() {
    emailController.text = email ?? "";
  }

  bool get hasInput {
    return email != null && password != null;
  }

  showError() {
    String errorMessage = "";
    if (email == null || email!.isEmpty) {
      errorMessage = "${errorMessage}Please Enter your Email,  ";
    }
    if (password == null || password!.isEmpty) {
      errorMessage = "${errorMessage}Please Enter your Password,  ";
    }
    showCustomToast(errorMessage);
  }

  signIn() async {
    viewState = ViewState.idle;
    try {
      //TODO Implement signin
    } catch (e) {
      viewState = ViewState.idle;

      showCustomToast(e.toString());
    }
    notifyListeners();
  }
}
