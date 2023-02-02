import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/ui/components/button.dart';
import 'package:Smartpay/utils/app_fonts.dart';
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
        //backgroundColor: Pallet.colorWhite,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
              children:[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 540,
                        child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (value){
                              setState(() {
                                currentIndex = value;
                              });
                            },
                            itemCount: slides.length,
                            itemBuilder: (context, index){
                              return Slider(
                                image: slides[index].getImage(),
                                title: slides[index].getTitle(),
                                description: slides[index].getDescription(),
                              );
                            }
                        ),
                      ),
                      const SizedBox(height: 18,),
                      // Container created for dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(slides.length, (index) => buildDot(index, context),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 40,),
                        width: double.infinity,
                        child: Sized24Container(
                          child: AppButton(
                            title: 'Get Started',
                            enabled: true,
                            onPressed: () async {
                              //TODO Add navigation route
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
  Container buildDot(int index, BuildContext context){
    return Container(
      height: 6,
      width: currentIndex == index ? 20 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? ThemeConfig.darkColor : ThemeConfig.lightGreyColor,
      ),
    );
  }
}

class Slider extends StatelessWidget {
  String? image,title,description;

  Slider({required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage(image!),
          fit: BoxFit.fitWidth,),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16, ),
          child: AppFontsStyle.getAppTextViewBold(
              title!, textAlign :TextAlign.center
          )
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16),
          child: AppFontsStyle.getAppTextView(description!, size: 14)
        ),
        //
      ],
    );

  }
}

class SliderModel{
  String? image;
  String? title;
  String? description;

  // Constructor for variables
  SliderModel({this.title, this.description, this.image});

  void setImage(String getImage){
    image = getImage;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }
  void setDescription(String getDescription){
    description = getDescription;
  }

  String? getImage(){
    return image;
  }

  String?  getTitle(){
    return title;
  }
  String? getDescription(){
    return description;
  }
}

// List created
List<SliderModel> getSlides(){
  List<SliderModel> slides = [];
  SliderModel sliderModel = new SliderModel();

  // Item 1
  sliderModel.setImage(AppImages.slide1Image);
  sliderModel.setTitle(AppString.slide1Title);
  sliderModel.setDescription(AppString.slide1Description);
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  // Item 2
  sliderModel.setImage(AppImages.slide2Image);
  sliderModel.setTitle(AppString.slide2Title);
  sliderModel.setDescription(AppString.slide2Description);
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  // Item 3
  sliderModel.setImage(AppImages.slide3Image);
  sliderModel.setTitle(AppString.slide3Title);
  sliderModel.setDescription(AppString.slide3Description);
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  return slides;
}