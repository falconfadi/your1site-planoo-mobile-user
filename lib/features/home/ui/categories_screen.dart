import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/custom_row_widget.dart';
import 'package:centro/features/home/widget/category/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatefulWidget {

  CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoriesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomHeader(title: '', isNavBar: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: CustomRowWidget(
                text: AppLocalization.of(context).translate("categories"),
                seeAllText: false,
              ),
            ),
            SizedBox(height: 20.h),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [1,2,3,4,5,6,7,8,9,10].map((e) {
                return CategoryWidget();
              }).toList(),
            ),
            SizedBox(height: 50.h),
          ],
        )
      ),
    );
  }
}
