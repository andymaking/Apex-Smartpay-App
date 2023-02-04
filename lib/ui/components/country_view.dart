import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/utils/app_text.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryView extends StatelessWidget {
  final String countryName;
  final String countryFlag;
  final String countryCode;
  final Function? onTap;
  final bool selected;
  final bool index;
  final ValueChanged<String>? onChanged;

  CountryView(
      {Key? key,
        required this.countryName,
        required this.countryFlag,
        required this.countryCode,
        this.onTap,
        required this.selected,
        this.onChanged,
        required this.index
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 56.h,
          decoration: BoxDecoration(
            color: index
                ? ThemeConfig.editTextGB.withOpacity(0.2)
                : null,
            borderRadius: const BorderRadius.all(
                Radius.circular(16.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: selected,
                  child: Row(
                    children: [
                      SvgPicture.asset(countryFlag),
                      const SizedBox(width: 16,),
                      AppTextView.getAppTextViewBold(
                        countryName,
                        textAlign: TextAlign.center,
                        size: AppFontSizes.titleFontSize16,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !selected,
                  child: Row(
                    children: [
                      AppTextView.getAppTextView(
                        "Select Country",
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Visibility(
                    child: selected
                        ? SvgPicture.asset(index ? AppImages.icCheck : "")
                        : SvgPicture.asset(AppImages.dropdownIcon)
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CountryClickView extends StatelessWidget {
  final String countryName;
  final String countryFlag;
  final String countryCode;
  final Function? onTap;
  final bool selected;
  final ValueChanged<String>? onChanged;

  CountryClickView(
      {Key? key,
        required this.countryName,
        required this.countryFlag,
        required this.countryCode,
        this.onTap,
        required this.selected,
        this.onChanged,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 56.h,
          decoration:  BoxDecoration(
            color: ThemeConfig.editTextGB.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
                Radius.circular(16.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              countryName.isNotEmpty
              ? Row(
                children: [
                  SvgPicture.asset(countryFlag),
                  const SizedBox(width: 16,),
                  AppTextView.getAppTextViewBold(
                    countryName,
                    textAlign: TextAlign.center,
                    size: AppFontSizes.titleFontSize16,
                  ),
                ],
              )
              : AppTextView.getAppTextView(
                "Select Country",
              ),
              Spacer(),
              SvgPicture.asset(AppImages.dropdownIcon)
            ],
          ),
        ),
      ],
    );
  }
}