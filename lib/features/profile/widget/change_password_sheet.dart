import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/utils/validators/base_validator.dart';
import 'package:centro/core/utils/validators/match_validator.dart';
import 'package:centro/core/utils/validators/password_validator.dart';
import 'package:centro/core/utils/validators/required_validator.dart';
import 'package:flutter/material.dart';
import 'package:centro/core/ui/widgets/custom_text_field.dart';
import 'package:centro/core/utils/extension/text_field_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/utils/form_utils/form_state_mixin.dart';

class ChangePasswordSheet extends StatefulWidget {

  ChangePasswordSheet({Key? key}) : super(key: key);

  @override
  State<ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<ChangePasswordSheet>  with FormStateMinxin {

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form.key,
      child: Column(
        children: [
          CustomTextField(
            isPassword: true,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            prefixIcon: Icons.lock,
            validator: (value) {
              return BaseValidator.validateValue(
                context,
                form.controllers[0].text,
                [RequiredValidator(),PasswordValidator(value: value)],
              );
            },
            focusNode: form.nodes[0],
            nextFocusNode: form.nodes[1],
            textEditingController: form.controllers[0],
            labelText: AppLocalization.of(context).translate("old_password"),
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            isPassword: true,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            prefixIcon: Icons.lock,
            validator: (value) {
              return BaseValidator.validateValue(
                context,
                form.controllers[1].text,
                [ RequiredValidator(),PasswordValidator(value: value)],
              );
            },
            focusNode: form.nodes[1],
            nextFocusNode: form.nodes[2],
            textEditingController: form.controllers[1],
            labelText: AppLocalization.of(context).translate("new_password"),
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            isPassword: true,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            prefixIcon: Icons.lock,
            validator: (value) {
              return BaseValidator.validateValue(
                context,
                form.controllers[2].text,
                [ RequiredValidator(),MatchValidator(value: form.controllers[1].text)],
              );
            },
            focusNode: form.nodes[2],
            textEditingController: form.controllers[2],
            labelText: AppLocalization.of(context).translate("confirm_password"),
          ),
          SizedBox(height: 50.h),
          CustomButton(
            width: ScreenUtil().screenWidth - 50.w,
            backgroundColor: AppColors.primaryColor,
            borderRadius: 10.r,
            buttonName: AppLocalization.of(context).translate("save"),
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }

  @override
  int numberOfFields() => 3;
}
