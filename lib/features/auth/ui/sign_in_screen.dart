import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/auth/ui/sign_up_screen.dart';
import 'package:centro/features/auth/widgets/condition_check_box.dart';
import 'package:centro/features/auth/widgets/forget_password_sheet.dart';
import 'package:centro/features/nav_bar/ui/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/ui/widgets/coustom_sheet.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/utils/form_utils/form_state_mixin.dart';
import 'package:centro/core/ui/widgets/custom_text_field.dart';
import 'package:centro/core/utils/extension/text_field_ext.dart';
import 'package:centro/core/utils/validators/base_validator.dart';
import 'package:centro/core/utils/validators/password_validator.dart';
import 'package:centro/core/utils/validators/required_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {

  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>  with FormStateMinxin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: form.key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                Image.asset(logo,width: 200.w,height: 120.h),
                SizedBox(height: 15.h),
                Text(AppLocalization.of(context).translate("sign_in").toUpperCase(),
                    style: AppTheme.titleMedium.copyWith(fontSize: 25)),
                SizedBox(height: 30.h),
                CustomTextField(
                  autoFocus: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,

                  prefixIcon: Icons.phone,
                  validator: (value) {
                    return BaseValidator.validateValue(
                      context,
                      value!,
                      [RequiredValidator()],
                    );
                  },
                  focusNode: form.nodes[0],
                  nextFocusNode: form.nodes[1],
                  textEditingController: form.controllers[0],
                  labelText: AppLocalization.of(context).translate("phone"),
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  autoFocus: false,
                  isPassword: true,
                  prefixIcon: Icons.lock,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return BaseValidator.validateValue(
                      context,
                      value!,
                      [RequiredValidator(),PasswordValidator(value: value)],
                    );
                  },
                  focusNode: form.nodes[1],
                  textEditingController: form.controllers[1],
                  labelText: AppLocalization.of(context).translate("password"),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        CustomSheet.show(
                            isDismissible: true,
                            header: Text(AppLocalization.of(context).translate("forget_password"),
                              style: AppTheme.bodyMedium,
                            ),
                            padding: 30.w,
                            context: context,
                            child: ForgetPasswordSheet()
                        );
                      },
                      child: Text("${AppLocalization.of(context).translate("forget_password")}?",
                          style: AppTheme.labelMedium.copyWith(color: AppColors.primaryColor)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                ConditionCheckBox(),
                SizedBox(height: 50.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        width: 1.sw,
                        backgroundColor: Colors.transparent,
                        borderSideColor: Colors.transparent,
                        borderRadius: 10.r,
                        textStyle: AppTheme.titleSmall.copyWith(color: AppColors.primaryColor),
                        buttonName: AppLocalization.of(context).translate("sign_up"),
                        function: () => Navigation.pushReplacement(SignUpScreen()),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: CustomButton(
                        width: 1.sw,
                        backgroundColor: AppColors.primaryColor,
                        borderRadius: 10.r,
                        buttonName: AppLocalization.of(context).translate("sign_in"),
                        function: () {
                          // todo change later
                          Navigation.pushReplacement(NavBarScreen(pageIndex: 0));
                        }),
                      ),
                  ],
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      )
    );
  }

  @override
  int numberOfFields() => 2;
}
