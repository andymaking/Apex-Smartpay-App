import 'package:Smartpay/routes/routes.dart';
import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/ui/components/button.dart';
import 'package:Smartpay/ui/components/onboarding_dash_and_dot.dart';
import 'package:Smartpay/ui/components/onboarding_slider.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  List<SliderModel> slides = [];
  int currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    slides = getSlides();
  }

  @override
  void dispose(){
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: ThemeConfig.lightPrimary,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
              children:[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        // height: 56,
                        margin: const EdgeInsets.only(top: 40,),
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: (){
                            sharedPreference.saveOnBoardingCompleted(true);
                            navigationService.navigateToReplace(AppRoutes.signIn);
                          },
                          child: Sized24Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: AppTextView.getAppTextViewBold(
                                  "Skip",
                                  size: AppFontSizes.titleFontSize16,
                                  color: ThemeConfig.lightAccent,
                                  textAlign :TextAlign.right
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 565,
                        child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (value){
                              setState(() {
                                currentIndex = value;
                              });
                            },
                            itemCount: slides.length,
                            itemBuilder: (context, index){
                              return OnBoardingSlider(
                                image: slides[index].getImage(),
                                title: slides[index].getTitle(),
                                description: slides[index].getDescription(),
                              );
                            }
                        ),
                      ),
                      const SizedBox(height: 14,),
                      // Container created for dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(slides.length, (index) => buildDot(currentIndex,index),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child:  Container(
                    height: 56,
                    margin: const EdgeInsets.only(top: 34, bottom: 54, left: 24, right: 24),
                    //width: double.infinity,
                    child: AppButton(
                      title: 'Get Started',
                      enabled: true,
                      onPressed: () async {
                        sharedPreference.saveOnBoardingCompleted(true);
                        navigationService.navigateToReplace(AppRoutes.signIn);
                      },
                    ),
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}