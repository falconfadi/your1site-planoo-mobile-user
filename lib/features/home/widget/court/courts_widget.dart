import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/ui/shared_widgets/custom_row_widget.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/home/ui/courts_screen.dart';
import 'package:centro/features/home/widget/court/court_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourtsWidget extends StatelessWidget {

  const CourtsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: CustomRowWidget(
            text: AppLocalization.of(context).translate("top_courts"),
            seeAllText: true,
            seeAllOnTap: () {
              Navigation.push(CourtsScreen());
            },
          ),
        ),
        SizedBox(height: 15.h),
        SizedBox(
            height: 322.h,
            child: ListView.builder(
              clipBehavior: Clip.none,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 18.w),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: CourtWidget()
                );
              },
            )
        ),
      ],
    );
  }
}

