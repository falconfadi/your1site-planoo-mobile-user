import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/constants/enum/partner_tabs.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/features/home/widget/court/court_widget.dart';
import 'package:centro/features/home/widget/trainer/trainer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_grid/responsive_grid.dart';

class PartnersScreen extends StatefulWidget {

  PartnersScreen({super.key});

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomHeader(title: '', isNavBar: false),
      body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 25.h),
              Container(
                alignment: Alignment.center,
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: PartnerTabs.values.length,
                  itemBuilder: (context, index) {
                    final tab = PartnerTabs.values[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedTab = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 25.w),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: selectedTab == index ?
                            AppColors.darkGrayColor : Colors.transparent),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(AppLocalization.of(context).translate(tab.name),style: AppTheme.labelLarge.copyWith(color: selectedTab == index ?
                            AppColors.darkGrayColor : AppColors.mediumGrayColor))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30.h),
              selectedTab == 0 ?
              ResponsiveGridList(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  desiredItemWidth: 150.w,
                  minSpacing: 15,
                  children: [1, 2, 3, 4, 5, 6,7].map((i) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: CourtWidget(width: 1.sw),
                    );
                  }).toList()) :
              ResponsiveGridList(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  desiredItemWidth: 150.w,
                  minSpacing: 15,
                  children: [1, 2, 3, 4, 5, 6].map((i) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: TrainerWidget(width: 1.sw),
                    );
                  }).toList()),
              SizedBox(height: 50.h),
            ],
          )
      ),
    );
  }
}
