import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/custom_row_widget.dart';
import 'package:centro/core/ui/shared_widgets/icon_text_widget.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/ui/widgets/custom_text_field.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/form_utils/form_utils.dart';
import 'package:centro/features/home/ui/confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:centro/core/utils/form_utils/form_state_mixin.dart';

class BookingSummaryScreen extends StatefulWidget {

  const BookingSummaryScreen({super.key});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> with FormStateMinxin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomHeader(
        isNavBar: false,
        title: "",
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigation.pushReplacement(ConfirmationScreen());
                  },
                  child: Text(AppLocalization.of(context).translate("confirm"),
                      style: AppTheme.titleSmall.copyWith(color: AppColors.primaryColor)),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Container(
              width: 1.sw,
              height: 100.h,
              padding: EdgeInsets.symmetric(horizontal: 0.w,vertical: 0.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.gray2Color,
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0,1)
                  )
                ],
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CachedImage(
                      height: 100.h,
                      width: 100.w,
                      borderRadius: 0,
                      imageUrl: "",
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Green Valley Basketball Court",
                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                  style: AppTheme.bodyMedium.copyWith(fontSize: 14),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Basketball",
                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                  style: AppTheme.bodySmall.copyWith(color: AppColors.primaryColor),
                                ),
                              ]
                          ),
                        )),
                  ]),
            ),
            SizedBox(height: 30.h),
            CustomRowWidget(
                text: AppLocalization.of(context).translate("activity"),
                seeAllText: false
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text("Kids Sports Class",
                    style: AppTheme.labelLarge,
                  ),
                ),
                SizedBox(width: 5.w),
                // if(selectedService.type == "vip")
                SvgPicture.asset(vip,width: 25.w)
              ],
            ),
            SizedBox(height: 5.h),
            Text("1500",
              style: AppTheme.bodyMedium.copyWith(color: AppColors.darkGreenColor),
            ),
            SizedBox(height: 10.h),
            IconTextWidget(
              icon: appointment,
              iconColor: AppColors.mediumGrayColor,
              iconSize: 18,
              text: "Monday at 15:00",
              textStyle: AppTheme.labelMedium.copyWith(color: AppColors.mediumGrayColor),
            ),
            SizedBox(height: 20.h),
            Divider(),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalization.of(context).translate("total"),
                  style: AppTheme.labelLarge,
                ),
                Text("1500",
                  style: AppTheme.titleMedium.copyWith(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 50.h),
            Form(
              key: form.key,
              child: CustomTextField(
                autoFocus: false,
                maxLine: 3,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                focusNode: form.nodes[0],
                textEditingController: form.controllers[0],
                labelText: AppLocalization.of(context).translate("booking_note"),
              ),
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  @override
  int numberOfFields() => 1;
}
