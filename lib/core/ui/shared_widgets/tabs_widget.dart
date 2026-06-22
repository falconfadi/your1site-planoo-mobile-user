import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/constants/enum/main_tabs.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabsWidget extends StatelessWidget {

  final int selectedTab;
  final bool inCenter;
  final ValueChanged<int> onTabChanged;

  const TabsWidget({
    super.key,
    required this.selectedTab,
    this.inCenter = false,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final tabs = ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: MainTabs.values.length,
      itemBuilder: (context, index) {
        final tab = MainTabs.values[index];
        return InkWell(
          onTap: () => onTabChanged(index),
          child: Container(
            margin: EdgeInsets.only(right: 30.w),
            child: Text(
              AppLocalization.of(context).translate(tab.name),
              style: AppTheme.labelLarge.copyWith(
                fontSize: 18.sp,
                color: selectedTab == index ? AppColors.blackColor : AppColors.mediumGrayColor,
              ),
            ),
          ),
        );
      },
    );
    return SizedBox(
      width: 1.sw,
      height: isTablet ? 50.h : 35.h,
      child: inCenter ? Center(child: tabs) : tabs,
    );
  }
}
