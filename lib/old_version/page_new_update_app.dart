import 'package:flutter/material.dart';
import 'package:islam_app/pages/home/home_page.dart';


// ignore: must_be_immutable
class PageNewUpdateAppOld extends StatelessWidget {
  PageNewUpdateAppOld({super.key});

// الصفحه دي خاصه بانها تتعرض للمستخدم في وجود تحديث جديد
//  يعني لو المستخدم عمل في الرساله الي بتظهر له
// PageNewUpdateApp المتابعه علي الاصدار القديم ففي الحاله دي يعرض الصفحه دي الي انا موجود فيها حالين دي

  @override
  Widget build(BuildContext context) {
    // دي كده مربوطه مع الصفحه الرائسيه يعني اي شيء يحصل في الصفحه الرائسيه يتم عرضه في صفحه  المتابعه علي التحديث الجديد
    return HomePage();
  }
}
