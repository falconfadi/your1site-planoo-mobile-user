import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/custom_rating_bar.dart';
import 'package:centro/core/ui/shared_widgets/custom_row_widget.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/home/ui/court_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourtsScreen extends StatefulWidget {

  CourtsScreen({super.key});

  @override
  State<CourtsScreen> createState() => _CourtsScreenState();
}

class _CourtsScreenState extends State<CourtsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomHeader(title: '', isNavBar: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: CustomRowWidget(
                text: AppLocalization.of(context).translate("top_courts"),
                seeAllText: false,
              ),
            ),
            SizedBox(height: 15.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 15.w),
                  child: InkWell (
                      onTap: () => Navigation.push(CourtDetailsScreen()),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CachedImage(
                                borderRadius: 10.r,
                                imageUrl: "",
                                height: 120.w,
                                width: 160.w,
                                fit: BoxFit.cover,
                                withCorner: true,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h),
                                    SizedBox(
                                      child: Text(
                                        "Green Valley Basketball Court",
                                        style: AppTheme.titleMedium.copyWith(fontSize: 14),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      "Basketball",
                                      style: AppTheme.bodySmall.copyWith(color: AppColors.primaryColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 5.h),
                                    CustomRatingBar(rate: 2.5),
                                    SizedBox(height: 5.h),
                                  ]
                              ),
                            ),
                          ]
                      )
                  ),
                );
              },
            ),
            SizedBox(height: 50.h),
          ],
        )
      ),
    );
  }
}
