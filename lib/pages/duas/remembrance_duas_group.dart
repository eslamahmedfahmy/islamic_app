import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/pages/duas/duas_prophets.dart';
import 'package:islam_app/pages/duas/duas_quranic.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:provider/provider.dart';

class GroupRemembranceDuas extends StatelessWidget {
  GroupRemembranceDuas({super.key});
  final String PathImage = 'assets/images/remembrance_cover';
//  دي صفحه تجميعه الأدعية

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'أدعية',
          style: TextStyle(
            color: KColorPurpleApp,
            fontFamily: 'Cairo',
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 35,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Get.to(DuasQuranic()),
              child: Stack(
                children: [
                  //  صوره أدعية قرآنية
                  Image(
                    image: AssetImage(themeProvider.isDarkModeEnabled
                        ? '$PathImage/1 مظلم.jpg'
                        : '$PathImage/2.png'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 75),
                      Text(
                        'أدعية قرآنية',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => Get.to(DuasProphets()),
              child: Stack(
                children: [
                  //  صوره أدعية الأنبياء
                  Image(
                    image: AssetImage(themeProvider.isDarkModeEnabled
                        ? '$PathImage/2 مظلم.jpg'
                        : '$PathImage/1.png'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 75),
                      Text(
                        'أدعية الأنبياء',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  ده الخاص بعمل الانمشن ان الصفحه وهيا بتفتح تفتح من تحت لفوق
class Duas extends PageRouteBuilder {
  final Widget page;

  Duas(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 500),
          reverseTransitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
              ),
            );
          },
        );
}
