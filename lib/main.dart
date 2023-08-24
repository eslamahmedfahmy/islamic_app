// ignore_for_file: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/controller/bottom_navigation_bar_controller.dart';
import 'package:islam_app/navigator/routes.dart';
import 'package:islam_app/pages/onboarding/on_boarding_screen/onboarding.dart';
import 'package:islam_app/pages/splash_screen/splach_screen.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //  onboarding ده الجزاء الخاص ان التطبيق يعرض شاشه البدايه مره واحده
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider(),
      child: MyApp(showHome: showHome)));
  // .............................
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.showHome}) : super(key: key);
  final bool? showHome;
  final bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Get.put(HomeController());
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          theme: ThemeData(
            //  الوضع النهار
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 22, // الحجم الافتراضي للخط في الوضع النهاري
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
            appBarTheme: AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            iconTheme: IconThemeData(
                color: Colors.white), // لون الأيقونات في الوضع الليلي

            appBarTheme: AppBarTheme(
              backgroundColor: KColorDarkApp, // لون الخلفية في الوضع الليلي
              iconTheme: IconThemeData(color: Colors.white),
            ),

            cardColor: KColorDarkApp, // تغيير لون الـ Card في الوضع الليلي
            // تغيير لون ال BottomNavigationBarItem في الوضع الليلي
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor:
              Color(0xff102667), // تغيير لون Background في الوضع الليلي

              selectedItemColor: KColorDarkApp, // اللون الجديد
              unselectedItemColor:
              Colors.white, // لون BottomNavigationBarItem في الوضع الليلي
            ),
            //  الوضع الليلي
            colorScheme: ColorScheme.dark(
                primary: Colors.yellow, // لون ال Primary color في الوضع الليلي
                onPrimary: KColorDarkApp, // لون النص في الوضع الليلي
                surface: Colors.grey, // لون ال Surface في الوضع الليلي
                onSurface: Colors.white, // لون النص في الوضع الليلي
                secondary:
                Colors.orange, // لون ال Secondary color في الوضع الليلي
                onSecondary: KColorDarkApp // لون النص في الوضع الليلي
            ),
            // تغيير لون الخلفية الافتراضي للتطبيق في الوضع الليلي
            scaffoldBackgroundColor: KColorDarkApp,
            // تغيير لون الحدود لكل عناصر التطبيق في الوضع الليلي
            dividerColor: Colors.white,
            // تغيير لون الخط في جميع أنحاء التطبيق في الوضع الليلي
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 22,
                color: Colors.white, // تغيير لون الـ text في الوضع الليلي
              ),
              bodyText2: TextStyle(
                color: Colors.white, // تغيير لون الـ text في الوضع الليلي
              ),
              headline6: TextStyle(
                color: Colors.white, // تغيير لون الـ text في الوضع الليلي
              ),
            ),
          ),
          //  دي بتتاكد ان الوضع الحالي ليلي ولا نهار وتعرضه
          themeMode: themeProvider.isDarkModeEnabled
              ? ThemeMode.dark
              : ThemeMode.light,

          locale: Locale('ar', 'EG'),

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar', 'AE'), //  Arabic, no country code
          ],
          debugShowCheckedModeBanner: false,
          // initialRoute: AppRoute.onBoarding,
          // اول ما التطبيق يفتح لي اول مره فقط onboarding ده الجزاء الخاص ان التطبيق يعرض شاشه البدايه مره واحده
          routes: routes,
          home: Directionality(
            child: showHome! ? SplachScreen() : OnBoarding(),
            textDirection: TextDirection.ltr,
          ),
        );
      },
    );
  }
}