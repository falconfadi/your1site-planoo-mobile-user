import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/custom_rating_bar.dart';
import 'package:centro/core/ui/shared_widgets/expandable_text_widget.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/utils/validators/convert_date_time.dart';
import 'package:centro/features/category/data/model/review_model.dart';
import 'package:flutter/material.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsSheet extends StatefulWidget {

  List<ReviewInfoModel>? reviews;

  ReviewsSheet({super.key,this.reviews});

  @override
  State<ReviewsSheet> createState() => _ReviewsSheetState();
}

class _ReviewsSheetState extends State<ReviewsSheet> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.reviews!.length,
          itemBuilder: (context,index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
              decoration: BoxDecoration(
                color: AppColors.extraLightGrayColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedImage(
                        width: 45.w,
                        height: 45.w,
                        imageUrl: widget.reviews![index].customer!.profileImage == null ? "" :  widget.reviews![index].customer!.profileImage!.url!,
                        fit: BoxFit.cover,
                        borderColor: AppColors.grayColor,
                        borderRadius: 40.r,
                        borderWidth: 1,
                        errorForUser: true,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(widget.reviews![index].customer!.name!,
                                      style: AppTheme.bodyLarge.copyWith(fontSize: 18.sp)
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Text(convertDate(date: widget.reviews![index].createdAt!),
                                    style: AppTheme.labelSmall.copyWith(color: AppColors.mediumGrayColor)
                                ),
                              ],
                            ),
                            CustomRatingBar(rate: widget.reviews![index].rate!.toDouble(),size: 15.sp),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: widget.reviews![index].content == null ? 0 : 10.h),
                  widget.reviews![index].content == null ? Center() :
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ExpandableTextWidget(
                        text: widget.reviews![index].content!,
                        style: AppTheme.labelMedium.copyWith(color: AppColors.darkGrayColor)
                    ),
                  )
                ],
              ),
            );
          },
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}

