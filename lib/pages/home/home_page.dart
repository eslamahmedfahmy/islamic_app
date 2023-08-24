import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/pages/menu_app_bar/menu.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:islam_app/widget/home_widget/items_home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/bottom_navigation_bar_controller.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({super.key});
// دي الصفحه الرئيسية
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  الكود ده لخاصيه الي بشريط التنقل السفلي الي هو الزر التحكم لي الخروج والرجوع الي بيكون موجود في الهاتف تحت في اسفل الشاشه هذا الكون مسؤل علي تغير اللون حسب حاله التطبيق
  late ValueNotifier<Brightness> _brightness;
  late SystemUiOverlayStyle _currentOverlayStyle;
  late SharedPreferences _prefs;
//  وضع الزر بنهار
  static const SystemUiOverlayStyle dayOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarDividerColor: Color(0xfff7f7f7),
    systemNavigationBarColor: Color(0xfff7f7f7),
    systemNavigationBarIconBrightness: Brightness.dark,
  );
// وضع الليلي لشكل الزر
  static const SystemUiOverlayStyle nightOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarDividerColor: Color(0xff081D57),
    systemNavigationBarColor: Color(0xff081D57),
    systemNavigationBarIconBrightness: Brightness.light,
  );

  @override
  void initState() {
    super.initState();
    _brightness = ValueNotifier(Brightness.light);
    _currentOverlayStyle = dayOverlayStyle;

    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;

      // SharedPreferences استرداد قيمة السطوع المحفوظة من
      final isDarkModeEnabled = _prefs.getBool('isDarkModeEnabled') ?? false;

      // تحديث السطوع ونمط التراكب وفقًا لذلك
      _brightness.value =
          isDarkModeEnabled ? Brightness.dark : Brightness.light;
      _currentOverlayStyle =
          isDarkModeEnabled ? nightOverlayStyle : dayOverlayStyle;

      // تحديث نمط تراكب النظام على الفور
      SystemChrome.setSystemUIOverlayStyle(_currentOverlayStyle);
    });

    // استمع إلى تغييرات السطوع وقم بتحديث نمط التراكب
    _brightness.addListener(() {
      _currentOverlayStyle = _brightness.value == Brightness.light
          ? dayOverlayStyle
          : nightOverlayStyle;
      SystemChrome.setSystemUIOverlayStyle(_currentOverlayStyle);

      // SharedPreferences حفظ قيمة السطوع الحالية في
      _prefs.setBool('isDarkModeEnabled', _brightness.value == Brightness.dark);
    });
  }

  @override
  void dispose() {
    _brightness.dispose();
    super.dispose();
  }

  void toggleBrightness() {
    _brightness.value = _brightness.value == Brightness.light
        ? Brightness.dark
        : Brightness.light;
  }
// .....................

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: KColorWhite,
          elevation: 0,
          title: Text(
            'الرئيسية',
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
              // color: KColorBlack,
            ),
          ),
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
        ),
        body: ItemsHome());
  }
}
