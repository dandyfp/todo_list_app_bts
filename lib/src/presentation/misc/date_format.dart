import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class FormatDate {
  String formatDate(date, {format = 'EEE, dd MMM yyyy', context}) {
    initializeDateFormatting();
    return DateFormat(format, 'id_ID').format(
      DateTime.parse(date).toLocal(),
    );
  }

  String formatTime(date, context) {
    initializeDateFormatting();
    return DateFormat.jm(Localizations.localeOf(context).languageCode).format(
      DateTime.parse(date).toLocal(),
    );
  }

  String formatTime24(date, context) {
    initializeDateFormatting();
    return date == null
        ? '-'
        : DateFormat.Hm(Localizations.localeOf(context).languageCode).format(
            DateTime.parse(date).toLocal(),
          );
  }

  String isTodayOrTommorow(date, context) {
    initializeDateFormatting();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dateToCheck = date;
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    String code = Localizations.localeOf(context).languageCode;
    if (code == 'id') {
      if (aDate == today) {
        return 'Hari ini,';
      } else if (aDate == tomorrow) {
        return 'Besok,';
      } else {
        return '';
      }
    } else {
      if (aDate == today) {
        return 'Today,';
      } else if (aDate == tomorrow) {
        return 'Tomorrow,';
      } else {
        return '';
      }
    }
  }

  String formatDashboard(date, context) {
    initializeDateFormatting();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dateToCheck = date;
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return 'Today at ${formatDate(date.toString(), format: 'h:mm a', context: context)}';
    } else if (aDate == tomorrow) {
      return 'Tomorrow at ${formatDate(date.toString(), format: 'h:mm a', context: context)}';
    } else {
      return formatDate(date.toString(), context: context);
    }
  }
}
