import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationScreen extends StatelessWidget {

  ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomHeader(
        isNavBar: false,
        title: "",
        leading: InkWell(
          onTap: () {
            Navigation.pop();
            Navigation.pop();
          },
          child: const Icon(Icons.close, color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(confirmation),
              SizedBox(height: 40.h),
              Text("${AppLocalization.of(context).translate("confirmed")}!",
              style: AppTheme.headlineSmall.copyWith()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
