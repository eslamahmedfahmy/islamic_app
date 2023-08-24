import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/pages/home/bottom_navigation_bar.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:islam_app/widget/home_widget/attention.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatefulWidget {
  @override
  _SplachScreenState createState() => _SplachScreenState();
}

//  دي صفحه بدايه التطبيق الي لما اضغط علي الشاشه يفتح التطبيق
class _SplachScreenState extends State<SplachScreen>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  //  دي خاصه بانها تشوف الاصدار متناسق مع الاصدار الموجود ام لا
  Future<bool> remoteconfig() async {
    WidgetsFlutterBinding.ensureInitialized();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print('current version in app ${packageInfo.version}');
    String appVersion = packageInfo.version;
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 60),
        minimumFetchInterval: const Duration(seconds: 1)));
    await remoteConfig.fetchAndActivate();
    String remoteConfigVersion = remoteConfig.getString('appVersion');
    print('current version on firebase $remoteConfigVersion');

    if (remoteConfigVersion.compareTo(appVersion) == 1) {
      return true;
    } else {
      return false;
    }
  }
//  .........................

  @override
  void initState() {
    super.initState();
    scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                //  دي خاصه ان لما اضغط علي الزر يروح لي الصفحه الي محددها وفي الحاله دي الصفحه الرئسيه
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => bottomNavigationBarPage()));

                Timer(
                  Duration(milliseconds: 300),
                  () {},
                );
              }
            },
          );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 10.0).animate(scaleController);
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

//  ده الجزاء الي هيتعرض علي الشاشه في بدايه التطبيق
  @override
  Widget build(BuildContext c) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: FutureBuilder(
              future: remoteconfig(),
              builder: (context, snapshot) {
                final themeProvider = Provider.of<ThemeProvider>(context);

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return snapshot.data == true
                      //  في حاله ان في اصدار جديد يعرض الجزاء ده
                      ? AttentionHome()
                      //  ده الجزء الي هيعرض لو التطبيق شغال تمتم ومفيش اي تحديثات جديده
                      : Center(
                          child: InkWell(
                            onTap: () {
                              scaleController.forward();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'مرحبا بك في التطبيق',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                    color: KColorPurpleApp,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'قم بالضغط علي اي مكان في الشاشه لبدء التطبيق',
                                  style: Theme.of(context).textTheme.button,
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: themeProvider.isDarkModeEnabled
                                        ? KColorblue
                                        : KColorPurpleApp,
                                    // color: KColorPurpleApp,
                                    shape: BoxShape.circle,
                                  ),
                                  child: AnimatedBuilder(
                                    animation: scaleAnimation,
                                    builder: (c, child) => Transform.scale(
                                      scale: scaleAnimation.value,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: themeProvider.isDarkModeEnabled
                                              ? KColorblue
                                              : KColorPurpleApp,
                                          // color: KColorPurpleApp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset('assets/images/islamic.png'),
                              ],
                            ),
                          ),
                        );
                }
              })),
    );
  }
}

class AnimatingRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  AnimatingRoute({required this.page, required this.route})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: route,
          ),
        );
}
