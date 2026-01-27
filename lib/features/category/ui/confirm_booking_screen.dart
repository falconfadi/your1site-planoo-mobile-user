import 'package:centro/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/dialogs/dialogs.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/custom_info_widget.dart';
import 'package:centro/core/ui/widgets/cached_image.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/validators/convert_date_time.dart';
import 'package:centro/features/category/data/model/activity/book_activity_model.dart';
import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/activity/activity_details_model.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
import 'package:centro/features/category/data/usecase/activity/book_activity_usecase.dart';
import 'package:centro/features/category/data/usecase/course/attend_course_usecase.dart';
import 'package:centro/features/category/data/usecase/event/attend_event_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmBookingScreen extends StatefulWidget {

  String type;
  ActivityDetailsModel? activity;
  BookActivityModel? bookActivityModel;
  CourseDetailsModel? course;
  EventDetailsModel? event;
  VoidCallback? onRefresh;

  ConfirmBookingScreen({
    super.key,
    required this.type,
    this.activity,
    this.bookActivityModel,
    this.course,
    this.event,
    this.onRefresh
  });

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {

  dynamic get item {
    if (widget.activity != null) return widget.activity!;
    if (widget.course != null) return widget.course!;
    if (widget.event != null) return widget.event!;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final data = item;
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: CustomHeader(title: AppLocalization.of(context).translate("confirm_booking"),isNavBar: false,
        leading: InkWell(
          onTap: () {
            Navigation.pop();
          },
          child: Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedImage(
              imageUrl: data.mediaList!.isEmpty ? "" : data.mediaList!.first.url!,
              fit: BoxFit.cover,
              width: 1.sw,
              height: 275.h,
              borderRadius: 15.r,
            ),
            SizedBox(height: 15.h),
            Text(data.name!, textAlign: TextAlign.center,style: AppTheme.headlineMedium.copyWith(color: AppColors.darkGrayColor)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.type, textAlign: TextAlign.center,style: AppTheme.headlineSmall.copyWith(color: AppColors.purpleColor)),
                Text(" /    ", textAlign: TextAlign.center,style: AppTheme.headlineSmall.copyWith(color: AppColors.mediumGrayColor)),
                Text(data.category!.name!, textAlign: TextAlign.center,style: AppTheme.headlineSmall.copyWith(color: AppColors.mediumGrayColor)),
              ],
            ),
            SizedBox(height: 10.h),
            widget.activity != null ? Column(
                children: [
                  Text(convertDate(date: widget.bookActivityModel!.date.toString(),format: "EEEE MMMM"), textAlign: TextAlign.center,style: AppTheme.headlineMedium.copyWith(fontSize: 20.sp,color: AppColors.mediumGrayColor.withOpacity(0.5))),
                  Text(convertDate(date: widget.bookActivityModel!.date.toString(),format: "dd"), textAlign: TextAlign.center,style: AppTheme.headlineMedium.copyWith(fontSize: 100.sp,color: AppColors.mediumGrayColor.withOpacity(0.5))),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                    decoration: BoxDecoration(
                        color: AppColors.grayColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50.r)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text("${widget.bookActivityModel!.slots![widget.bookActivityModel!.slotIndex!].startTime} - ${widget.bookActivityModel!.slots![widget.bookActivityModel!.slotIndex!].endTime}", textAlign: TextAlign.center,style: AppTheme.labelLarge),
                    ),
                  ),
                ],
              ) : widget.course != null ? SizedBox(
                height: 100.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.course!.workdaysList!.length,
                  itemBuilder: (context,index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(child: Text(widget.course!.workdaysList![index].day!,style: AppTheme.titleLarge)),
                          Flexible(child: Text("${widget.course!.workdaysList![index].start} - ${widget.course!.workdaysList![index].end}",style: AppTheme.labelLarge.copyWith(color: AppColors.mediumGrayColor))),
                        ],
                      ),
                    );
                  },
                )
            ) : Column(
              children: [
                SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.event!.workdaysList!.length,
                      itemBuilder: (context,index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(child: Text(widget.event!.workdaysList![index].day!,style: AppTheme.titleLarge)),
                              Flexible(child: Text("${widget.event!.workdaysList![index].start} - ${widget.event!.workdaysList![index].end}",style: AppTheme.labelLarge.copyWith(color: AppColors.mediumGrayColor))),
                            ],
                          ),
                        );
                      },
                    )
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomInfoWidget(
                      title: AppLocalization.of(context).translate("start_date"),
                      subTitle: convertDate(date: widget.event!.startDate!,format: "dd/MM/yyyy"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomInfoWidget(
                      title: AppLocalization.of(context).translate("end_date"),
                      subTitle: convertDate(date: widget.event!.endDate!,format: "dd/MM/yyyy")
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            CreateModel(
              withValidation: false,
              useCaseCallBack: (data) {
                if(widget.activity != null) {
                  return BookActivityUseCase(CategoryRepository()).call(
                      params: BookActivityParams(
                        activityId: widget.activity!.iD!,
                        sessionDuration: widget.activity!.sessionDuration!,
                        dayId: widget.bookActivityModel!.dayId!,
                        code: widget.bookActivityModel!.code!,
                        date: convertDate(date: widget.bookActivityModel!.date.toString(),format: "yyyy-MM-dd"),
                        time: widget.bookActivityModel!.slots!.isEmpty ? "" : widget.bookActivityModel!.slots![widget.bookActivityModel!.slotIndex!].startTime!,
                        note: widget.bookActivityModel!.note,
                      ));
                } else if (widget.course != null) {
                    return AttendCourseUseCase(CategoryRepository()).call(
                        params: AttendCourseParams(
                            courseId: widget.course!.iD!
                        ));
                } else {
                  return AttendEventUseCase(CategoryRepository()).call(
                      params: AttendEventParams(eventId: widget.event!.iD!));
                }
              },
              onSuccess: (result) async {
                Navigation.pop();
                if(widget.activity != null) {
                  Navigation.pop();
                  Dialogs.showSnackBar(context: context, message: AppLocalization.of(context).translate("activity_booked_successfully"));
                } else if(widget.course != null || widget.event != null) {
                  widget.onRefresh!.call();
                }
              },
              child: CustomButton(
                backgroundColor: AppColors.primaryColor,
                borderRadius: 10.r,
                buttonName: AppLocalization.of(context).translate("confirm"),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
