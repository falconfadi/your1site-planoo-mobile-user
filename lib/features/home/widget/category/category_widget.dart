import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/home/ui/partners_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryWidget extends StatelessWidget {

  final double? size;
  final TextStyle? textStyle;

  CategoryWidget({this.size,this.textStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigation.push(PartnersScreen()),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImage(
                borderRadius: 100.r,
                imageUrl: "",
                height: size ?? 110.w,
                width: size ?? 110.w,
                fit: BoxFit.cover,
              ),
              // SizedBox(height: 8.h),
              SizedBox(
                  width: size ?? 110.w,
                  child: Center(
                    child: Text("category name",
                      style: textStyle ?? AppTheme.titleMedium.copyWith(fontSize: 14),
                      maxLines: 2, overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  )
              ),
            ])
    );
  }
}