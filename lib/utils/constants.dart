
import 'package:flutter/material.dart';

class Constants {
  //App related strings
  static String appName = 'Smartpay';
}

class Sized16Container extends StatelessWidget {
  final Widget? child;
  final Decoration? decoration;

  const Sized16Container({super.key, this.child, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}