import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

Widget calenderDatePickerWidget({
  required DateTime selectedDate,
  required DateTime focusedDay,
  required ValueChanged<DateTime> onDateChanged,
  required BuildContext context,
  Set<int>? allowedWeekdays,
  Map<DateTime, List<dynamic>>? eventsMap,
  bool enabled = true,
}) {
  return IgnorePointer(
    ignoring: !enabled,
    child: Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: TableCalendar(
          daysOfWeekHeight: Responsive.isTablet(context) ? 80 : 16,
          rowHeight: Responsive.isTablet(context) ? 80 : 52,
          eventLoader: (day) {
            final normalizedDay = DateTime(day.year, day.month, day.day);
            return eventsMap?[normalizedDay] ?? [];
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              if (events.isEmpty) return SizedBox();
              return Positioned(
                bottom: 8,
                child: Container(
                  width: Responsive.isTablet(context) ? 14 : 10,
                  height: Responsive.isTablet(context) ? 12 : 8,
                  decoration: BoxDecoration(
                    color: AppColors.redColor,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
            defaultBuilder: (context, day, focusedDay) {
              if (isSameDay(day, DateTime.now())) {
                return _todayCell(day, isDisabled: false);
              }
              return null;
            },
            disabledBuilder: (context, day, focusedDay) {
              if (isSameDay(day, DateTime.now())) {
                return _todayCell(day, isDisabled: true);
              }
              return null;
            },
          ),
          firstDay: DateTime(1900),
          lastDay: DateTime(2100),
          focusedDay: focusedDay,
          selectedDayPredicate: (day) =>
              isSameDay(day, selectedDate),

          enabledDayPredicate: (day) {
            if (allowedWeekdays == null) return true;
            return allowedWeekdays.contains(day.weekday);
          },

          onDaySelected: (selectedDay, focusedDay) {
            onDateChanged(selectedDay);
          },

          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: AppColors.purpleColor,
              shape: BoxShape.circle,
            ),
            todayTextStyle: AppTheme.bodyMedium.copyWith(
              color: AppColors.whiteColor,
            ),
            selectedDecoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            disabledTextStyle: AppTheme.bodyMedium.copyWith(
              color: AppColors.grayColor,
            ),
          ),
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: AppTheme.bodyLarge.copyWith(
              color: AppColors.primaryColor,
              fontSize: Responsive.isTablet(context) ? 20.sp : null
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: AppColors.primaryColor,
              size: Responsive.isTablet(context) ? 25.sp : null
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: AppColors.primaryColor,
              size: Responsive.isTablet(context) ? 25.sp : null
            ),
          ),
        ),
      ),
    ),
  );
}


Widget _todayCell(DateTime day, {required bool isDisabled}) {
  return Container(
    margin: EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: AppColors.purpleColor,
      shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child: Text(
      '${day.day}',
      style: AppTheme.bodyMedium.copyWith(
        color: isDisabled ? AppColors.whiteColor : AppColors.blackColor,
      ),
    ),
  );
}
