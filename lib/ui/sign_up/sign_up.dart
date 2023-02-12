import 'package:Smartpay/data/core/enum/view_state.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/ui/components/app_toolbar.dart';
import 'package:Smartpay/ui/components/button.dart';
import 'package:Smartpay/ui/components/custom_dialog.dart';
import 'package:Smartpay/ui/components/custom_textfield.dart';
import 'package:Smartpay/ui/components/social_auth_button.dart';
import 'package:Smartpay/ui/sign_up/sign_up_view_model.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getEmailTokenProvider =
    ChangeNotifierProvider.autoDispose((ref) => getIt.get<SignUpViewModel>());

final _validedEmailTokenProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(getEmailTokenProvider).isValidEmail;
});

final validedEmailTokenProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validedEmailTokenProvider);
});

final _getEmailTokenStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(getEmailTokenProvider).viewState;
});

final getEmailTokenStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_getEmailTokenStateProvider);
});

class SignUpScreen extends StatefulHookWidget {
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
    //final email = ModalRoute.of(context)!.settings.arguments as String;
    final isValidGetEmailToken = useProvider(validedEmailTokenProvider);
    final getEmailTokenViewState = useProvider(getEmailTokenStateProvider);
    final model = context.read(getEmailTokenProvider);
    //model.email = email;

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
                        Container(
                          child: Text.rich(TextSpan(
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
                          onChanged: (v) {
                            print("email ::${model.email}");
                            model.setEmail(v);
                            model.validateEmailInput();
                          },
                          controller: model.emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        getEmailTokenViewState == ViewState.loading
                            ? Center(
                                child: CircularProgressIndicator(
                                color: ThemeConfig.darkAccent,
                              ))
                            : AppButton(
                                onPressed: () {
                                  model.getEmailToken(context);
                                },
                                title: AppStrings.signUp,
                                enabled: isValidGetEmailToken ? true : false),
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
                      Navigator.of(context).pushNamed(AppRoutes.signIn);
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
                          AppTextView.getAppTextViewBold(AppStrings.signIn,
                              color: ThemeConfig.darkAccent, size: 16),
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
