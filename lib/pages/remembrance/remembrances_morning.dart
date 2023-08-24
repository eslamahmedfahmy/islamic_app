import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:clipboard/clipboard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:islam_app/components/card_morning_evening.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/data/list/lsit_remembrances.dart/lsit_remembrances_morning.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class RemembrancesMorning extends StatefulWidget {
  const RemembrancesMorning({Key? key}) : super(key: key);
// اذكار الصباح
  @override
  State<RemembrancesMorning> createState() => _RemembrancesMorningState();
}

class _RemembrancesMorningState extends State<RemembrancesMorning> {
  int TextNumber0 = 1;
  int TextNumber1 = 3;
  int TextNumber2 = 1;
  int TextNumber3 = 1;
  int TextNumber4 = 1;
  int TextNumber5 = 4;
  int TextNumber6 = 1;
  int TextNumber7 = 3;
  int TextNumber8 = 3;
  int TextNumber9 = 7;
  int TextNumber10 = 1;
  int TextNumber11 = 1;
  int TextNumber12 = 3;
  int TextNumber13 = 3;
  int TextNumber14 = 3;
  int TextNumber15 = 100;
  int TextNumber16 = 3;
  int TextNumber17 = 100;
  int TextNumber18 = 1;
  int TextNumber19 = 1;
  int TextNumber20 = 1;
  int TextNumber21 = 10;
  int TextNumber22 = 100;
  // ويحفظه محلي في التطبيق ويصطتيع المستخدم استخدام الصوت بدون الانتصال بالانترنت يحتاج اول مره فقط ويستخدم هذا الكود لي صوت واحد فقط Firebase Storage يستخدم علشان يحمل الصوت من
  final player = AudioPlayer();
  bool isPlaying = false;
  bool isMaleList = true;
  String? downloadUrl;
  int songIndex = 0;

  @override
  void dispose() {
    player.dispose();
    player.pause();
    super.dispose();
  }

  @override
  void initState() {
    _loadAudio();
    super.initState();
  }

  void _playAudio() {
    if (isPlaying) {
      setState(() {
        isPlaying = false;
      });
      player.pause();
    } else {
      setState(() {
        isPlaying = true;
        isMaleList = false;
      });
      if (downloadUrl != null) {
        player.play(UrlSource(downloadUrl!));
      }
    }
  }

  Future<void> _loadAudio() async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref('remembrances/remembrances.mp3');
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File localFile = File(
          '${appDocDir.path}/remembrances.mp3'); // اسم الملف الذي سيتم حفظه
      if (await localFile.exists()) {
        print('تم تحميل الملف من التخزين المحلي');
        setState(() {
          downloadUrl = localFile.path;
        });
      } else {
        print('Firebase Storage. يتم تحميل الملف...');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ' يتم تحميل أذكار الصباح صوت',
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        await ref.writeToFile(localFile);
        setState(() {
          downloadUrl = localFile.path;
        });
      }
    } catch (e) {
      print('حدث خطأ أثناء التحميل: $e');
    }
  }
// .................

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextStyle textStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: themeProvider.isDarkModeEnabled ? KColorWhite : Colors.black45,
    );
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                setState(() {
                  player.pause();
                  isPlaying = false;
                });
                if (Navigator.canPop(context) && isPlaying == false) {
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.arrow_back, size: 30)),
          centerTitle: true,
          title: Text(
            'أذكار الصباح',
            style: TextStyle(color: KColorPurpleApp),
          ),
          actions: [
            IconButton(
              onPressed: () => _playAudio(),
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color:
                    themeProvider.isDarkModeEnabled ? KColorWhite : KColorBlack,
                size: 35,
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardMorningEveningComponent(
                  textNumberB:
                      Text(textRemembrancesMorning[0].repeat, style: textStyle),
                  color: TextNumber0 == 1 ? KColorAmber : Colors.red,
                  textNumber: Text(
                    '$TextNumber0',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber0 == 1 ? KColorAmber : Colors.red,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber0 >= 1) {
                      setState(() {
                        TextNumber0--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[0].text2,
                  text3: textRemembrancesMorning[0].text3,
                  repeatNumber: textRemembrancesMorning[0].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[0].copy).then(
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
                    Share.share(textRemembrancesMorning[0].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB:
                      Text(textRemembrancesMorning[1].repeat, style: textStyle),
                  color: TextNumber1 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber1',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber1 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber1 >= 1) {
                      setState(() {
                        TextNumber1--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[1].text2,
                  text3: textRemembrancesMorning[1].text3,
                  repeatNumber: textRemembrancesMorning[1].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[1].copy).then(
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
                    Share.share(textRemembrancesMorning[1].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB:
                      Text(textRemembrancesMorning[2].repeat, style: textStyle),
                  color: TextNumber2 == 1 ? KColorAmber : Colors.red,
                  textNumber: Text(
                    '$TextNumber2',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber2 == 1 ? KColorAmber : Colors.red,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber2 >= 1) {
                      setState(() {
                        TextNumber2--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[2].text2,
                  text3: textRemembrancesMorning[2].text3,
                  repeatNumber: textRemembrancesMorning[2].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[2].copy).then(
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
                    Share.share(textRemembrancesMorning[2].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB:
                      Text(textRemembrancesMorning[3].repeat, style: textStyle),
                  color: TextNumber3 == 1 ? KColorAmber : Colors.red,
                  textNumber: Text(
                    '$TextNumber3',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber3 == 1 ? KColorAmber : Colors.red,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber3 >= 1) {
                      setState(() {
                        TextNumber3--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[3].text2,
                  text3: textRemembrancesMorning[3].text3,
                  repeatNumber: textRemembrancesMorning[3].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[3].copy).then(
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
                    Share.share(textRemembrancesMorning[3].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB:
                      Text(textRemembrancesMorning[4].repeat, style: textStyle),
                  color: TextNumber4 == 1 ? KColorAmber : Colors.red,
                  textNumber: Text(
                    '$TextNumber4',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber4 == 1 ? KColorAmber : Colors.red,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber4 >= 1) {
                      setState(() {
                        TextNumber4--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[4].text2,
                  text3: textRemembrancesMorning[4].text3,
                  repeatNumber: textRemembrancesMorning[4].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[4].copy).then(
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
                    Share.share(textRemembrancesMorning[4].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB:
                      Text(textRemembrancesMorning[5].repeat, style: textStyle),
                  color: TextNumber5 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber5',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber5 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber5 >= 1) {
                      setState(() {
                        TextNumber5--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[5].text2,
                  text3: textRemembrancesMorning[5].text3,
                  repeatNumber: textRemembrancesMorning[5].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[5].copy).then(
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
                    Share.share(textRemembrancesMorning[5].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB:
                      Text(textRemembrancesMorning[6].repeat, style: textStyle),
                  color: TextNumber6 == 1 ? KColorAmber : Colors.red,
                  textNumber: Text(
                    '$TextNumber6',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber6 == 1 ? KColorAmber : Colors.red,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber6 >= 1) {
                      setState(() {
                        TextNumber6--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[6].text2,
                  text3: textRemembrancesMorning[6].text3,
                  repeatNumber: textRemembrancesMorning[6].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[6].copy).then(
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
                    Share.share(textRemembrancesMorning[6].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB:
                      Text(textRemembrancesMorning[7].repeat, style: textStyle),
                  color: TextNumber7 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber7',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber7 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber7 >= 1) {
                      setState(() {
                        TextNumber7--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[7].text2,
                  text3: textRemembrancesMorning[7].text3,
                  repeatNumber: textRemembrancesMorning[7].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[7].copy).then(
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
                    Share.share(textRemembrancesMorning[7].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB:
                      Text(textRemembrancesMorning[8].repeat, style: textStyle),
                  color: TextNumber8 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber8',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber8 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber8 >= 1) {
                      setState(() {
                        TextNumber8--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[8].text2,
                  text3: textRemembrancesMorning[8].text3,
                  repeatNumber: textRemembrancesMorning[8].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[8].copy).then(
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
                    Share.share(textRemembrancesMorning[8].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB:
                      Text(textRemembrancesMorning[9].repeat, style: textStyle),
                  color: TextNumber9 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber9',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber9 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber9 >= 1) {
                      setState(() {
                        TextNumber9--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[9].text2,
                  text3: textRemembrancesMorning[9].text3,
                  repeatNumber: textRemembrancesMorning[9].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[9].copy).then(
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
                    Share.share(textRemembrancesMorning[9].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[10].repeat,
                      style: textStyle),
                  color: TextNumber10 == 1 ? KColorAmber : Colors.red,
                  textNumber: Text(
                    '$TextNumber10',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber10 == 1 ? KColorAmber : Colors.red,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber10 >= 1) {
                      setState(() {
                        TextNumber10--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[10].text2,
                  text3: textRemembrancesMorning[10].text3,
                  repeatNumber: textRemembrancesMorning[10].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[10].copy)
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
                    Share.share(textRemembrancesMorning[10].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[11].repeat,
                      style: textStyle),
                  color: TextNumber11 == 1 ? KColorAmber : Colors.red,
                  textNumber: Text(
                    '$TextNumber11',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber11 == 1 ? KColorAmber : Colors.red,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber11 >= 1) {
                      setState(() {
                        TextNumber11--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[11].text2,
                  text3: textRemembrancesMorning[11].text3,
                  repeatNumber: textRemembrancesMorning[11].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[11].copy)
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
                    Share.share(textRemembrancesMorning[11].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[12].repeat,
                      style: textStyle),
                  color: TextNumber12 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber12',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber12 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber12 >= 1) {
                      setState(() {
                        TextNumber12--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[12].text2,
                  text3: textRemembrancesMorning[12].text3,
                  repeatNumber: textRemembrancesMorning[12].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[12].copy)
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
                    Share.share(textRemembrancesMorning[12].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[13].repeat,
                      style: textStyle),
                  color: TextNumber13 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber13',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber13 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber13 >= 1) {
                      setState(() {
                        TextNumber13--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[13].text2,
                  text3: textRemembrancesMorning[13].text3,
                  repeatNumber: textRemembrancesMorning[13].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[13].copy)
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
                    Share.share(textRemembrancesMorning[13].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[14].repeat,
                      style: textStyle),
                  color: TextNumber14 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber14',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber14 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber14 >= 1) {
                      setState(() {
                        TextNumber14--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[14].text2,
                  text3: textRemembrancesMorning[14].text3,
                  repeatNumber: textRemembrancesMorning[14].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[14].copy)
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
                    Share.share(textRemembrancesMorning[14].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[15].repeat,
                      style: textStyle),
                  color: TextNumber15 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber15',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber15 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber15 >= 1) {
                      setState(() {
                        TextNumber15--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[15].text2,
                  text3: textRemembrancesMorning[15].text3,
                  repeatNumber: textRemembrancesMorning[15].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[15].copy)
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
                    Share.share(textRemembrancesMorning[15].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[16].repeat,
                      style: textStyle),
                  color: TextNumber16 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber16',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber16 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber16 >= 1) {
                      setState(() {
                        TextNumber16--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[16].text2,
                  text3: textRemembrancesMorning[16].text3,
                  repeatNumber: textRemembrancesMorning[16].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[16].copy)
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
                    Share.share(textRemembrancesMorning[16].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[17].repeat,
                      style: textStyle),
                  color: TextNumber17 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber17',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber17 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber17 >= 1) {
                      setState(() {
                        TextNumber17--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[17].text2,
                  text3: textRemembrancesMorning[17].text3,
                  repeatNumber: textRemembrancesMorning[17].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[17].copy)
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
                    Share.share(textRemembrancesMorning[17].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[18].repeat,
                      style: textStyle),
                  color: TextNumber18 == 1 ? KColorAmber : Colors.red,
                  textNumber: Text(
                    '$TextNumber18',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber18 == 1 ? KColorAmber : Colors.red,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber18 >= 1) {
                      setState(() {
                        TextNumber18--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[18].text2,
                  text3: textRemembrancesMorning[18].text3,
                  repeatNumber: textRemembrancesMorning[18].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[18].copy)
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
                    Share.share(textRemembrancesMorning[18].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[19].repeat,
                      style: textStyle),
                  color: TextNumber19 == 1 ? KColorAmber : Colors.red,
                  textNumber: Text(
                    '$TextNumber19',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber19 == 1 ? KColorAmber : Colors.red,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber19 >= 1) {
                      setState(() {
                        TextNumber19--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[19].text2,
                  text3: textRemembrancesMorning[19].text3,
                  repeatNumber: textRemembrancesMorning[19].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[19].copy)
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
                    Share.share(textRemembrancesMorning[19].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[20].repeat,
                      style: textStyle),
                  color: TextNumber20 == 1 ? KColorAmber : Colors.red,
                  textNumber: Text(
                    '$TextNumber20',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber20 == 1 ? KColorAmber : Colors.red,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber20 >= 1) {
                      setState(() {
                        TextNumber20--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[20].text2,
                  text3: textRemembrancesMorning[20].text3,
                  repeatNumber: textRemembrancesMorning[20].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[20].copy)
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
                    Share.share(textRemembrancesMorning[20].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[21].repeat,
                      style: textStyle),
                  color: TextNumber21 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber21',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber21 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber21 >= 1) {
                      setState(() {
                        TextNumber21--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[21].text2,
                  text3: textRemembrancesMorning[21].text3,
                  repeatNumber: textRemembrancesMorning[21].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[21].copy)
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
                    Share.share(textRemembrancesMorning[21].copy);
                  },
                ),
                CardMorningEveningComponent(
                  textNumberB: Text(textRemembrancesMorning[22].repeat,
                      style: textStyle),
                  color: TextNumber22 == 0 ? Colors.red : KColorAmber,
                  textNumber: Text(
                    '$TextNumber22',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: TextNumber22 == 0 ? Colors.red : KColorAmber,
                    ),
                  ),
                  onTapNumber: () {
                    if (TextNumber22 >= 1) {
                      setState(() {
                        TextNumber22--;
                      });
                    }
                  },
                  text2: textRemembrancesMorning[22].text2,
                  text3: textRemembrancesMorning[22].text3,
                  repeatNumber: textRemembrancesMorning[22].textNumber,
                  copy: () {
                    FlutterClipboard.copy(textRemembrancesMorning[22].copy)
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
                    Share.share(textRemembrancesMorning[22].copy);
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
