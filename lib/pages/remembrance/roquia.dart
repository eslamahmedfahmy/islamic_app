import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islam_app/components/card_roquia_quran.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/data/list/lsit_remembrances.dart/roquia/public_archiving.dart';
import 'package:islam_app/data/list/lsit_remembrances.dart/roquia/ruqyah_quran.dart';
import 'package:islam_app/data/list/lsit_remembrances.dart/roquia/ruqyah_sunnah_prophet.dart';
import 'package:islam_app/pages/sounds/voice_roquia.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:islam_app/shared/message_appears_only_once.dart';
import 'package:provider/provider.dart';

class Roquia extends StatefulWidget {
  const Roquia({super.key});

  @override
  State<Roquia> createState() => _RoquiaState();
}

// الرقيه الشرعيه
class _RoquiaState extends State<Roquia> {
  TextStyle textStyleFont =
      TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back, size: 30)),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: Theme.of(context).brightness == Brightness.light
                      ? [KColorGreen, KColorRed]
                      : [KColorBlackIcon, KColorDarkApp],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft),
            ),
          ),
          title: const Text('الرقية الشرعية'),
          bottom: TabBar(
            indicatorWeight: 3,
            tabs: [
              Text('القرآن الكريم'),
              Text('السنة النبوية'),
              Text('إرشادات عامة'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  //  من القران الكريم
                  ListView(
                    children: [
                      // صفحه الرقية الشرعية صوت
                      ElevatedButton(
                        onPressed: () => Get.to(VoiceRoquia()),
                        child: Text(
                          'قم بالضغط هنا للاستماع لي الرقية الشرعية صوت',
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? KColorWhite
                                : Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white12,
                          minimumSize:
                              Size(double.infinity, 65), // الحجم الأدنى للزر
                        ),
                      ),
                      MessageAppearsOnlyOnce(),
                      //  'الرُّقية الشرعية من القرآن الكريم'
                      CardRoquiaQuran(text: ruqyahQuran[0].text),
                      CardRoquiaQuran(text: ruqyahQuran[1].text),
                      CardRoquiaQuran(text: ruqyahQuran[2].text),
                      CardRoquiaQuran(text: ruqyahQuran[3].text),
                      CardRoquiaQuran(text: ruqyahQuran[4].text),
                      CardRoquiaQuran(text: ruqyahQuran[5].text),
                      CardRoquiaQuran(text: ruqyahQuran[6].text),
                      CardRoquiaQuran(text: ruqyahQuran[7].text),
                      CardRoquiaQuran(text: ruqyahQuran[8].text),
                    ],
                  ),

                  //  السنة النبوية
                  ListView(
                    children: [
                      // صفحه الرقية الشرعية صوت
                      ElevatedButton(
                        onPressed: () => Get.to(VoiceRoquia()),
                        child: Text(
                          'قم بالضغط هنا للاستماع لي الرقية الشرعية صوت',
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? KColorWhite
                                : Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white12,
                          minimumSize:
                              Size(double.infinity, 65), // الحجم الأدنى للزر
                        ),
                      ),

                      // 'الرُّقية الشرعية من السنة النبوية'
                      CardRoquiaQuran(text: ruqyahSunnahProphet[0].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[1].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[2].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[3].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[4].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[5].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[6].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[7].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[8].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[9].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[10].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[11].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[12].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[13].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[14].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[15].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[16].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[17].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[18].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[19].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[20].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[21].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[22].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[23].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[24].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[25].text),
                      CardRoquiaQuran(text: ruqyahSunnahProphet[26].text),
                    ],
                  ),
                  // إرشادات عامة
                  ListView(
                    padding: EdgeInsets.all(10),
                    children: [
                      Text(publicArchiving[0].text, style: textStyleFont),
                      Text(publicArchiving[1].text, style: textStyleFont),
                      Text(publicArchiving[2].text, style: textStyleFont),
                      Text(publicArchiving[3].text, style: textStyleFont),
                      Text(publicArchiving[4].text, style: textStyleFont),
                      Text(publicArchiving[5].text, style: textStyleFont),
                      Text(publicArchiving[6].text, style: textStyleFont),
                      Text(publicArchiving[7].text, style: textStyleFont),
                      Text(publicArchiving[8].text, style: textStyleFont),
                      Text(publicArchiving[9].text, style: textStyleFont),
                      Text(publicArchiving[10].text, style: textStyleFont),
                      Text(publicArchiving[11].text, style: textStyleFont),
                      Text(publicArchiving[12].text, style: textStyleFont),
                      Text(publicArchiving[13].text, style: textStyleFont),
                      Text(publicArchiving[14].text, style: textStyleFont),
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
