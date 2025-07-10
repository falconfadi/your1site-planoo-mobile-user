import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:centro/core/constants/app_colors.dart';

Future<dynamic> customDatePicker(BuildContext context) async {
 return showDatePicker(
   context: context,
   initialDate: DateTime.now(),
   firstDate: DateTime(1900),
   lastDate: DateTime(DateTime.now().year, 12, 31),
   builder: (context, child) {
     return Theme(
       data: ThemeData(
         useMaterial3: false,
         datePickerTheme: DatePickerThemeData(
           headerBackgroundColor: AppColors.primaryColor,
           headerForegroundColor: AppColors.whiteColor,
           backgroundColor: AppColors.whiteColor,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(8.r),
           ),
         ),
         colorScheme: Theme.of(context).colorScheme.copyWith(
           primary: AppColors.primaryColor,
           onPrimary: AppColors.whiteColor,
         ),
         textButtonTheme: TextButtonThemeData(
           style: ButtonStyle(
             foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
               return AppColors.primaryColor;
             }),
           ),
         ),
       ),
       child: child!,
     );
   },
 );
}

Future<dynamic> selectDate(BuildContext context, dynamic date) async {
  var picked = await customDatePicker(context);

  if (picked != null && picked != date) {
    date = picked;
  }
  return date;
}

