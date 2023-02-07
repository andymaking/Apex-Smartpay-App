import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/core/table_constants.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/data/services/storage-service.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/custom_dialog.dart';
import 'package:Smartpay/ui/components/toast.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    isValidUserPin = pin.isNotEmpty;
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

  createPin() async {
    try {
      setViewState(ViewState.loading);
      setViewState(ViewState.success);
      setUserPin(pin);
    } catch (e) {
      viewState = ViewState.idle;
      showCustomToast(e.toString());
    }
    notifyListeners();
  }

  Future<String?> signIn(String email,String password,
      BuildContext context) async {
    try {
      setViewState(ViewState.loading);
      var response = await userRepository.login(email, password);
      setViewState(ViewState.success);

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


  setUserPin(val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userAuthPin', val);
    notifyListeners();
  }

}