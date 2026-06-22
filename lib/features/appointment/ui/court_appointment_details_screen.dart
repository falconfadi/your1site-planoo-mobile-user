import 'package:centro/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:centro/core/boilerplate/get_model/cubits/get_model_cubit.dart';
import 'package:centro/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart' as image;
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/constants/end_point.dart';
import 'package:centro/core/ui/dialogs/dialogs.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/icon_text_widget.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/validators/convert_date_time.dart';
import 'package:centro/features/appointment/data/appointment_repository/appointment_repository.dart';
import 'package:centro/features/appointment/data/model/court/court_appointment_details_model.dart';
import 'package:centro/features/appointment/data/usecase/court/court_appointment_details_usecase.dart';
import 'package:centro/features/appointment/data/usecase/court/cancel_court_appointment_usecase.dart';
import 'package:centro/features/appointment/widget/appointment_item_widget.dart';
import 'package:centro/features/appointment/widget/status_widget.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/utils/project_utils/status_type.dart';
import 'package:centro/features/category/ui/court_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CourtAppointmentDetailsScreen extends StatefulWidget {

  int appointmentId;
  VoidCallback? onRefresh;

  CourtAppointmentDetailsScreen({super.key,required this.appointmentId,this.onRefresh});

  @override
  State<CourtAppointmentDetailsScreen> createState() => _CourtAppointmentDetailsScreenState();
}

class _CourtAppointmentDetailsScreenState extends State<CourtAppointmentDetailsScreen> {

  GetModelCubit<CourtAppointmentDetailsModel>? refreshCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: CustomHeader(title: "", isNavBar: false),
        body: GetModel<CourtAppointmentDetailsModel>(
          onCubitCreated: (cubit) {
            refreshCubit = cubit as GetModelCubit<CourtAppointmentDetailsModel>;
          },
          useCaseCallBack: () {
            return CourtAppointmentDetailsUseCase(AppointmentRepository()).call(
                params: CourtAppointmentDetailsParams(appointmentId: widget.appointmentId));
          },
          modelBuilder: (model) => SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
            child: Column(
              children: [
                AppointmentItemWidget(
                    onTap: () {
                      Navigation.push(CourtDetailsScreen(courtId: model.holder!.id!));
                    },
                    imageUrl: model.holder!.holderImage != null ? serverUrl + model.holder!.holderImage!.url! : "",
                    title: model.holder!.name!,
                    category: model.holder!.category!.name!,
                    description: model.holder!.description!,
                    rating: model.holder!.rate!.toDouble(),
                    price: "${model.holder!.price} ${AppLocalization.of(context).translate("syr")}"
                ),
                SizedBox(height: 10.h),
                Card(
                  color: AppColors.whiteColor,
                  elevation: 3,
                  shadowColor: AppColors.gray2Color,
                  child: Container(
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
                          statusColor: StatusType().getStatusInfo(model.status!)["color"],
                          width: 0.25.sw,
                          height: 32.h,
                        ),
                        SizedBox(height: 20.h),
                        IconTextWidget(
                          icon: image.appointment,
                          iconSize: 20.w,
                          text: convertDate(date: model.date!,format: 'dd/MM/yyyy'),
                          textStyle: AppTheme.labelLarge.copyWith(
                              fontSize: 18.sp, color: AppColors.mediumGrayColor),
                        ),
                        SizedBox(height: 10.h),
                        IconTextWidget(
                          icon: image.time,
                          iconSize: 22.w,
                          text: DateFormat("HH:mm").format(DateFormat("HH:mm:ss").parse(model.time!)),
                          textStyle: AppTheme.labelLarge.copyWith(
                              fontSize: 18.sp, color: AppColors.mediumGrayColor),
                        ),
                        SizedBox(height: model.notes == null ? 0 : 10.h),
                        model.notes == null ? Center() :
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${AppLocalization.of(context).translate("note")}: ",
                              style: AppTheme.headlineMedium,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: Text(model.notes!,
                                  style: AppTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: (model.status == "canceled") ? 0 : 20.h),
                        Row(
                            children: [
                              (model.status == "accepted") ? Expanded(
                                child: CustomButton(
                                  height: 40.h,
                                  backgroundColor: AppColors.redColor,
                                  borderRadius: 10.r,
                                  buttonName: AppLocalization.of(context).translate("cancel"),
                                  function: () {
                                    Dialogs.showQuestion(context,
                                      title: "",content: Column(
                                        children: [
                                          ListTile(
                                            title: Text(AppLocalization.of(context).translate("are_you_sure") +
                                                AppLocalization.of(context).translate("?"),
                                              textAlign: TextAlign.center,
                                              style: AppTheme.headlineSmall.copyWith(color: AppColors.mediumGrayColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                      btnOk: CreateModel(
                                        withValidation: false,
                                        onTap: () {},
                                        onSuccess: (result) {
                                          Navigation.pop();
                                          refreshCubit!.getModel(silent: true);
                                          widget.onRefresh?.call();
                                        },
                                        useCaseCallBack: (_) {
                                          return CancelCourtAppointmentUseCase(AppointmentRepository()).call(
                                              params: CancelCourtAppointmentParams(appointmentId: model.iD!)
                                          );
                                        },
                                        child: CustomButton(
                                          height: 40.h,
                                          width: 1.sw,
                                          backgroundColor: AppColors.redColor,
                                          borderRadius: 10.r,
                                          buttonName: AppLocalization.of(context).translate("ok"),
                                          textStyle: AppTheme.headlineSmall.copyWith(color: AppColors.whiteColor),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ) : Expanded(child: Center()),
                            ]
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        )
    );
  }
}
