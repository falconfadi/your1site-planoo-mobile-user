import 'package:centro/core/boilerplate/create_model/cubits/create_model_cubit.dart';
import 'package:centro/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:centro/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:centro/core/classes/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart' as image;
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/dialogs/dialogs.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/icon_text_widget.dart';
import 'package:centro/core/ui/widgets/custom_button.dart';
import 'package:centro/core/ui/widgets/custom_text_field.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/core/utils/extension/text_field_ext.dart';
import 'package:centro/core/utils/validators/convert_date_time.dart';
import 'package:centro/features/appointment/data/appointment_repository/appointment_repository.dart';
import 'package:centro/features/appointment/data/model/accepted_appointments_model.dart';
import 'package:centro/features/appointment/data/model/appointment_details_model.dart';
import 'package:centro/features/appointment/data/usecase/accepted_appointments_usecase.dart';
import 'package:centro/features/category/data/model/activity/book_activity_model.dart';
import 'package:centro/features/category/data/model/activity/slot_details_model.dart';
import 'package:centro/features/category/data/category_repository/category_repository.dart';
import 'package:centro/features/category/data/model/activity/activity_details_model.dart';
import 'package:centro/features/category/data/model/activity/slots_model.dart';
import 'package:centro/features/category/data/usecase/activity/check_activity_usecase.dart';
import 'package:centro/features/category/ui/confirm_booking_screen.dart';
import 'package:centro/core/ui/shared_widgets/calender_date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:centro/core/utils/form_utils/form_state_mixin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {

  final ActivityDetailsModel activity;

  const BookingScreen({super.key,required this.activity});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with FormStateMinxin {

  DateTime? selectedDate;
  DateTime focusedDay = DateTime.now();
  int? dayId;
  late Map<int, int> weekdayToDayId;
  late Set<int> allowedWeekdays;
  bool isCheck = false;
  CreateModelCubit? checkCubit;
  SlotModel? slotModel;
  List<SlotDetailsModel> slots = [];
  int? selectedSlot;
  final eventsMap = <DateTime, List<AppointmentDetailsModel>>{};

  @override
  void initState() {
    super.initState();
    weekdayToDayId = {};
    allowedWeekdays = {};
    for (var workday in widget.activity.workdaysList!) {
      final weekday = _mapDayToWeekday(workday.day!);
      weekdayToDayId[weekday] = workday.id!;
      allowedWeekdays.add(weekday);
    }
  }

  int _mapDayToWeekday(String day) {
    switch (day.toLowerCase()) {
      case 'monday': return DateTime.monday;
      case 'tuesday': return DateTime.tuesday;
      case 'wednesday': return DateTime.wednesday;
      case 'thursday': return DateTime.thursday;
      case 'friday': return DateTime.friday;
      case 'saturday': return DateTime.saturday;
      case 'sunday': return DateTime.sunday;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: CustomHeader(title: AppLocalization.of(context).translate("book_an_appointment"),isNavBar: false,
        leading: InkWell(
          onTap: () => Navigation.pop(),
          child: Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            GetModel<AcceptedAppointmentsModel>(
              useCaseCallBack: () {
                return AcceptedAppointmentsUseCase(AppointmentRepository()).call(
                    params: AcceptedAppointmentsParams(ownerType: "activity"));
              },
              onSuccess: (result) {
                for (var appointment in result.appointmentsList ?? []) {
                  final date = DateTime.parse(appointment.date!);

                  final normalizedDate = DateTime(date.year, date.month, date.day);

                  if (eventsMap[normalizedDate] == null) {
                    eventsMap[normalizedDate] = [];
                  }

                  eventsMap[normalizedDate]!.add(appointment);
                }
              },
              modelBuilder: (model) => SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(15.r)
                  ),
                  child: calenderDatePickerWidget(
                    selectedDate: selectedDate ?? DateTime.now(),
                    focusedDay: focusedDay,
                    context: context,
                    allowedWeekdays: allowedWeekdays,
                    enabled: true,
                    onDateChanged: (date) {
                      final normalizedDay = DateTime(date.year, date.month, date.day);

                      final appointmentsForDay = eventsMap[normalizedDay] ?? [];

                      if (appointmentsForDay.isNotEmpty) {
                        Dialogs.showQuestion(context,
                          content: Column(
                            children: [
                              Text(AppLocalization.of(context).translate("your_appointments"),
                                style: AppTheme.titleLarge.copyWith(
                                    fontSize: 18.sp),
                              ),
                              SizedBox(height: 10.h),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: appointmentsForDay.length,
                                itemBuilder: (context, index) {
                                  final appointment = appointmentsForDay[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Column(
                                      children: [
                                        IconTextWidget(
                                          icon: image.appointment,
                                          iconSize: 15.w,
                                          iconColor: AppColors.primaryColor,
                                          text: convertDate(date: appointment.date!,format: 'dd/MM/yyyy'),
                                          textStyle: AppTheme.labelLarge.copyWith(
                                              fontSize: 18.sp, color: AppColors.mediumGrayColor),
                                        ),
                                        IconTextWidget(
                                          icon: image.time,
                                          iconSize: 17.w,
                                          iconColor: AppColors.primaryColor,
                                          text: DateFormat("HH:mm").format(DateFormat("HH:mm:ss").parse(appointment.time!)),
                                          textStyle: AppTheme.labelLarge.copyWith(
                                              fontSize: 18.sp, color: AppColors.mediumGrayColor),
                                        ),
                                        if (index < appointmentsForDay.length - 1)
                                         Divider(color: AppColors.grayColor)
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        );
                      }
                      
                      final weekday = date.weekday;
                      setState(() {
                        isCheck = false;
                        selectedDate = date;
                        focusedDay = date;
                        dayId = weekdayToDayId[weekday];
                      });
                      checkCubit!.createModel();
                    },
                    eventsMap: eventsMap
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            CreateModel(
              withValidation: false,
              onTap: () {},
              onCubitCreated: (cubit) {
                checkCubit = cubit as CreateModelCubit;
              },
              onSuccess: (SlotsModel model) async {
                setState(() {
                  slotModel = model.slot!;
                  slots = model.slot!.slots!;
                  isCheck = true;
                });
              },
              useCaseCallBack: (model) {
                return CheckActivityUseCase(CategoryRepository()).call(
                    params: CheckActivityParams(
                      activityId: widget.activity.iD!,
                      dayId: dayId!,
                      date: convertDate(date: selectedDate.toString(),format: "yyyy-MM-dd"),
                      sessionDuration: widget.activity.sessionDuration!,
                    )
                );
              },
              child: Center()
            ),
            SizedBox(height: 10.h),
            isCheck == true ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalization.of(context).translate("times"),
                        style: AppTheme.headlineMedium,
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                          height: 50.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: slots.length,
                            itemBuilder: (context,index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedSlot = index;
                                  });
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        color: selectedSlot == index ? AppColors.primaryColor.withOpacity(0.5) : AppColors.whiteColor,
                                        border: Border.all(color: selectedSlot == index ? Colors.transparent : AppColors.primaryColor.withOpacity(0.5))
                                    ),
                                    child: Center(child: Text("${slots[index].startTime} - ${slots[index].endTime}",style: AppTheme.labelLarge))
                                ),
                              );
                            },
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Form(
                  key: form.key,
                  child: CustomTextField(
                    autoFocus: false,
                    maxLine: 2,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: form.nodes[0],
                    textEditingController: form.controllers[0],
                    labelText: AppLocalization.of(context).translate("note"),
                  ),
                ),
                SizedBox(height: 30.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 2,child: SizedBox.shrink()),
                    Expanded(
                      child: CustomButton(
                        width: 1.sw,
                        backgroundColor: AppColors.primaryColor,
                        borderRadius: 10.r,
                        buttonName: AppLocalization.of(context).translate("add"),
                        function: () {
                          if(selectedSlot != null) {
                            Navigation.push(ConfirmBookingScreen(
                              type: AppLocalization.of(context).translate("activity"),
                              activity: widget.activity,
                              bookActivityModel: BookActivityModel(
                                  dayId: dayId!,
                                  code: slotModel!.code.toString(),
                                  date: selectedDate!,
                                  slots: slots,
                                  slotIndex: selectedSlot!,
                                  note: form.controllers[0].text
                                ),
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ) : Center(),
            SizedBox(height: 30.h),
          ],
        ),
      )
    );
  }

  @override
  int numberOfFields() => 1;
}
