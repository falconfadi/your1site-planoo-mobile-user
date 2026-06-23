import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/icon_text_widget.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:centro/core/utils/validators/convert_date_time.dart';
import 'package:centro/features/appointment/data/model/court/court_appointment_details_model.dart';
import 'package:centro/features/appointment/ui/course_appointment_details_screen.dart';
import 'package:centro/features/appointment/ui/court_appointment_details_screen.dart';
import 'package:centro/features/appointment/ui/event_appointment_details_screen.dart';
import 'package:centro/features/appointment/widget/status_widget.dart';
import 'package:centro/core/constants/app_images.dart' as image;
import 'package:centro/core/utils/project_utils/status_type.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AppointmentWidget extends StatefulWidget {

  CourtAppointmentDetailsModel? courtAppointment;
  CourseDetailsModel? courseAppointment;
  EventDetailsModel? eventAppointment;
  VoidCallback? onRefresh;

  AppointmentWidget({super.key,
    this.courtAppointment,
    this.courseAppointment,
    this.eventAppointment,
    this.onRefresh
  });

  @override
  State<AppointmentWidget> createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {

  dynamic get item {
    if (widget.courtAppointment != null) return widget.courtAppointment!;
    if (widget.courseAppointment != null) return widget.courseAppointment!;
    if (widget.eventAppointment != null) return widget.eventAppointment!;
    return null;
  }

  String get itemName {
    if (widget.courtAppointment != null) {
      return widget.courtAppointment!.holder!.name!;
    } else if (widget.courseAppointment != null) {
      return widget.courseAppointment!.name!;
    } else {
      return widget.eventAppointment!.name!;
    }
  }

  String get itemStatus {
    if (widget.courtAppointment != null) {
      return widget.courtAppointment!.status!;
    } else if (widget.courseAppointment != null) {
      return widget.courseAppointment!.status!;
    } else {
      return widget.eventAppointment!.status!;
    }
  }

  Color getStatusColor() {
    if (widget.courtAppointment != null) {
      return StatusType().getStatusInfo(widget.courtAppointment!.status!)["color"] ?? AppColors.darkGreenColor;
    }

    final String? status = widget.courseAppointment?.status ?? widget.eventAppointment?.status;
    switch (status) {
      case "pending":
        return AppColors.mediumGrayColor;
      case "canceled":
        return AppColors.redColor;
      case "completed":
        return AppColors.purpleColor;
      default:
        return AppColors.darkGreenColor;
    }
  }

  String get itemDate {
    if (widget.courtAppointment != null) {
      return widget.courtAppointment!.date!;
    } else if (widget.courseAppointment != null) {
      return widget.courseAppointment!.startDate!;
    } else {
      return widget.eventAppointment!.startDate!;
    }
  }

  String get itemIcon {
    return widget.courtAppointment != null ? image.time : image.remainingSessions;
  }

  String get itemTimeOrCapacity {
    if (widget.courtAppointment != null) {
      if (widget.courtAppointment!.time == null) return "";
      final parsedTime = DateFormat("HH:mm:ss").parse(widget.courtAppointment!.time!);
      return DateFormat("HH:mm").format(parsedTime);
    } else if (widget.courseAppointment != null) {
      return widget.courseAppointment!.customer!.remainingSessions?.toString() ?? "0";
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return InkWell(
      onTap: () {
        if(widget.courtAppointment != null) {
          Navigation.push(CourtAppointmentDetailsScreen(appointmentId: widget.courtAppointment!.iD!,onRefresh: widget.onRefresh));
        } else if (widget.courseAppointment != null) {
          Navigation.push(CourseAppointmentDetailsScreen(courseId: widget.courseAppointment!.iD!));
        } else {
          Navigation.push(EventAppointmentDetailsScreen(eventId: widget.eventAppointment!.iD!));
        }
      },
      child: Card(
        color: AppColors.whiteColor,
        elevation: 3,
        shadowColor: AppColors.gray2Color,
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(itemName,
                        maxLines: 1,overflow: TextOverflow.ellipsis,
                        style: AppTheme.bodyMedium.copyWith(fontSize: 18.sp)
                    ),
                  ),
                  SizedBox(width: 10.w),
                  StatusWidget(
                    statusText: itemStatus,
                    statusColor: getStatusColor(),
                    width: 0.25.sw,
                    height: isTablet ? null : 32.h,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: IconTextWidget(
                      icon: image.appointment,
                      iconSize: 18.w,
                      text: convertDate(date: itemDate,format: 'dd/MM/yyyy'),
                      textStyle: AppTheme.labelLarge.copyWith(color: AppColors.mediumGrayColor),
                    ),
                  ),
                  widget.eventAppointment != null ? Center() :
                  Expanded(
                    child: IconTextWidget(
                      icon: itemIcon,
                      iconSize: 20.w,
                      iconColor: AppColors.purpleColor,
                      text: itemTimeOrCapacity,
                      textStyle: AppTheme.labelLarge.copyWith(color: AppColors.mediumGrayColor),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
