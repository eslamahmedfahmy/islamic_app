import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/pages/menu_app_bar/menu.dart';
import 'package:islam_app/pages/quran/surah_screen.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart';


class QuranPage extends StatefulWidget {
// الصفحه الرائسيه للقران الكريم الي بتظهر اسماء السور
  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "القرآن الكريم",
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: 114,
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        getSurahNameArabic(index + 1),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 25, fontFamily: 'Quran'),
                      ),
                    ),
                    SizedBox(width: 25),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themeProvider.isDarkModeEnabled
                            ? KColorPurpleApp
                            : Colors.green,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Quran',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahScreen(surahNumber: index + 1),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
