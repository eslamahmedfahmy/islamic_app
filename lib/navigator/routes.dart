import 'package:flutter/material.dart';
import 'package:islam_app/navigator/routes_constant.dart';
import 'package:islam_app/old_version/page_new_update_app.dart';
import 'package:islam_app/pages/home/home_page.dart';
import 'package:islam_app/pages/remembrance/remembrance_waking.dart';
import 'package:islam_app/pages/remembrance/remembrances_evening.dart';
import 'package:islam_app/pages/remembrance/remembrances_morning.dart';
import 'package:islam_app/pages/remembrance/roquia.dart';
import 'package:islam_app/pages/remembrance/sabha.dart';
import 'package:islam_app/pages/sounds/islamic_songs.dart';
import 'package:islam_app/pages/sounds/stories.dart';
import 'package:islam_app/pages/splash_screen/splach_screen.dart';


Map<String, Widget Function(BuildContext)> routes = {
  // AppRoute.onBoarding: (context) => const OnBoarding(),
  AppRoute.homePage: (context) => HomePage(),
  AppRoute.remembrancesMorning: (context) => const RemembrancesMorning(),
  AppRoute.remembrancesEvening: (context) => const RemembrancesEvening(),
  AppRoute.roquia: (context) => const Roquia(),
  AppRoute.islamicSongs: (context) => IslamicSongs(),
  AppRoute.stories: (context) => Stories(),
  AppRoute.sabha: (context) => const Sabha(),
  AppRoute.pageNewUpdateApp: (context) => PageNewUpdateAppOld(),
  AppRoute.myCustomWidget: (context) => SplachScreen(),
  AppRoute.remembranceWaking: (context) => RemembranceWaking(),
};
