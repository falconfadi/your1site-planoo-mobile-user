import 'package:centro/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRatingBar extends StatelessWidget {
  final double rate;
  final double? size;
  final IconData? iconData;
  final double? itemPadding;
  final ValueChanged<double>? onChanged;

  const CustomRatingBar({
    super.key,
    required this.rate,
    this.size,
    this.iconData,
    this.itemPadding,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rate,
      minRating: 1,
      glowColor: AppColors.whiteColor,
      ignoreGestures: onChanged == null,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: size ?? 25.w,
      unratedColor: AppColors.grayColor,
      itemPadding: EdgeInsets.symmetric(horizontal: itemPadding ?? 1.w),
      itemBuilder: (context, _) => Icon(
        iconData ?? Icons.star,
        color: AppColors.yellowColor,
      ),
      onRatingUpdate: (rating) {
        onChanged?.call(rating);
      },
    );
  }
}
