import 'package:Smartpay/theme/theme_config.dart';
import 'package:flutter/material.dart';

Container buildDot(int currentIndex, int index){
  return Container(

    height: 6,
    width: currentIndex == index ? 30 : 6,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: currentIndex == index ? ThemeConfig.darkColor : ThemeConfig.editTextGB,
    ),
  );
}