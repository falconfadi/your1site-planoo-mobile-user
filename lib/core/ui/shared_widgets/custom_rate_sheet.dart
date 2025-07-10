import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/utils/extension/text_field_ext.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/ui/widgets/custom_text_field.dart';
import 'package:centro/core/utils/form_utils/form_state_mixin.dart';

class CustomRateSheet extends StatefulWidget {

  CustomRateSheet({Key? key}) : super(key: key);

  @override
  State<CustomRateSheet> createState() => _CustomRateSheetState();
}

class _CustomRateSheetState extends State<CustomRateSheet> with FormStateMinxin {

  double currentRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form.key,
      child: Column(
        children: [
          RatingBar.builder(
            initialRating: currentRating.toDouble(),
            minRating: currentRating.toDouble(),
            glowColor: AppColors.whiteColor,
            ignoreGestures: false,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 55.w,
            unratedColor: AppColors.gray2Color,
            itemPadding: EdgeInsets.symmetric(horizontal: 5.w),
            itemBuilder: (context, _) =>  const Icon(
              Icons.star_outlined,
              color: AppColors.yellowColor,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                currentRating = rating;
              });
            },
          ),
          SizedBox(height: 30.h),
          CustomTextField(
            maxLine: 2,
            focusNode: form.nodes[0],
            textEditingController: form.controllers[0],
            labelText: AppLocalization.of(context).translate("add_review"),
          ),
          SizedBox(height: 50.h),
          CustomButton(
            backgroundColor: AppColors.primaryColor,
            borderRadius: 4.r,
            buttonName: AppLocalization.of(context).translate("save"),
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }

  @override
  int numberOfFields() => 1;
}
