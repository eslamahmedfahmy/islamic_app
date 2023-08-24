import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:timer_builder/timer_builder.dart';

//  التاريخ الهجري
class HijriDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal("ar"); // تحويل المكتبة إلى اللغة العربية

    return Center(
      child: Column(
        children: [
          TimerBuilder.periodic(Duration(minutes: 1), // تحديث التاريخ كل دقيقة
              builder: (context) {
            return Text(
              "${DateTime.now().toHijri().toFormat("dd MMMM yyyy")}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }),
        ],
      ),
    );
  }
}

extension HijriDateTimeExtension on DateTime {
  HijriCalendar toHijri() {
    HijriCalendar hijriDate = HijriCalendar.fromDate(this);
    return hijriDate;
  }
}
