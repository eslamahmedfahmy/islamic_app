import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/widget/home_widget/hijri_date.dart';

class ArabicDateTime extends StatefulWidget {
  @override
  _ArabicDateTimeState createState() => _ArabicDateTimeState();
}
// 
//  الصفحه دي مسؤوله علي عرض التاريخ الهجري والتاريخ الميلادي والوقت واليوم
class _ArabicDateTimeState extends State<ArabicDateTime> {
  late Timer _timer;
  late String _currentTime;
  late String _currentDay;
  late String _currentDate;

  @override
  void initState() {
    super.initState();
    _initTimer();
    _initDateTime();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _initTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        _initDateTime();
      }
    });
  }

  void _initDateTime() {
    var now = DateTime.now();
    var formatterTime = DateFormat('h:mm a', 'ar');
    var formattedTime = formatterTime.format(now);
    var formatterDay = DateFormat('EEEE', 'ar');
    var formattedDay = formatterDay.format(now);
    var formatterDate = DateFormat('dd MMMM yyyy', 'ar');
    var formattedDate = formatterDate.format(now);

    setState(() {
      _currentTime = formattedTime;
      _currentDay = formattedDay;
      _currentDate = formattedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: Theme.of(context).brightness == Brightness.light
                ? [KColorPurpleApp, KColorAmber]
                : [KColorSabha, KColorDarkApp],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft),
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // اليوم
            Text(
              '$_currentDay',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // الساعة
            Text(
              _currentTime,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            // التاريخ الهجري
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Row(
                children: [
                  HijriDate(),
                ],
              ),
            ),
            // التاريخ
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _currentDate,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
