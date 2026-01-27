import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CustomInfoWidget extends StatelessWidget {

  final String title;
  final String subTitle;

  const CustomInfoWidget({super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(title,style: AppTheme.bodyLarge.copyWith(fontSize: 18.sp))),
        SizedBox(width: 10.w),
        Expanded(child: Text(subTitle,style: AppTheme.labelMedium.copyWith(color: AppColors.purpleColor))),
      ],
    );
  }
}