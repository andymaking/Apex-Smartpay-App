import 'package:Smartpay/core/enum/view_state.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/ui/components/button.dart';
import 'package:Smartpay/utils/otp_timer_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:Smartpay/ui/base_ui.dart';
import 'package:Smartpay/ui/components/app_toolbar.dart';
import 'package:Smartpay/ui/verify_otp/email-verification.vm.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  final String accountType;

  const EmailVerification({Key? key, this.accountType = "Customer"})
      : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {

  @override
  void dispose() {
    //_node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BaseView<EmailVerificationViewModel>(
            builder: (context, model, child) => SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const AppToolbar(),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextView.getAppTextViewBold(
                                  AppStrings.verifyItsYou),
                              const SizedBox(
                                height: 12,
                              ),
                              AppTextView.getAppTextView(AppStrings.weSentACode,
                                  textAlign: TextAlign.left,
                                  weight: FontWeight.w500),
                              const SizedBox(
                                height: 32,
                              ),
                              PinCodeTextField(
                                controller: model.otpController,
                                //focusNode: _node,
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                    fontFamily: AppStrings.fontFamily,
                                    color: ThemeConfig.darkColor,
                                    fontSize: AppFontSizes.headingFontSize24,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                    height: 1.3),
                                length: 5,
                                obscureText: false,
                                obscuringCharacter: '*',
                                animationType: AnimationType.fade,
                                validator: (v) {
                                  if (v!.length < 5) {
                                    return "Please enter you five digit confirmation code.";
                                  } else {
                                    return null;
                                  }
                                },
                                pinTheme: PinTheme(
                                  borderWidth: 1,
                                  selectedColor: ThemeConfig.darkAccent,
                                  inactiveColor:
                                      ThemeConfig.greyColor.withOpacity(0.1),
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(12),
                                  fieldHeight: 56,
                                  fieldWidth: 56,
                                ),
                                cursorColor: ThemeConfig.darkColor,
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                textStyle:
                                    const TextStyle(fontSize: 20, height: 1.6),
                                enableActiveFill: false,
                                keyboardType: TextInputType.number,
                                onCompleted: (v) {},
                                onChanged: (value) {
                                  model.setOtp(value);
                                  print(value);
                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  return true;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              if (model.viewState == ViewState.idle)
                                Center(
                                  child: TextButton(
                                    onPressed: () => model.resendOTP(),
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CountDownTimer(
                                            secondsRemaining: 30,
                                            whenTimeExpires: () {
                                              print("done");
                                            },
                                            countDownTimerStyle: TextStyle(
                                                fontFamily:
                                                    AppStrings.fontFamily,
                                                color: ThemeConfig.greyColor,
                                                fontSize: AppFontSizes
                                                    .titleFontSize16,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                decoration: TextDecoration.none,
                                                height: 1.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (model.viewState == ViewState.loading)
                                const Center(
                                  child: CircularProgressIndicator(),
                                )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Sized24Container(
                          child: AppButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(AppRoutes.getUserInfo);
                              },
                              title: AppStrings.confirm,
                              enabled: model.otpController.text.length == 5
                                  ? true
                                  : false),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
