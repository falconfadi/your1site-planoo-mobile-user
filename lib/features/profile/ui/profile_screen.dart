import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/custom_rate_sheet.dart';
import 'package:centro/core/ui/shared_widgets/custom_row_widget.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/ui/widgets/coustom_sheet.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/profile/ui/about_us_screen.dart';
import 'package:centro/features/profile/ui/edit_profile_screen.dart';
import 'package:centro/features/profile/ui/terms_and_conditions_screen.dart';
import 'package:centro/features/profile/widget/change_language_sheet.dart';
import 'package:centro/features/profile/widget/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
      appBar: CustomHeader(title: "", isNavBar: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              CustomRowWidget(text: AppLocalization.of(context).translate("profile")),
              SizedBox(height: 30.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.lightGrayColor,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0,2)
                    )
                  ],
                ),
                child: Row(
                  children: [
                    CachedImage(
                      borderRadius: 100.r,
                      imageUrl: "",
                      height: 80.w,
                      width: 80.w,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Maya Skef"),
                          SizedBox(height: 2.h),
                          Text("maya@gmail.com"),
                          SizedBox(height: 5.h),
                          Text("0991234567")
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              ProfileCard(icon: edit, title: AppLocalization.of(context).translate("edit_information"),
                  onTap: () => Navigation.push(EditProfileScreen())
              ),
              ProfileCard(icon: language, title: AppLocalization.of(context).translate("language"),
                  onTap: () => CustomSheet.show(
                      isDismissible: true,
                      header: Text(AppLocalization.of(context).translate("language"),
                        style: AppTheme.bodyMedium,
                      ),
                      padding: 30.w,
                      context: context,
                      child: ChangeLanguageSheet())
              ),
              // todo add voucher or fee
              ProfileCard(
                icon: rate,
                title: AppLocalization.of(context).translate("rate_us"),
                onTap: () => CustomSheet.show(
                    isDismissible: true,
                    header: Text(AppLocalization.of(context).translate("rate_us")),
                    headerStyle: AppTheme.bodyMedium,
                    padding: 30.w,
                    context: context,
                    child: CustomRateSheet())
              ),
              ProfileCard(
                icon: termsAndCondition,
                title: AppLocalization.of(context).translate("terms_conditions"),
                  onTap: () => Navigation.push(TermsAndConditionsScreen())
              ),
              ProfileCard(
                icon: about,
                title: AppLocalization.of(context).translate("about_us"),
                  onTap: () => Navigation.push(AboutUsScreen())
              ),
              ProfileCard(
                icon: logout,
                title: AppLocalization.of(context).translate("log_out"),
                onTap: () {},
              ),
              SizedBox(height: 50.h)
            ],
          )
      )
    );
  }
}
