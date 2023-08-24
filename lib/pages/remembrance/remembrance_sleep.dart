import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:islam_app/components/remembrance.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/data/list/lsit_remembrances.dart/remembrance_sleep.dart';
import 'package:share_plus/share_plus.dart';

class RemembranceSleep extends StatelessWidget {
  const RemembranceSleep({super.key});
//      أذكار النوم
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: KColorWhite,
        elevation: 0,
        title: Text(
          'أذكار النوم',
          style: TextStyle(
            color: KColorPurpleApp,
            fontFamily: 'Cairo',
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
          // color: KColorBlack,
        ),
      ),
      body: ListView.builder(
        itemCount: remembranceSleep.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              RemembranceComponent(
                textNumber: remembranceSleep[index].textNumber,
                text2: remembranceSleep[index].text,
                repeatNumber: remembranceSleep[index].repeat,
                copy: () {
                  FlutterClipboard.copy(remembranceSleep[index].text).then(
                    (value) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: KColorGreen,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'تم النسخ',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: KColorBlackIcon,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                share: () {
                  Share.share(remembranceSleep[index].text);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
