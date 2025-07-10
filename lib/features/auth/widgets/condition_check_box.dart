import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ConditionCheckBox extends StatefulWidget {

  const ConditionCheckBox({super.key});

  @override
  State<ConditionCheckBox> createState() => _ConditionCheckBoxState();
}

class _ConditionCheckBoxState extends State<ConditionCheckBox> {

  bool acceptTerms = true;

  void toggleTerms() {
    acceptTerms = !acceptTerms;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Checkbox(
            activeColor: AppColors.primaryColor,
            value: acceptTerms,
            onChanged: (isChecked) => toggleTerms(),
          ),
          Expanded(
            child: RichText(
                  text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: "${AppLocalization.of(context).translate("i_agree_with")} ",
                          style: AppTheme.labelMedium,
                        ),
                        TextSpan(
                          text: AppLocalization.of(context).translate('terms_conditions'),
                          style: AppTheme.labelMedium.copyWith(color: AppColors.primaryColor),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            // todo go to terms and conditions screen
                          }),
                      ]
                  )
              ),
          ),
    ]);
  }
}
