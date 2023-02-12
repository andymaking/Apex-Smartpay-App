import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/data/services/storage-service.dart';
import 'package:Smartpay/domain/model/verify_email_token.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/custom_dialog.dart';
import 'package:flutter/material.dart';

class EmailVerificationViewModel extends BaseViewModel {
  final userRepository = getIt<UserRepository>();
  final store = getIt<StorageService>();
  TextEditingController otpController = TextEditingController();

  ViewState _state = ViewState.idle;
  @override
  ViewState get viewState => _state;
  String errorMessage = "";
  bool isValidToken = false;
  String token = "";
  String email = "";

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  setToken(String s) {
    token = s;
    notifyListeners();
  }

  void validateOtpInput() {
    isValidToken = token.length == 5;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  Future<VerifyEmailTokenResponse?> verifyEmailToken(BuildContext context) async {
    try {
      setViewState(ViewState.loading);
      var response = await userRepository.verifyEmailToken(email, token);
      setViewState(ViewState.success);
      navigationService.navigateTo(AppRoutes.getUserInfo, argument: email);
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


  resendOTP(){

  }

}
