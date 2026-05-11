import 'package:centro/core/classes/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String convertDate({required String date, String? format}) {
  DateTime dateTime = DateTime.parse(date);
  DateTime fixedDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
  String dateFormat = DateFormat(format ?? 'dd/MM/yyyy').format(fixedDate);
  return dateFormat;
}

String timeAgo({required String dateTimeStr, required BuildContext context}) {
  final dateTime = DateTime.parse(dateTimeStr).toLocal();
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  if (difference.inSeconds < 60) {
    return '${difference.inSeconds}${AppLocalization.of(context).translate("second")}';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}${AppLocalization.of(context).translate("minute")}';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}${AppLocalization.of(context).translate("hour")}';
  } else {
    return '${difference.inDays}${AppLocalization.of(context).translate("day")}';
  }
}