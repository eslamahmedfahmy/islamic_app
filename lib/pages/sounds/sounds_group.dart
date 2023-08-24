import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/navigator/routes_constant.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:islam_app/shared/message_appears_only_once.dart';
import 'package:provider/provider.dart';

class SoundsGroup extends StatelessWidget {
  SoundsGroup({super.key});
  final String PathImage = 'assets/images/remembrance_cover';
//  دي صفحه تجميعه الاصوات

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'الأصوات',
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
              onTap: () => Navigator.pushNamed(context, AppRoute.islamicSongs),
              child: Stack(
                children: [
                  //  صوره اناشيد اسلاميه
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
                        'اناشيد اسلامية',
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
              onTap: () => Navigator.pushNamed(context, AppRoute.stories),
              child: Stack(
                children: [
                  //  صوره قصص الصحابة
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
                        'قصص الصحابة',
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
          
            MessageAppearsOnlyOnce(),
          ],
        ),
      ),
    );
  }
}

//  ده الخاص بعمل الانمشن ان الصفحه وهيا بتفتح تفتح من تحت لفوق
class Sounds extends PageRouteBuilder {
  final Widget page;

  Sounds(this.page)
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
