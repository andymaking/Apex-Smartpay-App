import 'package:Smartpay/core/enum/view_state.dart';
import 'package:Smartpay/core/services/storage-service.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/ui/base_view_model.dart';
import 'package:Smartpay/ui/components/toast.dart';
import 'package:flutter/material.dart';

class EmailVerificationViewModel extends BaseViewModel {
  StorageService storageService = getIt<StorageService>();
  TextEditingController otpController = TextEditingController();

  String? otp;

  setEmail(String otp) {
    otp = otp;
    notifyListeners();
  }

  setOtp(String otp) {
    otp = otp;
    notifyListeners();
  }

  void getValues() {
    otpController.text = otp ?? "";
  }

  bool get hasInput {
    return otp != null && otp?.length == 5;
  }

  showError() {
    String errorMessage = "";
    if (otp == null || otp!.isEmpty) {
      errorMessage = "${errorMessage}Please Enter the code sent to your email,  ";
    }
    showCustomToast(errorMessage);
  }

  confirmOtp() async {
    viewState = ViewState.idle;
    try {
      //TODO
    } catch (e) {
      viewState = ViewState.idle;

      showCustomToast(e.toString());
    }
    notifyListeners();
  }


  resendOTP(){

  }



}
