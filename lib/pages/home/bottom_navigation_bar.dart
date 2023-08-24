// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/controller/bottom_navigation_bar_controller.dart';
import 'package:islam_app/pages/home/home_page.dart';
import 'package:islam_app/pages/quran/quran_page.dart';
import 'package:islam_app/pages/remembrance/remembrance_group.dart';

// // bottom navigation bar دي الصفحه الخاصه ب

class bottomNavigationBarPage extends GetView<HomeController> {
  bottomNavigationBarPage({super.key});
// // screens الخاص بعرض ال bottom navigation bar دي المكان الي خاص ب
  static List screens = [
    QuranPage(),
    HomePage(),
    RemembranceGroup(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: screens[controller.index.value],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_stories_outlined, size: 25),
              label: ('القرآن الكريم'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 25),
              label: ('الصفحة الرئيسية'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups, size: 25),
              label: ('أذكار'),
            ),
          ],
          selectedItemColor: KColorPurpleApp,
          currentIndex: controller.index.value,
          onTap: (value) {
            controller.index.value = value;
          },
        ),
      ),
    );
  }
}
