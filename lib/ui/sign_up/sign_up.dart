import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/ui/base_ui.dart';
import 'package:Smartpay/ui/components/app_toolbar.dart';
import 'package:Smartpay/ui/components/button.dart';
import 'package:Smartpay/ui/components/custom_textfield.dart';
import 'package:Smartpay/ui/sign_in/sign_in_view_model.dart';
import 'package:Smartpay/ui/sign_up/sign_up_view_model.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import '../components/social_auth_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
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
        body: BaseView<SignUpViewModel>(
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
                            Container(
                              child: Text.rich(
                                  TextSpan(
                                  text: AppStrings.createA,
                                  semanticsLabel: AppStrings.smart,
                                  style: TextStyle(
                                    fontFamily: AppStrings.fontFamily,
                                    color: ThemeConfig.darkColor,
                                    fontSize: AppFontSizes.headingFontSize24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: AppStrings.smartPay,
                                      semanticsLabel: AppStrings.smartPay,
                                      style: TextStyle(
                                        fontFamily: AppStrings.fontFamily,
                                        color: ThemeConfig.darkAccent,
                                        fontSize: AppFontSizes.headingFontSize24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ])),
                            ),
                            AppTextView.getAppTextViewBold(AppStrings.account),
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
                              height: 24,
                            ),
                            AppButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(AppRoutes.verifyOtp);
                                },
                                title: AppStrings.signUp,
                                enabled: model.emailController.text.isNotEmpty ? true : false),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.signIn);
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
                                      AppStrings.signIn,
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
