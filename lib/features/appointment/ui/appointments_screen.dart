import 'package:centro/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:centro/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:centro/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/tabs_widget.dart';
import 'package:centro/core/utils/validators/convert_date_time.dart';
import 'package:centro/features/appointment/data/appointment_repository/appointment_repository.dart';
import 'package:centro/features/appointment/data/model/court/court_appointment_details_model.dart';
import 'package:centro/features/appointment/data/usecase/course/course_appointments_usecase.dart';
import 'package:centro/features/appointment/data/usecase/court/all_court_appointments_usecase.dart';
import 'package:centro/features/appointment/data/usecase/event/event_appointments_usecase.dart';
import 'package:centro/features/appointment/widget/appointment_widget.dart';
import 'package:centro/core/ui/shared_widgets/calender_date_picker_widget.dart';
import 'package:centro/features/category/data/model/course/course_details_model.dart';
import 'package:centro/features/category/data/model/event/event_details_model.dart';
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
  DateTime? selectedDate;
  DateTime focusedDay = DateTime.now();

  Map<DateTime, List<dynamic>> appointmentsEvents = {};
  bool isLoadingDots = false;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _fetchCalendarDots();
  }

  Future<void> _fetchCalendarDots() async {
    setState(() {
      isLoadingDots = true;
      appointmentsEvents.clear();
    });

    try {
      if (selectedTab == 0) {
        final result = await AllCourtAppointmentsUseCase(AppointmentRepository()).call(
          params: AllCourtAppointmentsParams(GetListRequest(), date: null),
        );
        if(result.hasDataOnly) {
          for (var item in result.data!) {
            if (item.status == "accepted") {
              _addEventToMap(item.date);
            }
          }
        }
      } else if (selectedTab == 1) {
        final result = await CourseAppointmentsUseCase(AppointmentRepository()).call(
          params: CourseAppointmentsParams(GetListRequest(), date: null),
        );
        if(result.hasDataOnly) {
          for (var item in result.data!) {
            _addEventToMap(item.startDate);
          }
        }
      } else {
        final result = await EventAppointmentsUseCase(AppointmentRepository()).call(
          params: EventAppointmentsParams(GetListRequest(), date: null),
        );
        if(result.hasDataOnly) {
          for (var item in result.data!) {
            _addEventToMap(item.startDate);
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching dots: $e");
    }

    if (mounted) {
      setState(() {
        isLoadingDots = false;
      });
    }
  }

  void _addEventToMap(dynamic dateValue) {
    if (dateValue == null) return;

    DateTime? parsedDate;
    if (dateValue is DateTime) {
      parsedDate = dateValue;
    } else {
      parsedDate = DateTime.tryParse(dateValue.toString());
    }

    if (parsedDate != null) {
      final normalizedDay = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);

      if (appointmentsEvents[normalizedDay] == null) {
        appointmentsEvents[normalizedDay] = ['has_appointment'];
      }
    }
  }

  Widget _buildAppointmentList<T>({required String prefixKey, required RepositoryCallBack onFetch, required Widget Function(T item) onBuildItem}) {
    return SizedBox(
      height: 1.sh - 500.h,
      child: PaginationList<T>(
        key: ValueKey("${prefixKey}_$selectedDate"),
        scrollDirection: Axis.vertical,
        withPagination: true,
        onCubitCreated: (cub) {
          cubit = cub;
        },
        repositoryCallBack: onFetch,
        listBuilder: (list) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return onBuildItem(list[index]);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: const CustomHeader(title: "", isNavBar: true),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
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
                  _fetchCalendarDots();
                },
              ),
              SizedBox(height: 10.h),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(15.r)),
                child: calenderDatePickerWidget(
                  selectedDate: selectedDate ?? DateTime.now(),
                  focusedDay: focusedDay,
                  context: context,
                  eventsMap: appointmentsEvents,
                  onDateChanged: (date) {
                    setState(() {
                      selectedDate = date;
                      focusedDay = date;
                    });
                  },
                ),
              ),
              SizedBox(height: 10.h),
              if (selectedTab == 0)
                _buildAppointmentList<CourtAppointmentDetailsModel>(
                  prefixKey: "court",
                  onFetch: (m) => AllCourtAppointmentsUseCase(AppointmentRepository()).call(
                      params: AllCourtAppointmentsParams(m,
                          date: convertDate(date: selectedDate.toString(), format: "yyyy/MM/dd")
                      )),
                  onBuildItem: (item) => AppointmentWidget(courtAppointment: item,
                      onRefresh: () async {
                        await cubit.getList();
                        await _fetchCalendarDots();
                      }),
                )
              else if (selectedTab == 1)
                _buildAppointmentList<CourseDetailsModel>(
                  prefixKey: "course",
                  onFetch: (m) => CourseAppointmentsUseCase(AppointmentRepository()).call(
                      params: CourseAppointmentsParams(m,
                          date: convertDate(date: selectedDate.toString(), format: "yyyy/MM/dd")
                      )),
                  onBuildItem: (item) => AppointmentWidget(courseAppointment: item)
                )
              else
                _buildAppointmentList<EventDetailsModel>(
                  prefixKey: "event",
                  onFetch: (m) => EventAppointmentsUseCase(AppointmentRepository()).call(
                      params: EventAppointmentsParams(m,
                          date: convertDate(date: selectedDate.toString(), format: "yyyy/MM/dd")
                      )),
                  onBuildItem: (item) => AppointmentWidget(eventAppointment: item),
                ),
            ],
          ),
        )
    );
  }
}
