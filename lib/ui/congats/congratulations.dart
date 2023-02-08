import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/ui/components/button.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Congratulations extends StatefulHookWidget {

  const Congratulations( {Key? key,})
      : super(key: key);

  @override
  _CongratulationsState createState() => _CongratulationsState();
}

class _CongratulationsState extends State<Congratulations> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    final fn = ModalRoute.of(context)?.settings.arguments.toString();
    final firstName = fn.toString().split(" ");

    getName();

    print("NAME::: $name");
    print("FIRST_NAME::: $firstName");


    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child:
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/ic_thumbs_up.png",
                      width: 140, height: 134,),
                      const SizedBox(
                        height: 32,
                      ),
                      AppTextView.getAppTextViewBold(
                          "Congratulations, ${firstName.first}"),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36.0),
                        child: AppTextView.getAppTextView(AppStrings.youHaveCompleted,
                            textAlign: TextAlign.center,
                            weight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      AppButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.home,);
                          },
                          title: AppStrings.getStarted,
                          enabled: true
                      ),
                    ],
                  ),
                ),
              ),
        )
    );
  }

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name').toString();
  }

}
