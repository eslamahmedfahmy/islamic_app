import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:islam_app/components/alianbia.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/data/list/list_duas/list_duas_prophets.dart';
import 'package:share_plus/share_plus.dart';

class DuasProphets extends StatelessWidget {
  const DuasProphets({super.key});
//   'أدعية الأنبياء'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'أدعية الأنبياء',
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
        itemCount: duasProphets.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              RemembranceComponentTest(
                textNumber: duasProphets[index].textNumber,
                text2: duasProphets[index].text2,
                text3: duasProphets[index].text3,
                repeatNumber: duasProphets[index].repeat,
                copy: () {
                  FlutterClipboard.copy(duasProphets[index].copy).then(
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
                  Share.share(duasProphets[index].copy);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
