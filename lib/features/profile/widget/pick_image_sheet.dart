import 'dart:io';
import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PickImageSheet extends StatefulWidget {

  PickImageSheet({Key? key}) : super(key: key);

  @override
  State<PickImageSheet> createState() => _PickImageSheetState();
}

class _PickImageSheetState extends State<PickImageSheet> {

  File? image;

  Future<void> selectImage({ImageSource? imageSource}) async {
    final imagePicker = ImagePicker();
    var pickedFile = await imagePicker.pickImage(source: imageSource!, imageQuality: 25);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor
                  ),
                  child: Center(
                    child: Icon(Icons.image_outlined,size: 25,color: AppColors.whiteColor),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Text(AppLocalization.of(context).translate("gallery"),
                    style: AppTheme.bodyMedium,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor
                  ),
                  child: Center(
                    child: Icon(Icons.camera_alt_outlined,size: 25,color: AppColors.whiteColor),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Text(AppLocalization.of(context).translate("camera"),
                    style: AppTheme.bodyMedium,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}
