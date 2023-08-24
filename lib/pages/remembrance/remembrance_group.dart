import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/navigator/routes_constant.dart';
import 'package:islam_app/pages/menu_app_bar/menu.dart';
import 'package:islam_app/pages/remembrance/remembrance_after_prayer.dart';
import 'package:islam_app/pages/remembrance/remembrance_sleep.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:provider/provider.dart';



// ignore: must_be_immutable
class RemembranceGroup extends StatefulWidget {
  RemembranceGroup({super.key});

  @override
  State<RemembranceGroup> createState() => _RemembranceGroupState();
}

class _RemembranceGroupState extends State<RemembranceGroup> {
  final String PathImage = 'assets/images/remembrance_cover';

// دي صفحه تجميعه الأذكار
  SizedBox sizedBox = SizedBox(height: 15);

  // دي خاصه بشريط التنقل الي بيكون موجود في الهاتف تحت خالص الي هيا الازرار التنقل
// بيستخدم علشان يشوف حاله التطبيق ايه مظلم ام نهار
  ValueNotifier<Brightness> _brightness = ValueNotifier(Brightness.light);
// الوضع النهار
  static const SystemUiOverlayStyle dayOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarDividerColor: Color(0xfff7f7f7),
    systemNavigationBarColor: Color(0xfff7f7f7),
    systemNavigationBarIconBrightness: Brightness.dark,
  );
//  الوضع الليلي
  static const SystemUiOverlayStyle nightOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarDividerColor: Color(0xff081D57),
    systemNavigationBarColor: Color(0xff081D57),
    systemNavigationBarIconBrightness: Brightness.light,
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(dayOverlayStyle);
    _brightness.addListener(() {
      SystemChrome.setSystemUIOverlayStyle(
        _brightness.value == Brightness.light
            ? dayOverlayStyle
            : nightOverlayStyle,
      );
    });
  }

  @override
  void dispose() {
    _brightness.dispose();
    super.dispose();
  }
// ......................

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: themeProvider.isDarkModeEnabled
                ? Icon(Icons.light_mode_outlined, size: 27)
                : Icon(Icons.dark_mode_outlined, size: 27),
            onPressed: () {
              setState(() {
                themeProvider.toggleTheme();
                SystemChrome.setSystemUIOverlayStyle(
                    themeProvider.isDarkModeEnabled
                        ? nightOverlayStyle
                        : dayOverlayStyle);
              });
            },
          ),
        ],
        elevation: 0,
        title: Text(
          'أذكار',
          style: TextStyle(
            color: KColorPurpleApp,
            fontFamily: 'Cairo',
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, SlideTransitionMenu(Menu()));
          },
          icon: Icon(
            Icons.menu,
            size: 27,
          ),
        ),
      ),
      body: ListView(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(33),
              child: Column(
                children: [
                  GestureDetector(
                    // onTap: () => Get.to(Sabha()),
                    onTap: () => Navigator.pushNamed(context, AppRoute.sabha),
                    child: Stack(
                      children: [
                        //  صوره سبحة
                        Image(
                          image: AssetImage(themeProvider.isDarkModeEnabled
                              ? "$PathImage/2 مظلم.jpg"
                              : "$PathImage/4.png"),
                        ),
                        // Image.asset('$PathImage/4.png'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 75),
                            Text(
                              'سبحة',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBox,
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, AppRoute.remembrancesMorning),
                    child: Stack(
                      children: [
                        //  صوره اذكار الصباح
                        Image(
                          image: AssetImage(themeProvider.isDarkModeEnabled
                              ? "$PathImage/1 مظلم.jpg"
                              : "$PathImage/2.png"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 80),
                            Text(
                              'أذكار الصباح',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBox,
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, AppRoute.remembrancesEvening),
                    child: Stack(
                      children: [
                        //  صوره اذكار المساء
                        Image(
                          image: AssetImage(themeProvider.isDarkModeEnabled
                              ? "$PathImage/5 مظلم.jpg"
                              : "$PathImage/1.png"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 80),
                            Text(
                              'أذكار المساء',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBox,
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoute.roquia),
                    child: Stack(
                      children: [
                        //  صوره الرقية الشرعية
                        Image(
                          image: AssetImage(themeProvider.isDarkModeEnabled
                              ? "$PathImage/2 مظلم.jpg"
                              : "$PathImage/4.png"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 80),
                            Text(
                              'الرقية الشرعية',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBox,
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, AppRoute.remembranceWaking),
                    child: Stack(
                      children: [
                        //  صوره اذكار الاستيقاظ
                        Image(
                          image: AssetImage(themeProvider.isDarkModeEnabled
                              ? "$PathImage/4 مظلم.jpg"
                              : "$PathImage/3.png"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 80),
                            Text(
                              'أذكار الإستيقاظ',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBox,
                  GestureDetector(
                    onTap: () => Get.to(RemembranceSleep()),
                    child: Stack(
                      children: [
                        //  صوره اذكار النوم
                        Image(
                          image: AssetImage(themeProvider.isDarkModeEnabled
                              ? "$PathImage/2 مظلم.jpg"
                              : "$PathImage/4.png"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 80),
                            Text(
                              'أذكار النوم',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBox,
                  GestureDetector(
                    onTap: () => Get.to(RemembranceAfterPrayer()),
                    child: Stack(
                      children: [
                        //  صوره اذكار بعد الصلاة
                        Image(
                          image: AssetImage(themeProvider.isDarkModeEnabled
                              ? "$PathImage/6 مظلم.jpg"
                              : "$PathImage/3.png"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 80),
                            Text(
                              'أذكار بعد الصلاة',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
