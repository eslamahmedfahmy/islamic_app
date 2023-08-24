import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/pages/home/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class CustomButtonOnBoarding extends StatefulWidget {
  CustomButtonOnBoarding({super.key});

  @override
  State<CustomButtonOnBoarding> createState() => _CustomButtonOnBoardingState();
}

class _CustomButtonOnBoardingState extends State<CustomButtonOnBoarding> {
//  ده الزر الي موجود في صفحه البدايه الي لما اضغط عليه يفتح ليا الشاشه الرائسيه

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      height: 5.h,
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        onPressed: () async {
          //  ده الجزاء الخاص ان التطبيق يعرض شاشه البدايه مره واحده
          //  ولما اضغط علي التالي يعرض الصفحه الي متحداده
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      bottomNavigationBarPage()));

          // .........................
        },
        child: Text(
          'التالي',
          style: TextStyle(),
        ),
        textColor: KColorWhite,
        color: KColorDarkGreen,
      ),
    );
  }
}
