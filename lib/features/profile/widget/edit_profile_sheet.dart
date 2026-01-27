import 'package:centro/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:centro/features/auth/data/model/sign_in_model.dart';
import 'package:centro/features/profile/data/profile_repository/profile_repository.dart';
import 'package:centro/features/profile/data/usecase/edit_customer_usecase.dart';
import 'package:flutter/material.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/utils/form_utils/form_state_mixin.dart';
import 'package:centro/core/ui/widgets/custom_text_field.dart';
import 'package:centro/core/utils/extension/text_field_ext.dart';
import 'package:centro/core/utils/validators/base_validator.dart';
import 'package:centro/core/utils/validators/required_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileSheet extends StatefulWidget {

  VoidCallback onImageUpdated;
  SignInModel? model;

  EditProfileSheet({required this.onImageUpdated, super.key,  this.model});

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> with FormStateMinxin {

  @override
  void initState() {
    super.initState();
    form.controllers[0].text = widget.model!.customer!.name!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        key: form.key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            CustomTextField(
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return BaseValidator.validateValue(
                  context,
                  form.controllers[0].text,
                  [RequiredValidator()],
                );
              },
              focusNode: form.nodes[0],
              textEditingController: form.controllers[0],
              labelText: AppLocalization.of(context).translate("full_name"),
            ),
            SizedBox(height: 30.h),
            CreateModel(
              withValidation: false,
              loadingHeight: 20.h,
              onTap: () {},
              onSuccess: (model) {
                widget.onImageUpdated();
                Navigator.pop(context);
              },
              useCaseCallBack: (model) => EditCustomerUseCase(ProfileRepository()).call(
                  params: EditCustomerParams(
                    name: form.controllers[0].text,
                  )),
              child: CustomButton(
                width: 1.sw,
                backgroundColor: AppColors.primaryColor,
                borderRadius: 10.r,
                buttonName: AppLocalization.of(context).translate("save"),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  @override
  int numberOfFields() => 2;
}

