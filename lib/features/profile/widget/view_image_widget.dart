import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/ui/widgets/custom_dialog.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewImageWidget extends StatelessWidget {

  final String? image;
  final double? width;
  final double? height;
  final double? borderRadius;

  const ViewImageWidget({super.key,
    this.image,
    this.width,
    this.height,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return InkWell(
      onTap: () {
        if(image != "") {
          showAnimatedDialog(
            context,
            Dialog(
              insetPadding: EdgeInsets.all(20.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => Navigation.pop(),
                          child: Icon(Icons.close, size: isTablet ? 20.sp : null),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    CachedImage(
                      imageUrl: image!,
                      fit: BoxFit.cover,
                      borderRadius: 10.r,
                    ),
                  ],
                ),
              ),
            ),
            dismissible: true,
          );
        }
      },
      child: CachedImage(
        imageUrl: image!,
        width: width ?? 100.w,
        height: height ?? 100.w,
        fit: BoxFit.cover,
        borderColor: AppColors.grayColor,
        borderWidth: 1,
        borderRadius: borderRadius,
      ),
    );
  }
}
