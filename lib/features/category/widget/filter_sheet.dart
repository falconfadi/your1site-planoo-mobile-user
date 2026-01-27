import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/constants/enum/sort_enum.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/features/category/data/model/filter_result_model.dart';
import 'package:flutter/material.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterSheet extends StatefulWidget {

  final SortOrder? initialPriceOrder;
  final SortOrder? initialRateOrder;

  const FilterSheet({
    super.key,
    this.initialPriceOrder,
    this.initialRateOrder,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {

  SortOrder? priceOrder;
  SortOrder? rateOrder;

  @override
  void initState() {
    super.initState();
    priceOrder = widget.initialPriceOrder;
    rateOrder = widget.initialRateOrder;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FilterSection(
          title: AppLocalization.of(context).translate("price"),
          value: priceOrder,
          onChanged: (value) {
            setState(() => priceOrder = value);
          },
        ),
        SizedBox(height: 30.h),
        _FilterSection(
          title: AppLocalization.of(context).translate("rate"),
          value: rateOrder,
          onChanged: (value) {
            setState(() => rateOrder = value);
          },
        ),
        SizedBox(height: 40.h),
        CustomButton(
          width: 1.sw,
          backgroundColor: AppColors.primaryColor,
          borderRadius: 10.r,
          buttonName: AppLocalization.of(context).translate("apply"),
          function: () {
            Navigator.pop(context,
              FilterResultModel(
                priceOrder: priceOrder,
                rateOrder: rateOrder,
              ),
            );
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class _FilterSection extends StatelessWidget {

  final String title;
  final SortOrder? value;
  final ValueChanged<SortOrder?> onChanged;

  const _FilterSection({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: AppTheme.bodyLarge),
          SizedBox(height: 10.h),
          Row(
            children: [
              _FilterChip(
                label: 'Asc',
                selected: value == SortOrder.asc,
                onTap: () => onChanged(SortOrder.asc),
              ),
              SizedBox(width: 15.w),
              _FilterChip(
                label: 'Desc',
                selected: value == SortOrder.desc,
                onTap: () => onChanged(SortOrder.desc),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {

  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : AppColors.lightGrayColor,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Text(
          label,
          style: AppTheme.labelMedium.copyWith(color: selected ? AppColors.whiteColor : AppColors.blackColor)
        ),
      ),
    );
  }
}
