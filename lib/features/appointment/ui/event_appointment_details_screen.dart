import 'package:centro/core/boilerplate/get_model/cubits/get_model_cubit.dart';
import 'package:centro/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart' as image;
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/constants/end_point.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/icon_text_widget.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:centro/core/utils/validators/convert_date_time.dart';
import 'package:centro/features/appointment/widget/appointment_item_widget.dart';
import 'package:centro/features/appointment/widget/status_widget.dart';
import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
import 'package:centro/features/category/data/usecase/event/event_details_usecase.dart';
import 'package:centro/features/category/ui/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventAppointmentDetailsScreen extends StatefulWidget {

  int eventId;

  EventAppointmentDetailsScreen({super.key,required this.eventId});

  @override
  State<EventAppointmentDetailsScreen> createState() => _EventAppointmentDetailsScreenState();
}

class _EventAppointmentDetailsScreenState extends State<EventAppointmentDetailsScreen> {

  GetModelCubit<EventDetailsModel>? eventCubit;

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: CustomHeader(title: "", isNavBar: false),
        body: GetModel<EventDetailsModel>(
          onCubitCreated: (cubit) {
            eventCubit = cubit as GetModelCubit<EventDetailsModel>;
          },
          useCaseCallBack: () {
            return EventDetailsUseCase(CategoryRepository()).call(
                params: EventDetailsParams(eventId: widget.eventId));
          },
          modelBuilder: (model) => SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
            child: Column(
              children: [
                AppointmentItemWidget(
                    onTap: () {
                      Navigation.push(EventDetailsScreen(eventId: model.iD!));
                    },
                    imageUrl: model.mediaList!.isNotEmpty ? serverUrl + model.mediaList!.first.url! : "",
                    title: model.name!,
                    category: model.category!.name!,
                    description: model.description!,
                    rating: model.rate!.toDouble(),
                    price: "${model.admissionFee} ${AppLocalization.of(context).translate("syr")}"
                ),
                SizedBox(height: 10.h),
                Card(
                  color: AppColors.whiteColor,
                  elevation: 3,
                  shadowColor: AppColors.gray2Color,
                  child: Container(
                    width: 1.sw,
                    margin: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalization.of(context).translate("about_appointment"),
                          style: AppTheme.headlineMedium,
                        ),
                        SizedBox(height: 20.h),
                        StatusWidget(
                          statusText: model.status!,
                          statusColor: model.status! == "pending" ?
                          AppColors.mediumGrayColor : model.status! == "canceled" ?
                          AppColors.redColor : model.status! == "completed" ?
                          AppColors.purpleColor : AppColors.darkGreenColor,
                          width: 0.25.sw,
                          height: isTablet ? 35.h : 32.h,
                        ),
                        SizedBox(height: 20.h),
                        IconTextWidget(
                          icon: image.appointment,
                          iconSize: 20.w,
                          text: convertDate(date: model.startDate!,format: 'dd/MM/yyyy'),
                          textStyle: AppTheme.labelLarge.copyWith(
                              fontSize: 18.sp, color: AppColors.mediumGrayColor),
                        ),
                        SizedBox(height: 10.h),
                        IconTextWidget(
                          icon: image.capacity,
                          iconSize: 25.sp,
                          text: model.capacity.toString(),
                          textStyle: AppTheme.labelLarge.copyWith(color: AppColors.mediumGrayColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
