import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomRowWidget extends StatelessWidget {

  final String text;
  final bool? seeAllText;
  final VoidCallback? seeAllOnTap;

  CustomRowWidget({required this.text,this.seeAllText = false,this.seeAllOnTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(text,style: AppTheme.titleMedium)
        ),
        seeAllText == false ? const Center() :
        InkWell(
          onTap: seeAllText == false ? null : seeAllOnTap,
          child: Text(AppLocalization.of(context).translate("see_all"),
              style: AppTheme.labelMedium.copyWith(color: AppColors.primaryColor)),
        )
      ],
    );
  }
}