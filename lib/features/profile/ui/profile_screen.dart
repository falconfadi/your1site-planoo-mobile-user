import 'dart:io';
import 'package:centro/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:centro/core/boilerplate/get_model/cubits/get_model_cubit.dart';
import 'package:centro/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/classes/app_storage.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/constants/end_point.dart';
import 'package:centro/core/ui/dialogs/dialogs.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/custom_info_widget.dart';
import 'package:centro/core/ui/shared_widgets/expandable_text_widget.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/ui/widgets/custom_sheet.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:centro/core/utils/validators/convert_date_time.dart';
import 'package:centro/features/auth/data/auth_repository/auth_repository.dart';
import 'package:centro/features/auth/data/model/sign_in_model.dart';
import 'package:centro/features/auth/data/usecase/logout_usecase.dart';
import 'package:centro/features/auth/ui/sign_in_screen.dart';
import 'package:centro/features/profile/data/usecase/delete_customer_usecase.dart';
import 'package:centro/features/profile/ui/about_screen.dart';
import 'package:centro/features/profile/ui/change_password_screen.dart';
import 'package:centro/features/profile/data/profile_repository/profile_repository.dart';
import 'package:centro/features/profile/data/usecase/delete_profile_image_usecase.dart';
import 'package:centro/features/profile/data/usecase/get_customer_usecase.dart';
import 'package:centro/features/profile/ui/terms_and_conditions_screen.dart';
import 'package:centro/features/profile/widget/edit_profile_sheet.dart';
import 'package:centro/features/profile/widget/language_sheet.dart';
import 'package:centro/features/profile/widget/pick_image_sheet.dart';
import 'package:centro/features/profile/widget/profile_card.dart';
import 'package:centro/features/profile/widget/view_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  File? photo;
  GetModelCubit<SignInModel>? _customerCubit;
  bool clearToken = false;

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: CustomHeader(title: AppLocalization.of(context).translate("profile"), isNavBar: true),
      body: GetModel<SignInModel>(
          onCubitCreated: (cubit) {
            _customerCubit = cubit as GetModelCubit<SignInModel>;
          },
          useCaseCallBack: () {
            return GetCustomerUseCase(ProfileRepository()).call(params: GetCustomerParams());
            },
          onSuccess: (model) {},
          modelBuilder: (model) => SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: AppColors.mediumGrayColor)
                            ),
                            child: ViewImageWidget(
                              image: model.customer!.profileImage == null ? "" : model.customer!.profileImage!.url!.toString(),
                              width: 100.w,
                              height: 100.w,
                              borderRadius: 10.r,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                CustomSheet.show(
                                  isDismissible: true,
                                  header: Text(AppLocalization.of(context).translate("select_image"),
                                    style: AppTheme.titleLarge.copyWith(fontSize: 18.sp),
                                  ),
                                  action: model.customer!.profileImage == null ? null : CreateModel(
                                    withValidation: false,
                                    loadingHeight: 20.h,
                                    onTap: () {},
                                    onSuccess: (model) {
                                      Navigator.pop(context);
                                      _customerCubit?.getModel(silent: true);
                                    },
                                    useCaseCallBack: (model) => DeleteProfileImageUseCase(ProfileRepository()).call(
                                        params: DeleteProfileImageParams()),
                                    child: SvgPicture.asset(delete,width: isTablet ? 20.w : 25.w),
                                  ),
                                  padding: 30.w,
                                  context: context,
                                  child: PickImageSheet(onImageUpdated: () async {
                                    _customerCubit?.getModel(silent: true);
                                  }),
                                );
                              },
                              child: Container(
                                width: 35.w,
                                height: 35.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(image,width: isTablet ? 25.w : null),
                                  ),
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(model.customer!.name!,
                          textAlign: TextAlign.center,
                          style: AppTheme.headlineMedium.copyWith(fontSize: 22.sp)
                      ),
                      InkWell(
                        onTap: () {
                          CustomSheet.show(
                              isDismissible: true,
                              header: Text(AppLocalization.of(context).translate("edit"),
                                style: AppTheme.titleLarge.copyWith(fontSize: 18.sp),
                              ),
                              padding: 30.w,
                              context: context,
                              child: EditProfileSheet(model: model,onImageUpdated: () async {
                                _customerCubit?.getModel(silent: true);
                              })
                          );
                        },
                        child: Text("(${AppLocalization.of(context).translate("edit")})",
                            textAlign: TextAlign.center,
                            style: AppTheme.bodyMedium.copyWith(color: AppColors.primaryColor)
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                ProfileCard(title: "your_info",onTap: () {
                  CustomSheet.show(
                      isDismissible: true,
                      header: Text(AppLocalization.of(context).translate("your_info"),
                        style: AppTheme.titleLarge.copyWith(fontSize: 18.sp),
                      ),
                      padding: 30.w,
                      context: context,
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 0.9.sw,
                            padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 0,bottom: 20.h),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomInfoWidget(title: AppLocalization.of(context).translate("full_name"), subTitle: model.customer!.name!),
                                SizedBox(height: 5.h),
                                CustomInfoWidget(title: AppLocalization.of(context).translate("email_address"), subTitle: model.customer!.email ?? "-"),
                                SizedBox(height: 5.h),
                                CustomInfoWidget(title: AppLocalization.of(context).translate("birthdate"), subTitle: model.customer!.birthdate == null ? "-" : convertDate(date: model.customer!.birthdate!)),
                                SizedBox(height: 5.h),
                                CustomInfoWidget(title: AppLocalization.of(context).translate("gender"), subTitle: model.customer!.gender ?? "-"),
                                SizedBox(height: 10.h),
                              ],
                            ),
                          )
                        ),
                      ),
                  );
                }),
                SizedBox(height: 15.h),
                ProfileCard(title: "about",onTap: () => Navigation.push(AboutScreen())),
                SizedBox(height: 15.h),
                ProfileCard(title: "app_language",onTap: () => CustomSheet.show(
                    isDismissible: true,
                    header: Text(AppLocalization.of(context).translate("app_language"),
                      style: AppTheme.titleLarge.copyWith(fontSize: 18.sp),
                    ),
                    padding: 30.w,
                    context: context,
                    child: LanguageSheet())),
                SizedBox(height: 15.h),
                ProfileCard(title: "change_password",onTap: () => Navigation.push(ChangePasswordScreen())),
                SizedBox(height: 15.h),
                ProfileCard(title: "terms_and_conditions",onTap: () => Navigation.push(TermsAndConditionsScreen())),
                SizedBox(height: 15.h),
                ProfileCard(title: "delete_account",onTap: () {
                  Dialogs.showQuestion(
                    context,
                    title: "",
                    content: StatefulBuilder(
                        builder: (context, setStateDialog) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(AppLocalization.of(context).translate("are_you_sure") +
                                    AppLocalization.of(context).translate("?"),
                                  textAlign: TextAlign.center,
                                  style: AppTheme.headlineSmall.copyWith(color: AppColors.mediumGrayColor),
                                ),
                              ),
                            ],
                          );
                        }
                    ),
                    btnOk: CreateModel(
                      withValidation: false,
                      onTap: () {},
                      onSuccess: (data) {
                        AppStorage.removeData(key: kAccessToken);
                        AppStorage.removeData(key: userID);
                        Navigation.pushAndRemoveUntil(SignInScreen());
                      },
                      useCaseCallBack: (model) {
                        return DeleteCustomerUseCase(ProfileRepository()).call(
                            params: DeleteCustomerParams());
                      },
                      child: CustomButton(
                        height: 40.h,
                        width: 1.sw,
                        backgroundColor: AppColors.redColor,
                        borderRadius: 8.r,
                        buttonName: AppLocalization.of(context).translate("ok"),
                        textStyle: AppTheme.headlineSmall.copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 30.h),
                CustomButton(
                  backgroundColor: AppColors.primaryColor,
                  borderRadius: 10.r,
                  buttonName: AppLocalization.of(context).translate("log_out"),
                  function: () {
                    clearToken = false;
                    Dialogs.showQuestion(
                      context,
                      title: "",
                      content: StatefulBuilder(
                          builder: (context, setStateDialog) {
                            return Column(
                              children: [
                                ListTile(
                                    title: Text(AppLocalization.of(context).translate("are_you_sure") +
                                        AppLocalization.of(context).translate("?"),
                                      textAlign: TextAlign.center,
                                      style: AppTheme.headlineSmall.copyWith(color: AppColors.mediumGrayColor),
                                    ),
                                    subtitle: Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            value: clearToken,
                                            activeColor: AppColors.redColor,
                                            visualDensity: VisualDensity.compact,
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            onChanged: (value) {
                                              setStateDialog(() {
                                                clearToken = !clearToken;
                                              });
                                            },
                                          ),
                                          Expanded(
                                              child: ExpandableTextWidget(
                                                text: AppLocalization.of(context).translate("logout_clear_token_warning"),
                                                style: AppTheme.bodyMedium,
                                              )
                                          )
                                        ],
                                      ),
                                    )
                                )
                              ],
                            );
                          }
                      ),
                      btnOk: CreateModel(
                        withValidation: false,
                        onTap: () {},
                        onSuccess: (data) {
                          AppStorage.removeData(key: kAccessToken);
                          AppStorage.removeData(key: userID);
                          Navigation.pushAndRemoveUntil(SignInScreen());
                        },
                        useCaseCallBack: (model) {
                          return LogoutUseCase(AuthRepository()).call(
                              params: LogoutParams(
                                  clearToken: clearToken
                              ));
                        },
                        child: CustomButton(
                          height: 40.h,
                          width: 1.sw,
                          backgroundColor: AppColors.redColor,
                          borderRadius: 8.r,
                          buttonName: AppLocalization.of(context).translate("ok"),
                          textStyle: AppTheme.headlineSmall.copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                    );
                  }
                ),
                SizedBox(height: 30.h),
              ],
            ),
          )
      )
    );
  }
}
