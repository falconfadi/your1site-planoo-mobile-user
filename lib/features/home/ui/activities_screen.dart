import 'package:centro/core/clasess/app_localization.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/ui/shared_widgets/custom_header.dart';
import 'package:centro/core/ui/shared_widgets/expandable_text_widget.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/home/data/model/activity_model.dart';
import 'package:centro/features/home/ui/booking_summary_screen.dart';
import 'package:centro/features/home/widget/service_widget.dart';
import 'package:centro/features/home/widget/session_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivitiesScreen extends StatefulWidget {

  String partnerType;
  final List<ActivityModel> allServices;
  ActivityModel? initiallySelected;

  ActivitiesScreen({required this.partnerType,required this.allServices, this.initiallySelected});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {

  late ActivityModel selectedService;
  late ScrollController _scrollController;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    selectedService = widget.initiallySelected ?? widget.allServices.first;

    // Preselect first available time
    final firstTime = selectedService.times.isNotEmpty
        ? "${selectedService.times.first.day}|${selectedService.times.first.time}"
        : null;

    selectedTime = firstTime;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = widget.allServices.indexOf(selectedService);
      if (index != -1) {
        _scrollController.animateTo(
          index * 100.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Map<String, List<String>> groupTimesByDay(ActivityModel service) {
    final Map<String, List<String>> dayToTimes = {};

    for (final time in service.times) {
      dayToTimes.putIfAbsent(time.day, () => []).add(time.time);
    }

    dayToTimes.forEach((_, list) => list.sort());
    return dayToTimes;
  }

  @override
  Widget build(BuildContext context) {
    final timesByDay = groupTimesByDay(selectedService);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomHeader(
        isNavBar: false,
        title: "",
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigation.push(BookingSummaryScreen());
                  },
                  child: Text(AppLocalization.of(context).translate("book_now"),
                      style: AppTheme.titleSmall.copyWith(color: AppColors.primaryColor)),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: widget.allServices.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                itemBuilder: (context,index) {
                  final service = widget.allServices[index];
                  final isSelected = service == selectedService;
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ServiceWidget(
                        name: service.name,
                        textStyle: AppTheme.labelSmall.copyWith(
                          color: isSelected ? Colors.blue : Colors.black,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        onTap: () {
                          setState(() {
                            selectedService = service;
                            selectedTime = service.times.isNotEmpty
                                ? "${service.times.first.day}|${service.times.first.time}"
                                : null;
                          });
                        },
                      )
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.gray2Color,
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0,1)
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(selectedService.name,
                          style: AppTheme.titleSmall,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      if(selectedService.type == "vip")
                        SvgPicture.asset(vip,width: 25.w)
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(selectedService.price.toStringAsFixed(2),
                    style: AppTheme.titleMedium.copyWith(color: AppColors.darkGreenColor),
                  ),
                  ExpandableTextWidget(
                    text: selectedService.description,
                    style: AppTheme.labelMedium
                  ),
                  SizedBox(height: 10.h),
                  Divider(),
                  ...timesByDay.entries.map((entry) {
                    final day = entry.key;
                    final times = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: SessionWidget(
                        day: day,
                        selectedTime: selectedTime ?? '',
                        times: times,
                        onSelected: (id) {
                          setState(() {
                            selectedTime = id;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: 80.h)
          ],
        ),
      ),
    );
  }
}
