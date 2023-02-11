import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/ui/components/app_toolbar.dart';
import 'package:Smartpay/ui/components/button.dart';
import 'package:Smartpay/ui/components/custom_dialog.dart';
import 'package:Smartpay/ui/enter_pin/enter_pin_view_model.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

final enterUserPinProvider = ChangeNotifierProvider.autoDispose(
        (ref) => getIt.get<EnterUserPinViewModel>());

final _validValidUserPinProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(enterUserPinProvider).isValidUserInputPin;
});

final validValidUserPinProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validValidUserPinProvider);
});

final _userPinStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(enterUserPinProvider).viewState;
});

final userPinStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_userPinStateProvider);
});
class EnterPinScreen extends StatefulHookWidget {

  const EnterPinScreen( {Key? key,})
      : super(key: key);

  @override
  _EnterPinScreenState createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getUserPin();
    final model = context.read(enterUserPinProvider);
    model.getSavedPinEmailAndPassword();
    final isValidUserPin = useProvider(validValidUserPinProvider);
    final userPinViewState = useProvider(userPinStateProvider);


    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
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
                      const SizedBox(
                        height: 12,
                      ),
                      AppTextView.getAppTextViewBold(
                          "Welcome back!"),
                      const SizedBox(
                        height: 12,
                      ),
                      AppTextView.getAppTextView("Enter Pin to proceed",
                          textAlign: TextAlign.left,
                          weight: FontWeight.w500),
                      const SizedBox(
                        height: 32,
                      ),
                      PinCodeTextField(
                        controller: model.pinController,
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
                        obscureText: true,
                        obscuringCharacter: '●',
                        animationType: AnimationType.fade,
                        validator: (v) {},
                        pinTheme: PinTheme(
                          borderWidth: 1,
                          selectedColor: ThemeConfig.darkAccent,
                          inactiveColor:
                          ThemeConfig.darkAccent,
                          //borderRadius: BorderRadius.circular(12),
                          fieldHeight: 56,
                          fieldWidth: 56,
                        ),
                        cursorColor: ThemeConfig.darkAccent,
                        animationDuration:
                        const Duration(milliseconds: 300),
                        textStyle:
                        const TextStyle(fontSize: 16, height: 1.6),
                        enableActiveFill: false,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          if (isValidUserPin){
                            model.signIn(context);
                          } else {
                            showTopModalSheet<String>(
                                context: context,
                                child: ShowDialog(
                                  title: "Incorrect pin, kindly try again",
                                  isError: true,
                                  onPressed: () {},
                                ));
                          }
                        },
                        onChanged: (value) {
                          model.setEnteredPin(value);
                          model.validUserInputPin();
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
                            onPressed: () {},
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

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
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        height: 1,
                        color: ThemeConfig.btnBorderColor,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    AppTextView.getAppTextView("OR",
                        color: ThemeConfig.greyColor),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Divider(
                        height: 1,
                        //thickness: 4,
                        color: ThemeConfig.btnBorderColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const SizedBox(
                  height: 30,
                ),
                Sized24Container(
                  child: AppButton(
                      onPressed: () {
                        navigationService.navigateToReplace(AppRoutes.signIn);
                      },
                      title: "Go to Login",
                      enabled: true),
                ),

              ],
            ),
          ),
        )
    );
  }

}
