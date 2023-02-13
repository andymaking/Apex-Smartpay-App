import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/ui/components/app_toolbar.dart';
import 'package:Smartpay/ui/components/button.dart';
import 'package:Smartpay/ui/set_pin/set_pin_view_model.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

final setUserPinProvider = ChangeNotifierProvider.autoDispose(
        (ref) => getIt.get<SetUserPinViewModel>());

final _validValidUserPinProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(setUserPinProvider).isValidUserPin;
});

final validValidUserPinProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validValidUserPinProvider);
});

final _userPinStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(setUserPinProvider).viewState;
});

final userPinStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_userPinStateProvider);
});
class SetUserPinScreen extends StatefulHookWidget {

  const SetUserPinScreen( {Key? key,})
      : super(key: key);

  @override
  _SetPinScreenState createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetUserPinScreen> {

  @override
  void dispose() {
    //_node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isValidUserPin = useProvider(validValidUserPinProvider);
    final userPinViewState = useProvider(userPinStateProvider);
    final model = context.read(setUserPinProvider);


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
                  padding: const EdgeInsets.only(left: 24.0, right: 24, top: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextView.getAppTextViewBold(
                          AppStrings.setYourPinCode),
                      const SizedBox(
                        height: 12,
                      ),
                      AppTextView.getAppTextView(AppStrings.weUseStateOfTheArt,
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
                        validator: (v) {
                          // if (v!.length < 5) {
                          //   return "Please enter you five digit pin.";
                          // } else {
                          //   return null;
                          // }
                        },
                        pinTheme: PinTheme(
                          borderWidth: 1,
                          selectedColor: ThemeConfig.darkAccent,
                          inactiveColor:
                          ThemeConfig.darkAccent,
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
                        onCompleted: (v) {},
                        onChanged: (value) {
                          model.setPin(value);
                          model.validUserPin();
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
                                children: const [],
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
                        model.savePrefs();
                        model.getFirstName();
                        navigationService.navigateToReplace(AppRoutes.congrats);
                      },
                      title: AppStrings.createPin,
                      enabled: isValidUserPin
                          ? true
                          : false),
                ),
              ],
            ),
          ),
        )
    );
  }
}
