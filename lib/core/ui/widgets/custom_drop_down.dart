import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';

class CustomDropDown extends StatelessWidget  {

  final double width;
  final double height;
  final String text;
  final dynamic value;
  final List<DropdownMenuItem<dynamic>>? items;
  final void Function(dynamic)? onChanged;


  CustomDropDown({
    required this.width,
    required this.height,
    required this.text,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.blackColor,width: 0.5)
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15.w,right: 10.w),
          child: DropdownButton(
              dropdownColor: AppColors.whiteColor,
              isExpanded: true,
              hint: Text(text, style: AppTheme.titleLarge.copyWith(fontSize: 17,color: AppColors.lightGrayColor)),
              icon: const Icon(Icons.keyboard_arrow_down_outlined,size: 22,color: AppColors.lightGrayColor),
              iconEnabledColor: AppColors.lightGrayColor,
              value: value,
              items: items,
              underline: Container(),
              onChanged: onChanged
          ),
        )
    );
  }

}
