import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:centro/features/home/data/model/day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkdaysPreviewWidget extends StatelessWidget {

  final List<DayModel> workdaysList;

  const WorkdaysPreviewWidget({super.key,
    required this.workdaysList,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return Card(
      color: AppColors.extraLightGrayColor,
      elevation: 3,
      shadowColor: AppColors.gray2Color,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Text(AppLocalization.of(context).translate("workdays"),
                      style: AppTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                      height: isTablet ? 100.h : 80.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: workdaysList.length,
                        itemBuilder: (context,index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrayColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(child: Text(workdaysList[index].day!,style: AppTheme.titleLarge.copyWith(color: AppColors.purpleColor))),
                                Flexible(child: Text("${workdaysList[index].start} - ${workdaysList[index].end}",style: AppTheme.labelLarge)),
                              ],
                            ),
                          );
                        },
                      )
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}