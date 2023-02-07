import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';

class OnBoardingSlider extends StatelessWidget {
  String? image, title, description;

  OnBoardingSlider(
      {super.key,
      required this.image,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 10),
            child: SizedBox(
              child: Image(
                image: AssetImage(image!),
                //fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 4.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ThemeConfig.lightPrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 84.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AppTextView.getAppTextViewBold(title!,
                  textAlign: TextAlign.center),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextView.getAppTextView(description!, size: 14),
            ),
          )
        ],
      ),
    );
  }
}

class SliderModel {
  String? image;
  String? title;
  String? description;

  // Constructor for variables
  SliderModel({this.title, this.description, this.image});

  void setImage(String getImage) {
    image = getImage;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDescription(String getDescription) {
    description = getDescription;
  }

  String? getImage() {
    return image;
  }

  String? getTitle() {
    return title;
  }

  String? getDescription() {
    return description;
  }
}

// List created
List<SliderModel> getSlides() {
  List<SliderModel> slides = [];
  SliderModel sliderModel = new SliderModel();

  // Item 1
  sliderModel.setImage(AppImages.oBoardingSlice1);
  sliderModel.setTitle(AppStrings.onBoardingTitle1);
  sliderModel.setDescription(AppStrings.onBoardingDescription1);
  slides.add(sliderModel);
  sliderModel = new SliderModel();

  // Item 2
  sliderModel.setImage(AppImages.oBoardingSlice2);
  sliderModel.setTitle(AppStrings.onBoardingTitle2);
  sliderModel.setDescription(AppStrings.onBoardingDescription2);
  slides.add(sliderModel);
  sliderModel = new SliderModel();

  return slides;
}
