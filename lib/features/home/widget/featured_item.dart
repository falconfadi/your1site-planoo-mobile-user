import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/icon_text_widget.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/project_utils/string_utils.dart';
import 'package:centro/features/category/data/model/activity/activity_details_model.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
import 'package:centro/features/category/ui/activity_details_screen.dart';
import 'package:centro/features/category/ui/course_details_screen.dart';
import 'package:centro/features/category/ui/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeaturedItem extends StatefulWidget {

  ActivityDetailsModel? activity;
  CourseDetailsModel? course;
  EventDetailsModel? event;

  FeaturedItem({super.key, this.activity, this.course, this.event});

  @override
  State<FeaturedItem> createState() => _FeaturedItemState();
}

class _FeaturedItemState extends State<FeaturedItem> {

  dynamic get item {
    if (widget.activity != null) return widget.activity!;
    if (widget.course != null) return widget.course!;
    if (widget.event != null) return widget.event!;
    return null;
  }

  String get itemDuration {
    if (widget.event != null) {
      return "${widget.event!.eventDuration!} ${AppLocalization.of(context).translate("day")}";
    } else if (widget.course != null) {
      return  "${widget.course!.sessionDuration!} ${AppLocalization.of(context).translate("minute")}"" - ""${widget.course!.courseDuration!} ${AppLocalization.of(context).translate("day")}";
    } else {
      return "${widget.activity!.sessionDuration!} ${AppLocalization.of(context).translate("minute")}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = item;
    return InkWell(
      onTap: () {
        if (widget.activity != null) {
          Navigation.push(ActivityDetailsScreen(activityId: data.iD));
          return;
        }
        if (widget.course != null) {
          Navigation.push(CourseDetailsScreen(courseId: data.iD));
          return;
        }
        if (widget.event != null) {
          Navigation.push(EventDetailsScreen(eventId: data.iD));
          return;
        }
      },
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedImage(
                imageUrl: data.mediaList!.first.url!,
                fit: BoxFit.cover,
                height: 175.h,
                width: 1.sw,
              ),
              Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(data.name!, style: AppTheme.bodyMedium.copyWith(color: AppColors.darkGrayColor),maxLines: 1,overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(width: 10.h),
                        Text(AppLocalization.of(context).translate(
                            widget.activity != null ? "activity" : widget.course != null ? "course" : "event"),
                            style: AppTheme.bodySmall),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(star,color: AppColors.yellowColor,width: 20.w),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: Text(
                                  "${data.rate.toString()} (${truncateNumber(data.reviewsList!.length,maxLength: 10)} ${AppLocalization.of(context).translate("reviews")})",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.labelLarge.copyWith(
                                    color: AppColors.mediumGrayColor,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: IconTextWidget(
                              icon: time,
                              iconSize: 15.w,
                              iconColor: AppColors.primaryColor,
                              text: itemDuration,
                              maxline: 1,
                              textStyle: AppTheme.labelMedium.copyWith(color: AppColors.mediumGrayColor,overflow: TextOverflow.ellipsis)
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
