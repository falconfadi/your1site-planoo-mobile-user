import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/custom_rating_bar.dart';
import 'package:centro/core/ui/shared_widgets/custom_row_widget.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/home/ui/trainer_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrainersScreen extends StatefulWidget {


  TrainersScreen({super.key});

  @override
  State<TrainersScreen> createState() => _TrainersScreenState();
}

class _TrainersScreenState extends State<TrainersScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomHeader(title: '', isNavBar: false,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: CustomRowWidget(
                text: AppLocalization.of(context).translate("top_trainers"),
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
                      onTap: () => Navigation.push(TrainerDetailsScreen()),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedImage(
                              borderRadius: 10.r,
                              imageUrl: "",
                              height: 100.w,
                              width: 120.w,
                              fit: BoxFit.cover,
                              withCorner: true,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h),
                                    SizedBox(
                                      child: Text(
                                        "Jason Brooks",
                                        style: AppTheme.titleMedium.copyWith(fontSize: 14),
                                        maxLines: 1,
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
                                    CustomRatingBar(rate: 4),
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
