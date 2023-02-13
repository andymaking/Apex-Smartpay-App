import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/ui/components/app_toolbar.dart';
import 'package:Smartpay/ui/components/button.dart';
import 'package:Smartpay/ui/components/custom_textfield.dart';
import 'package:Smartpay/ui/sign_in/sign_in_view_model.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../components/social_auth_button.dart';

final signInProvider = ChangeNotifierProvider.autoDispose(
        (ref) => getIt.get<SignInViewModel>());

final _validSignInProviderProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(signInProvider).isValidSignIn;
});

final validSignInProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validSignInProviderProvider);
});

final _signInStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(signInProvider).viewState;
});

final signInStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_signInStateProvider);
});

class SignInScreen extends StatefulHookWidget {
  const SignInScreen({super.key});

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusScopeNode _node = FocusScopeNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isValidUserInfo = useProvider(validSignInProvider);
    final userInfoViewState = useProvider(signInStateProvider);
    final model = context.read(signInProvider);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: FocusScope(
              node: _node,
              child: Form(
                key: _formKey,
                child: Stack(children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppToolbar(),
                      Sized24Container(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextView.getAppTextViewBold(AppStrings.hiThere),
                            const SizedBox(
                              height: 8,
                            ),
                            AppTextView.getAppTextView(AppStrings.welcomeBack),
                            const SizedBox(
                              height: 30,
                            ),
                            AppTextField(
                              hint: AppStrings.email,
                              onChanged: (v) {
                                model.setEmail(v);
                                model.validSignIn();
                              },
                              controller: model.emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            AppPasswordField(
                              hint: AppStrings.password,
                              onChanged: (val) {
                                model.setPassword(val);
                                model.validSignIn();
                              },
                              controller: model.passwordController,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                              onTap: (){
                               //TODO
                              },
                              child: AppTextView.getAppTextViewBold(
                                AppStrings.forgotPassword,
                                color: ThemeConfig.darkAccent,
                                size: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            userInfoViewState== ViewState.loading
                                ? Center(
                                child: CircularProgressIndicator(
                                  color: ThemeConfig.darkAccent,
                                ))
                                : AppButton(
                                onPressed: () => model.signIn(context),
                                title: AppStrings.signIn,
                                enabled: isValidUserInfo ? true : false),
                            const SizedBox(
                              height: 32,
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
                          ],
                        ),
                      )),
                      Sized24Container(
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: SocialAuthButtons(
                                icon: AppImages.googleLogo,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: SocialAuthButtons(
                                icon: AppImages.appleLogo,
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 124,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.signUp);
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppTextView.getAppTextView(
                                AppStrings.dontHaveAnAccount,
                                color: ThemeConfig.greyColor,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              AppTextView.getAppTextViewBold(
                                  AppStrings.signUp,
                                  color: ThemeConfig.darkAccent,
                                  size: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
        );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
