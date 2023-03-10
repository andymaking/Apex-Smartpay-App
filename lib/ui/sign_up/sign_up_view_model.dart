import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/domain/model/get_email_token.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/custom_dialog.dart';
import 'package:Smartpay/ui/components/toast.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:Smartpay/utils/validations.dart';
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
    isValidEmail = isValidEmails(email);
    notifyListeners();
  }

  /// get user email token
  Future<GetEmailTokenResponse?> getEmailToken(BuildContext context) async {
    try {
      setViewState(ViewState.loading);
      var response = await userRepository.getEmailToken(email);
      setViewState(ViewState.success);
      navigationService.navigateTo(AppRoutes.verifyOtp, argument: {email, response?.data?.token});
      sharedPreference.saveEmail(email);
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
