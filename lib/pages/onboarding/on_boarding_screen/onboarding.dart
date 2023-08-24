import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:islam_app/pages/onboarding/on_boarding_screen/start_screen.dart';
import 'package:islam_app/widget/home_widget/attention.dart';
import 'package:package_info_plus/package_info_plus.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: remoteconfig(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return snapshot.data == true
                  //  في حاله ان في اصدار جديد يعرض الجزاء ده
                  ? AttentionHome()
                  //  ده الجزاء الي هيتعرض لو هو شغال تمام ومفيش تحديث موجود
                  : StartScreen();
            }
          },
        ),
      ),
    );
  }
}
