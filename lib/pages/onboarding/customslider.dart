import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/data/static/onboarding/list_static_root_imags.dart';
import 'package:sizer/sizer.dart';

class CustomSliderOnBoarding extends StatefulWidget {
  const CustomSliderOnBoarding({super.key});

  @override
  State<CustomSliderOnBoarding> createState() => _CustomSliderOnBoardingState();
}

class _CustomSliderOnBoardingState extends State<CustomSliderOnBoarding> {
//  ده الجزء الخاص فوق اعلي الي الصفحه في شاشه البدايه الي هو الصور الي في صفحه البدايه والنص والصوت الي في الاسفل
//  صفحه البدايه البتظهر اول مره المستخدم يحمل التطبيق فيها

  bool isLastPage = false;
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: (index) {
        setState(
          () {
            //  ده الجزاء الخاص ان التطبيق يعرض شاشه البدايه مره واحده
            currentPage = index;
            isLastPage = index == 2;
            // .........................
          },
        );
      },
      itemCount: onboardingList.length,
      itemBuilder: (context, index) {
        return SafeArea(
          child: Column(
            children: [
              // SizedBox(height: 1.h),
              Text(
                onboardingList[index].title!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    fontFamily: 'Cairo',
                    color: KColorPurpleApp),
              ),
              // SizedBox(height: 1.h),
              Image.asset(onboardingList[index].image!),
              SizedBox(height: 0.5.h),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  onboardingList[index].body!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 0,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                ),
              ),
              SizedBox(height: 1.5.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 26.h,
                    width: double.infinity,
                    child: Image.asset(onboardingList[index].imageCompile!),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
