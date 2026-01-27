import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/icon_text_widget.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/validators/convert_date_time.dart';
import 'package:centro/features/appointment/data/model/appointment_details_model.dart';
import 'package:centro/features/appointment/ui/appointment_details_screen.dart';
import 'package:centro/features/appointment/widget/status_widget.dart';
import 'package:centro/core/constants/app_images.dart' as image;
import 'package:centro/core/utils/project_utils/status_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AppointmentWidget extends StatefulWidget {

  AppointmentDetailsModel? appointment;
  VoidCallback? onRefresh;

  AppointmentWidget({super.key,required this.appointment,this.onRefresh});

  @override
  State<AppointmentWidget> createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.push(AppointmentDetailsScreen(appointmentId: widget.appointment!.iD!,onRefresh: widget.onRefresh));
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
                    child: Text(widget.appointment!.holder!.name!,
                        maxLines: 1,overflow: TextOverflow.ellipsis,
                        style: AppTheme.bodyMedium.copyWith(fontSize: 18.sp)
                    ),
                  ),
                  SizedBox(width: 10.w),
                  StatusWidget(
                    statusText: widget.appointment!.status!,
                    statusColor: StatusType().getStatusInfo(widget.appointment!.status!)["color"],
                    width: 0.25.sw,
                    height: 32.h,
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
                      text: convertDate(date: widget.appointment!.date!,format: 'dd/MM/yyyy'),
                      textStyle: AppTheme.labelLarge.copyWith(color: AppColors.mediumGrayColor),
                    ),
                  ),
                  Expanded(
                    child: IconTextWidget(
                      icon: image.time,
                      iconSize: 20.w,
                      text: DateFormat("HH:mm").format(DateFormat("HH:mm:ss").parse(widget.appointment!.time!)),
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
