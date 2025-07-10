import 'package:centro/core/constants/app_styles.dart';
import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {

  String? name;
  TextStyle? textStyle;
  VoidCallback? onTap;

  ServiceWidget({super.key,
    this.name,
    this.textStyle,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(name!),
      labelStyle: textStyle ?? AppTheme.labelMedium,
      onPressed: onTap
    );
  }
}
