import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/ui/shared_widgets/custom_row_widget.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/home/ui/categories_screen.dart';
import 'package:centro/features/home/widget/category/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesWidget extends StatelessWidget {

  CategoriesWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: CustomRowWidget(
            text: AppLocalization.of(context).translate("categories"),
            seeAllText: true,
            seeAllOnTap: () {
              Navigation.push(CategoriesScreen());
            },
          ),
        ),
        SizedBox(height: 15.h),
        SizedBox(
          width: 1.sw,
          height: 210.h,
          child: ListView.builder(
            clipBehavior: Clip.none,
            shrinkWrap: true,
            controller: ScrollController(),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 18.w),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CategoryWidget(),
              );
            },
          ),
        ),
      ],
    );
  }
}