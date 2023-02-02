import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/ui/base_ui.dart';
import 'package:Smartpay/ui/components/app_toolbar.dart';
import 'package:Smartpay/ui/components/button.dart';
import 'package:Smartpay/ui/components/custom_textfield.dart';
import 'package:Smartpay/ui/sign_in/sign_in_view_model.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import '../components/social_auth_button.dart';

class SignInScreen extends StatefulWidget {
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BaseView<SignInViewModel>(
          onModelReady: (model) {
            model.getValues();
          },
          builder: (context, model, child) => SafeArea(
            child: FocusScope(
              node: _node,
              child: Form(
                key: _formKey,
                child: ListView(children: <Widget>[
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
                              onChanged: (v) => model.setEmail(v),
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
                              },
                              controller: model.passwordController,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            AppTextView.getAppTextViewBold(
                              AppStrings.forgotPassword,
                              color: ThemeConfig.darkAccent,
                              size: 16,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppButton(
                                onPressed: () {
                                  //TODO
                                },
                                title: AppStrings.signIn,
                                enabled: true),
                            const SizedBox(
                              height: 32,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    height: 1,
                                    color: ThemeConfig.darkColor,
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
                                    color: ThemeConfig.darkColor,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.of(context)
                              //     .pushReplacementNamed(AppRoutes.signUp);
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
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
