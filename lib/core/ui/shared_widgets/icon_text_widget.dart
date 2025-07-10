import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconTextWidget extends StatelessWidget {

  final String icon;
  final double? iconSize;
  final String text;
  final TextStyle? textStyle;
  final Color? iconColor;

  IconTextWidget({
    required this.icon,
    this.iconSize,
    required this.text,
    this.textStyle,
    this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon,width: iconSize,color: iconColor ?? AppColors.mediumGrayColor),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(text,style: textStyle ??
          AppTheme.titleLarge.copyWith(fontSize: 14,color: AppColors.darkGrayColor)),
        )
      ],
    );
  }
}
