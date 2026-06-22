import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/custom_rating_bar.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentItemWidget extends StatelessWidget {

  final VoidCallback onTap;
  final String imageUrl;
  final String title;
  final String category;
  final String description;
  final String price;
  final double rating;

  const AppointmentItemWidget({
    super.key,
    required this.onTap,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.description,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColors.whiteColor,
        elevation: 3,
        shadowColor: AppColors.gray2Color,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
          margin: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImage(
                width: 1.sw,
                height: 180.h,
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                borderRadius: 10.r,
              ),
              SizedBox(height: 10.h),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(title,
                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                  style: AppTheme.bodyLarge.copyWith(fontSize: 20.sp)),
                            ),
                            SizedBox(width: 10.w),
                            Text(price, style: AppTheme.bodyLarge.copyWith(color: AppColors.primaryColor, fontSize: 20.sp)),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(category,
                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                  style: AppTheme.titleMedium.copyWith(color: AppColors.mediumGrayColor)
                              ),
                            ),
                            SizedBox(width: 5.w),
                            CustomRatingBar(rate: rating,
                                size: isTablet ? 18.sp : 18)
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Text(description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.labelMedium.copyWith(color: AppColors.darkGrayColor),
                        )
                      ]
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}