import 'package:Smartpay/theme/theme_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// class SocialAuthButtons extends StatelessWidget {
//   final String icon;
//   final VoidCallback onPressed;
//   const SocialAuthButtons({
//     Key? key, required this.onPressed, required this.icon
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width / 2 - 40,
//       //height: 40,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       //width: double.infinity,
//       decoration: BoxDecoration(
//         //color: ThemeConfig.greyColor.withOpacity(0.1),
//         border: Border.all(
//           color: ThemeConfig.btnBorderColor,
//         ),
//         borderRadius: const BorderRadius.all(
//             Radius.circular(16.0)), // set rounded corner radius
//       ),
//       child: TextButton(
//         child: SizedBox(
//           width: 25,
//             height: 25,
//             child: SvgPicture.asset(
//                 icon,
//             )),
//         onPressed: () {onPressed();},
//       ),
//     );
//   }
// }

class SocialAuthButtons extends StatelessWidget {
  Function()? onPressed;
  final String icon;

  SocialAuthButtons(
      {Key? key,
        required this.onPressed,
        required this.icon,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(
              vertical: 2.5,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ThemeConfig.btnBorderColor,
            ),
          ),
          child: Center(
              child: SvgPicture.asset(
                icon,
              )
          ),
        ));
  }
}