import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/domain/model/login_user.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/custom_dialog.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';

class EnterUserPinViewModel extends BaseViewModel {
  final userRepository = getIt<UserRepository>();
  TextEditingController pinController = TextEditingController();

  ViewState _state = ViewState.idle;
  @override
  ViewState get viewState => _state;
  String errorMessage = "";
  String savedPin = "";
  String password = "";
  String email = "";
  String enteredPin = "";
  bool isValidUserInputPin = false;
  String confirmPin = "";

  setEnteredPin(String p) {
    enteredPin = p;
    notifyListeners();
  }

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void getSavedPinEmailAndPassword() async {
    savedPin = await sharedPreference.getPin();
    email = await sharedPreference.getEmail();
    password = await sharedPreference.getPassword();
    notifyListeners();
  }

  void validUserInputPin() {
    isValidUserInputPin = enteredPin.isNotEmpty && enteredPin == savedPin;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  Future<LoginUserResponse?> signIn(BuildContext context) async {
    try {
      setViewState(ViewState.loading);
      var response = await userRepository.login(email, password);
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