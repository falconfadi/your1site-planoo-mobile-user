import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/ui/widgets/custom_dialog.dart';
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
    return InkWell(
      onTap: () {
        if(image != "") {
          showAnimatedDialog(
            context,
            Center(
                child: CachedImage(
                  imageUrl: image!,
                  width: 1.sw,
                  height: 300.w,
                  fit: BoxFit.cover,

                )
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
