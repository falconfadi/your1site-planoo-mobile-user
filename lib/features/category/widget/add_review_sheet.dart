import 'package:centro/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:centro/core/ui/shared_widgets/custom_rating_bar.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/usecase/add_review_usecase.dart';
import 'package:flutter/material.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/utils/form_utils/form_state_mixin.dart';
import 'package:centro/core/ui/widgets/custom_text_field.dart';
import 'package:centro/core/utils/extension/text_field_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddReviewSheet extends StatefulWidget {

  String ownerType;
  int ownerId;
  final VoidCallback onRefresh;

  AddReviewSheet({super.key,required this.ownerType,required this.ownerId,required this.onRefresh});

  @override
  State<AddReviewSheet> createState() => _AddReviewSheetState();
}

class _AddReviewSheetState extends State<AddReviewSheet>  with FormStateMinxin {

  double userRate = 1.0;

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return SizedBox(
      child: Form(
        key: form.key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomRatingBar(
              rate: userRate,
              size: isTablet ? 30.sp : 40.sp,
              itemPadding: 10.w,
              onChanged: (value) {
                setState(() {
                  userRate = value;
                });
              },
            ),
            SizedBox(height: 30.h),
            CustomTextField(
              autoValidateMode: AutovalidateMode.onUserInteraction,
              maxLine: 3,
              focusNode: form.nodes[0],
              textEditingController: form.controllers[0],
              labelText: "${AppLocalization.of(context).translate("add_your_review")}...",
            ),
            SizedBox(height: 50.h),
            CreateModel(
                onSuccess: (model) async {
                  Navigation.pop();
                  Navigation.pop();
                  widget.onRefresh.call();
                },
                withValidation: true,
                onTap: () {
                  return form.validate();
                },
                useCaseCallBack: (model) {
                  return AddReviewUseCase(CategoryRepository()).call(
                      params: AddReviewParams(
                        rate: userRate.toInt(),
                        content: form.controllers[0].text,
                        ownerType: widget.ownerType,
                        ownerId: widget.ownerId
                      ));
                },
                child: CustomButton(
                  width: 1.sw,
                  backgroundColor: AppColors.primaryColor,
                  borderRadius: 10.r,
                  buttonName: AppLocalization.of(context).translate("send"),
                ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  @override
  int numberOfFields() => 1;
}
