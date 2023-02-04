import 'package:Smartpay/core/enum/view_state.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/toast.dart';
import 'package:flutter/material.dart';

class SetUserPinViewModel extends BaseViewModel {
  TextEditingController pinController = TextEditingController();

  String pin = "";
  bool isValidUserPin = false;

  setPin(String p) {
    pin = p;
    notifyListeners();
  }

  void validUserInfo() {
    isValidUserPin = pin.isNotEmpty;
    notifyListeners();
  }

  showError() {
    String errorMessage = "";
    if (pin.isEmpty || pin.isEmpty) {
      errorMessage = "${errorMessage}Wrong pin format,  ";
    }
    showCustomToast(errorMessage);
  }

  createPin() async {
    viewState = ViewState.idle;
    try {
      //TODO
    } catch (e) {
      viewState = ViewState.idle;

      showCustomToast(e.toString());
    }
    notifyListeners();
  }

}