import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpenDaysWidget extends StatefulWidget {

  bool isOpen;
  dynamic openDaysList;

  OpenDaysWidget({required this.isOpen,required this.openDaysList});

  @override
  State<OpenDaysWidget> createState() => _OpenDaysWidgetState();
}

class _OpenDaysWidgetState extends State<OpenDaysWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
              color: AppColors.gray2Color,
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0,3)
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                widget.isOpen = !widget.isOpen;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.access_time_outlined,color: AppColors.mediumGrayColor,size: 20),
                SizedBox(width: 5.w),
                Text(AppLocalization.of(context).translate("open_now"),
                  style: AppTheme.labelMedium.copyWith(color: AppColors.mediumGrayColor),
                ),
                Icon(Icons.keyboard_arrow_right_outlined,color: AppColors.mediumGrayColor),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: widget.isOpen
                  ? Text(
                widget.openDaysList.join(' - '),
                style: AppTheme.labelSmall.copyWith(
                  color: AppColors.darkGreenColor
                )
              ) : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}