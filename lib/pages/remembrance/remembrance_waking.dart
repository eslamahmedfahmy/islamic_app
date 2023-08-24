import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:islam_app/components/remembrance.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/data/list/lsit_remembrances.dart/lsit_remembrance_waking.dart';
import 'package:share_plus/share_plus.dart';

class RemembranceWaking extends StatelessWidget {
  const RemembranceWaking({super.key});
//      'أذكار الإستيقاظ',
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'أذكار الإستيقاظ',
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
        ),
      ),
      body: ListView.builder(
        itemCount: remembranceWaking.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              RemembranceComponent(
                textNumber: remembranceWaking[index].textNumber,
                text2: remembranceWaking[index].text,
                repeatNumber: remembranceWaking[index].repeat,
                copy: () {
                  FlutterClipboard.copy(remembranceWaking[index].text).then(
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
                  Share.share(remembranceWaking[index].text);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
