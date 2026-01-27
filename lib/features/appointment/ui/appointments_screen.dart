import 'package:centro/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:centro/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/tabs_widget.dart';
import 'package:centro/core/utils/validators/convert_date_time.dart';
import 'package:centro/features/appointment/data/appointment_repository/appointment_repository.dart';
import 'package:centro/features/appointment/data/model/appointment_details_model.dart';
import 'package:centro/features/appointment/data/usecase/all_appointments_usecase.dart';
import 'package:centro/features/appointment/widget/appointment_widget.dart';
import 'package:centro/core/ui/shared_widgets/calender_date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentsScreen extends StatefulWidget {

  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {

  int selectedTab = 0;
  late PaginationCubit cubit;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: CustomHeader(title: "", isNavBar: true),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabsWidget(
                selectedTab: selectedTab,
                inCenter: true,
                onTabChanged: (index) {
                  setState(() {
                    selectedTab = index;
                  });
                  cubit.getList();
                },
              ),
              SizedBox(height: 10.h),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(15.r)
                ),
                child: calenderDatePickerWidget(
                  selectedDate: selectedDate,
                  context: context,
                  onDateChanged: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 1.sh - 500.h,
                child: PaginationList<AppointmentDetailsModel>(
                  key: ValueKey("$selectedDate"),
                  scrollDirection: Axis.vertical,
                  withPagination: true,
                  onCubitCreated: (cub) {
                    cubit = cub;
                  },
                  repositoryCallBack: (model) {
                    return AllAppointmentsUseCase(AppointmentRepository()).call(
                        params: AllAppointmentsParams(model,
                          ownerType: selectedTab == 0 ?
                          "activity" : selectedTab == 1 ? "course" : "event",
                          date: convertDate(date: selectedDate.toString(),format: "yyyy/MM/dd"),
                        ));
                  },
                  listBuilder: (list) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context,index) {
                        return AppointmentWidget(
                          appointment: list[index],
                          onRefresh: () async {
                            await cubit.getList();
                          },
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        )
    );
  }
}
