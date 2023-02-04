import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/core/table_constants.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/data/services/storage-service.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/toast.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';

class SetUserPinViewModel extends BaseViewModel {
  final userRepository = getIt<UserRepository>();
  //final store = getIt<StorageService>();
  TextEditingController pinController = TextEditingController();

  ViewState _state = ViewState.idle;
  @override
  ViewState get viewState => _state;
  String errorMessage = "";
  String pin = "";
  bool isValidUserPin = false;

  setPin(String p) {
    pin = p;
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

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  createPin() async {
    try {
      setViewState(ViewState.loading);
      storageService.storeItem(key: DbTable.PIN_TABLE_NAME, value: pin);
      setViewState(ViewState.success);
      print("Pin set successful::: $pin");
    } catch (e) {
      viewState = ViewState.idle;
      showCustomToast(e.toString());
    }
    notifyListeners();
  }

}