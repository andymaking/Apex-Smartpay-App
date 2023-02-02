import 'package:flutter/material.dart';

class CustomCardBackground extends StatelessWidget {
  final Widget child;
  final Color? primaryColor;
  const CustomCardBackground({
    Key? key,required this.child, this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
        padding: EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child:child
    );
  }
}