import 'package:flutter/material.dart';
import 'package:islam_app/pages/home/bottom_navigation_bar.dart';

class BottomNavigationBarOld extends StatefulWidget {
  BottomNavigationBarOld({super.key});
  /*
  bottom navigation bar لو المسخدم ضغط علي المتابعه علي التحديث القديم دي الخاصه بعرض الشاشه الرائسيه لان شاشه  bottom navigation bar دي الصفحه الخاصه ب
 هيا الي بيتم اختيار الصفحات الي يتم عرضها منها
*/
  @override
  State<BottomNavigationBarOld> createState() => _BottomNavigationBarOldState();
}

class _BottomNavigationBarOldState extends State<BottomNavigationBarOld> {
  @override
  Widget build(BuildContext context) {
    // دي كده مربوطه مع الصفحه الرائسيه يعني اي شيء يحصل في الصفحه الرائسيه يتم عرضه في صفحه  المتابعه علي التحديث الجديد
    return bottomNavigationBarPage();
  }
}
