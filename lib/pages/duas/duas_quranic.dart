import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:islam_app/components/remembrance.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/data/list/list_duas/list_duas_quranic.dart';
import 'package:share_plus/share_plus.dart';

class DuasQuranic extends StatelessWidget {
  const DuasQuranic({super.key});
//   'أدعية قرآنية'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'أدعية قرآنية',
          style: TextStyle(
            color: KColorPurpleApp,
            fontFamily: 'Cairo',
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: duasQuranic.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              RemembranceComponent(
                textNumber: duasQuranic[index].textNumber,
                text2: duasQuranic[index].text,
                repeatNumber: duasQuranic[index].repeat,
                copy: () {
                  FlutterClipboard.copy(duasQuranic[index].text).then(
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
                  Share.share(duasQuranic[index].text);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
