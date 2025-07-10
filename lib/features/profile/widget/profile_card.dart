import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  ProfileCard({
    required this.title,
    required this.icon,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 0.9.sw,
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 15.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                  children: [
                    SvgPicture.asset(icon,color: AppColors.blackColor),
                    SizedBox(width: 15.w),
                    Expanded(child: Text(title, style: AppTheme.labelLarge)),
                  ]
              ),
            ),
            const Icon(Icons.arrow_forward_ios,size: 20),
          ],
        ),
      ),
    );
  }
}
