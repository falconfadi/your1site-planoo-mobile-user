import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class CustomButton extends StatelessWidget {
  double? height;
  double? width;
  String? buttonName;
  TextStyle? textStyle;
  String? icon;
  Color? iconColor;
  Color? backgroundColor;
  Color? borderSideColor;
  double? borderRadius;
  VoidCallback? function;

  CustomButton({super.key,
    this.height,
    this.width,
    this.buttonName,
    this.textStyle,
    this.icon,
    this.iconColor,
    required this.backgroundColor,
    this.borderSideColor,
    required this.borderRadius,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(4)),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(width ?? double.infinity, height ?? 60.h),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor!),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            side: BorderSide(color: borderSideColor ?? Colors.transparent, width: 0.5),
          ),
        ),
      ),
      onPressed: function,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            SvgPicture.asset(icon!, color: iconColor ?? AppColors.primaryColor),
          SizedBox(width: icon != null ? 5.w : 0),
          Text(
            buttonName ?? "",
            textAlign: TextAlign.center,
            style: textStyle ?? AppTheme.titleSmall.copyWith(color: AppColors.whiteColor),
          ),
        ],
      )
    );
  }
}