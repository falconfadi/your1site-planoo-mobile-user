import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionWidget extends StatelessWidget {

  final String day;
  final List<String> times;
  final String? selectedTime;
  final ValueChanged<String>? onSelected;
  final TextStyle? textStyle;

  const SessionWidget({
    Key? key,
    required this.day,
    required this.times,
    this.selectedTime,
    this.onSelected,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(day, style: AppTheme.titleSmall),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 10.w,
          children: times.map((time) {
            final id = "$day|$time";
            final isSelected = selectedTime == id;
            return FilterChip(
              label: Text(time),
              selected: isSelected,
              onSelected: (_) => onSelected!(id),
              selectedColor: AppColors.primaryColor.withOpacity(0.1),
              checkmarkColor: AppColors.primaryColor,
              labelStyle: textStyle ??
                  AppTheme.bodyMedium.copyWith(
                    color: isSelected ? AppColors.primaryColor : Colors.black,
                  ),
            );
          }).toList(),
        )
      ],
    );
  }
}

