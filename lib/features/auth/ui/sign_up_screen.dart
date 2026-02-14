import 'package:centro/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:centro/core/classes/firebase_api.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/utils/validators/password_validator.dart';
import 'package:centro/core/utils/validators/phone_number_validation.dart';
import 'package:centro/features/auth/data/auth_repository/auth_repository.dart';
import 'package:centro/features/auth/data/usecase/register_usecase.dart';
import 'package:centro/features/auth/ui/verification_code_screen.dart';
import 'package:centro/features/auth/widget/footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/ui/widgets/custom_text_field.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/validators/base_validator.dart';
import 'package:centro/core/utils/validators/required_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:centro/features/auth/ui/sign_in_screen.dart';
import 'package:centro/core/utils/extension/text_field_ext.dart';
import 'package:centro/core/utils/form_utils/form_state_mixin.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>  with FormStateMinxin {

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
                  SizedBox(height: 10.h),
                  Image.asset(logo,width: 1.sw,height: 90.h),
                  Text(AppLocalization.of(context).translate("sign_up").toUpperCase(),
                      style: AppTheme.headlineSmall.copyWith(fontSize: 25.sp)),
                  SizedBox(height: 40.h),
                  CustomTextField(
                    autoFocus: false,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    prefixIcon: Icons.person,
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
                    labelText: AppLocalization.of(context).translate("full_name"),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    autoFocus: false,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone_android_outlined,
                    validator: (value) {
                      return BaseValidator.validateValue(
                        context,
                        value!,
                        [RequiredValidator(),PhoneNumberValidator()],
                      );
                    },
                    focusNode: form.nodes[1],
                    nextFocusNode: form.nodes[2],
                    textEditingController: form.controllers[1],
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
                    focusNode: form.nodes[2],
                    textEditingController: form.controllers[2],
                    labelText: AppLocalization.of(context).translate("password"),
                  ),
                  SizedBox(height: 50.h),
                  CreateModel(
                    onSuccess: (result) async {
                      Navigation.pushAndRemoveUntil(VerificationCodeScreen(phoneNumber: form.controllers[1].text));
                    },
                    withValidation: true,
                    onTap: () {
                      return form.validate();
                    },
                    useCaseCallBack: ( model) {
                      return RegisterUseCase(AuthRepository()).call(
                          params: RegisterParams(
                            name: form.controllers[0].text,
                            phone: form.controllers[1].text,
                            password: form.controllers[2].text,
                            confirmationPassword: form.controllers[2].text,
                            firebaseToken: FirebaseApi.deviceToken.toString()
                          ));
                    },
                    child: CustomButton(
                      width: 1.sw,
                      backgroundColor: AppColors.primaryColor,
                      borderSideColor: AppColors.primaryColor,
                      borderRadius: 10.r,
                      buttonName: AppLocalization.of(context).translate("sign_up"),
                    ),
                  ),
                  SizedBox(height: 80.h),
                  FooterWidget(
                      text: AppLocalization.of(context).translate("have_an_account") +
                          AppLocalization.of(context).translate("?"),
                      link: AppLocalization.of(context).translate("sign_in"),
                      linkTap: () => Navigation.pushReplacement(SignInScreen())),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  int numberOfFields() => 3;
}
