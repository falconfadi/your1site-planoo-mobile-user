import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/ui/widgets/custom_dialog.dart';
import 'package:centro/core/ui/widgets/custom_text_field.dart';
import 'package:centro/core/ui/widgets/coustom_sheet.dart';
import 'package:centro/core/utils/extension/text_field_ext.dart';
import 'package:centro/core/utils/form_utils/form_state_mixin.dart';
import 'package:centro/features/profile/widget/change_password_sheet.dart';
import 'package:centro/features/profile/widget/pick_image_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with FormStateMinxin {

  String? imageUpload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomHeader(
        isNavBar: false,
        title: AppLocalization.of(context).translate("edit_information"),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text(AppLocalization.of(context).translate("save"),
                    style: AppTheme.titleSmall.copyWith(color: AppColors.primaryColor)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: form.key,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      showAnimatedDialog(
                        context,
                        Center(
                          child: Container(
                            width: 1.sw,
                            height: 300.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                // todo change later to network
                                image: AssetImage(profileHolder),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        dismissible: true,
                      );
                    },
                    child: CachedImage(
                      imageUrl: "",
                      width: 155.w,
                      height: 155.w,
                      fit: BoxFit.cover,
                      borderRadius: 100.r,
                    ),
                  ),
                  Positioned(
                    bottom: 5.h,
                    right: 10.w,
                    child: GestureDetector(
                      onTap: () {
                        CustomSheet.show(
                          isDismissible: true,
                          header: Text(
                            AppLocalization.of(context).translate("select_image"),
                            style: AppTheme.bodyMedium,
                          ),
                          padding: 30.w,
                          context: context,
                          child: PickImageSheet());
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.r),
                          color: AppColors.whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.r),
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: SvgPicture.asset(image),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      autoFocus: false,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.person,
                      focusNode: form.nodes[0],
                      nextFocusNode: form.nodes[1],
                      textEditingController: form.controllers[0],
                      labelText: AppLocalization.of(context).translate("first_name"),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomTextField(
                      autoFocus: false,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.person,
                      focusNode: form.nodes[1],
                      nextFocusNode: form.nodes[2],
                      textEditingController: form.controllers[1],
                      labelText: AppLocalization.of(context).translate("last_name"),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                autoFocus: false,
                keyboardType: TextInputType.text,
                prefixIcon: Icons.email_outlined,
                filledColor: AppColors.lightGrayColor,
                prefixIconColor: AppColors.blackColor,
                enabled: false,
                labelStyle: AppTheme.labelSmall,
                labelText: AppLocalization.of(context).translate("email_address"),
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                autoFocus: false,
                filledColor: AppColors.lightGrayColor,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.phone,
                prefixIconColor: AppColors.blackColor,
                enabled: false,
                labelStyle: AppTheme.labelSmall,
                labelText: AppLocalization.of(context).translate("phone"),
              ),
              SizedBox(height: 50.h),
              CustomButton(
                backgroundColor: AppColors.primaryColor,
                borderRadius: 10.r,
                iconColor: AppColors.primaryColor,
                buttonName: AppLocalization.of(context).translate("change_password"),
                function: () {
                  CustomSheet.show(
                      isDismissible: true,
                      header: Text(
                        AppLocalization.of(context).translate("change_password"),
                        style: AppTheme.bodyMedium,
                      ),
                      padding: 20.w,
                      context: context,
                      child: ChangePasswordSheet());
                },
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  int numberOfFields() => 5;
}
