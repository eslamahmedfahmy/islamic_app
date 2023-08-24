import 'package:flutter/material.dart';
import 'package:islam_app/constant/urlApp.dart';
import 'package:islam_app/old_version/bottom_navigation_bar_old.dart';
import 'package:url_launcher/url_launcher.dart';

class AttentionHome extends StatelessWidget {
  AttentionHome({super.key});
//  الصفحه دي خاصه ان لما ينزل تحديث جديد تظهر ان في تحديث جديد ويطلب منه التحديث
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationBarOld()));
            },
            child: const Text(
              'المتابعه علي الاصدار القديم',
              style: TextStyle(color: Colors.red),
            )),
        TextButton(
            // دي خاصه بان لما اضغط علي زر يفتح لي الرابط ده
            onPressed: () async {
              if (!await launchUrl(urlApp,
                  //  السطر ده علشان يفتح الرابط خارج التطبيق
                  mode: LaunchMode.externalApplication)) {
                throw 'تعذر الإطلاق $urlApp';
              }
            },
            child: const Text(
              'تحديث',
              style: TextStyle(color: Colors.red),
            )),
      ],
      content: const Text(
          'لم يعد هذا الإصدار من islam مدعوما. يرجى التحديث إلى أحدث إصدار.'),
    );
  }
}
