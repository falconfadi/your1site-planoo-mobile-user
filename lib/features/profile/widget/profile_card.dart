import 'package:centro/core/classes/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';

class ProfileCard extends StatelessWidget {

  final String title;
  final VoidCallback onTap;

  const ProfileCard({super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shadowColor: AppColors.lightGrayColor.withOpacity(0.3),
        elevation: 5,
        child: Container(
          width: 1.sw,
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(AppLocalization.of(context).translate(title),style: AppTheme.bodyLarge.copyWith(fontSize: 20.sp)),
              )),
              SizedBox(width: 5.w),
              Icon(Icons.arrow_forward_ios_outlined,size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}