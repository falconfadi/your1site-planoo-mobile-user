import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/custom_rate_sheet.dart';
import 'package:centro/core/ui/widgets/coustom_sheet.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/features/home/widget/review_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsScreen extends StatefulWidget {

  ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomHeader(title: '', isNavBar: false),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),
        child: Column(
          children: [
            CustomButton(
                height: 54.h,
                backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                borderRadius: 4.r,
                icon: star,
                iconColor: AppColors.primaryColor,
                textStyle: AppTheme.bodyMedium
                    .copyWith(fontSize: 16, color: AppColors.primaryColor),
                buttonName: AppLocalization.of(context).translate("add_review"),
                function: () => CustomSheet.show(
                    isDismissible: true,
                    header: Text(AppLocalization.of(context).translate("add_review")),
                    headerStyle: AppTheme.bodyMedium,
                    padding: 30.w,
                    context: context,
                    child: CustomRateSheet())
            ),
            SizedBox(height: 15.h),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context,ratingIndex) {
                return ReviewWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}
