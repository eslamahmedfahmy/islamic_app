import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:provider/provider.dart';

//  أدعية الأنبياء
class RemembranceComponentTest extends StatelessWidget {
  RemembranceComponentTest({
    super.key,
    this.textNumber,
    this.repeatNumber,
    this.copy,
    this.share,
    this.text2,
    this.text3,
  });

  Color colorNumber = Color(0xffF7F7F7);

  String? textNumber;
  String? repeatNumber;
  VoidCallback? copy;
  VoidCallback? share;
  String? text2;
  String? text3;

  TextStyle textStyleFont =
      TextStyle(fontFamily: 'Quran', fontSize: 20, fontWeight: FontWeight.w600);
  Color colorDivider = Color(0xffF5F5F5);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: themeProvider.isDarkModeEnabled ? Colors.black : Colors.grey,
          width: 2.0,
        ),
      ),
      elevation: 2,
      // color: KColorWhite,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  textNumber!,
                  style: TextStyle(
                    fontSize: 25,
                    // color: Colors.black45,
                  ),
                ),
                SizedBox(width: 4),
                Stack(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 190,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'عدد المرات : ',
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              repeatNumber!,
                              style:
                                  TextStyle(fontSize: 22, color: KColorAmber),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          color: themeProvider.isDarkModeEnabled
                              ? KColorblue
                              : colorDivider,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                IconButton(
                  onPressed: copy,
                  icon: Icon(
                    Icons.content_copy,
                    size: 30,
                  ),
                  color: KColorAmber,
                ),
                SizedBox(width: 25),
                IconButton(
                  onPressed: share,
                  icon: Icon(
                    Icons.share,
                    size: 30,
                  ),
                  color: KColorAmber,
                ),
              ],
            ),
            Text(
              text2!,
              style: textStyleFont,
            ),
            SizedBox(height: 10),
            Divider(
              color:
                  themeProvider.isDarkModeEnabled ? KColorblue : colorDivider,
              thickness: 3,
              // indent: 60,
              // endIndent: 60,
            ),
            Text(
              text3!,
            ),
          ],
        ),
      ),
    );
  }
}
