import 'package:flutter/material.dart';
import 'package:islam_app/pages/onboarding/custombutton.dart';
import 'package:islam_app/pages/onboarding/customslider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
//  صفحه البدايه بتظهر اول مره المستخدم بيفتح فيها التطبيق
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: CustomSliderOnBoarding(),
          ),
          // هنا النص الخاص بالزر الي لما اضفط عليه ينتقل لي الصفحه الرئسيه
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Spacer(flex: 1),
                CustomButtonOnBoarding(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
