import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/home/ui/trainer_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrainerWidget extends StatelessWidget {

  double? width;

  TrainerWidget({super.key,this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigation.push(TrainerDetailsScreen()),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImage(
                borderRadius: 10.r,
                imageUrl: "",
                height: 120.w,
                width: width ?? 120.w,
                fit: BoxFit.cover,
                withCorner: true,
              ),
              Container(
                width: width ?? 120.w,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      SizedBox(height: 10.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.r),
                          color: AppColors.gray2Color,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Basketball",
                            style: AppTheme.labelSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ]),
              ),
            ])
    );
  }
}

