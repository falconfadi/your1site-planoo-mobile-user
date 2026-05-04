import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/icon_text_widget.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/category/data/model/activity/activity_details_model.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
import 'package:centro/features/category/ui/activity_details_screen.dart';
import 'package:centro/features/category/ui/course_details_screen.dart';
import 'package:centro/features/category/ui/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeItem extends StatefulWidget {

  ActivityDetailsModel? activity;
  CourseDetailsModel? course;
  EventDetailsModel? event;

  HomeItem({super.key,
    this.activity,
    this.course,
    this.event,
  });

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {

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
        height: 102.h,
        margin: EdgeInsets.only(bottom: 15.h),
        decoration:BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10.r)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    bottomLeft: Radius.circular(15.r),
                  ),
                ),
                child: CachedImage(
                    imageUrl: data.mediaList!.isEmpty ? "" : data.mediaList!.first.url!,
                    fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r),
                  ),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data.name!, style: AppTheme.bodyMedium.copyWith(color: AppColors.darkGrayColor),maxLines: 1,overflow: TextOverflow.ellipsis),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(data.category.name!, style: AppTheme.labelMedium.copyWith(color: AppColors.mediumGrayColor),maxLines: 1,overflow: TextOverflow.ellipsis)),
                        Expanded(child: IconTextWidget(
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
                    Text(AppLocalization.of(context).translate(
                        widget.activity != null ? "activity" : widget.course != null ? "course" : "event"),
                        style: AppTheme.bodySmall.copyWith(color: AppColors.purpleColor)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
