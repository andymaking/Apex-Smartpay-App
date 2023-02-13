import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';

class SetUserPinViewModel extends BaseViewModel {
  final userRepository = getIt<UserRepository>();
  TextEditingController pinController = TextEditingController();

  ViewState _state = ViewState.idle;
  @override
  ViewState get viewState => _state;
  String errorMessage = "";
  String pin = "";
  String enteredPin = "";
  bool isValidUserPin = false;
  bool isValidUserInputPin = false;
  String confirmPin = "";
  String token = "";
  String firstName = "";

  setPin(String p) {
    pin = p;
    notifyListeners();
  }

  setEnteredPin(String p) {
    enteredPin = p;
    notifyListeners();
  }

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void validUserPin() {
    isValidUserPin = pin.isNotEmpty && pin.length == 5;
    notifyListeners();
  }

  void validUserInputPin() {
    isValidUserInputPin = enteredPin.isNotEmpty && enteredPin == confirmPin;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  savePrefs() async {
    sharedPreference.savePin(pin);
    sharedPreference.saveIsLoggedIn(true);
    notifyListeners();
  }

  getFirstName() async {
    firstName = await sharedPreference.getFirstName();
    notifyListeners();
  }
}