import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:islam_app/components/remembrance.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/data/list/lsit_remembrances.dart/remembrance_after_prayer.dart';
import 'package:share_plus/share_plus.dart';

class RemembranceAfterPrayer extends StatelessWidget {
  const RemembranceAfterPrayer({super.key});
//    أذكار بعد الصلاة
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'أذكار بعد الصلاة',
          style: TextStyle(
            color: KColorPurpleApp,
            fontFamily: 'Cairo',
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 35,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: remembranceAfterPrayer.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              RemembranceComponent(
                textNumber: remembranceAfterPrayer[index].textNumber,
                text2: remembranceAfterPrayer[index].text,
                repeatNumber: remembranceAfterPrayer[index].repeat,
                copy: () {
                  FlutterClipboard.copy(remembranceAfterPrayer[index].text)
                      .then(
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
                  Share.share(remembranceAfterPrayer[index].text);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
