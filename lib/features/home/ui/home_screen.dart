import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/features/home/widget/category/categories_widget.dart';
import 'package:centro/features/home/widget/court/courts_widget.dart';
import 'package:centro/features/home/widget/home_header.dart';
import 'package:centro/features/home/widget/trainer/trainers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: HomeHeader(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            CourtsWidget(),
            SizedBox(height: 10.h),
            TrainersWidget(),
            SizedBox(height: 10.h),
            CategoriesWidget(),
            SizedBox(height: 10.h),
          ],
        ),
      )
    );
  }
}
