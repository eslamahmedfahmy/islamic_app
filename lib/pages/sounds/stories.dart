import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:islam_app/components/container_voice.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';

class Stories extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

// Firebase Storage قصص الصحابة يتم الحصول علي الصوت من
class _AudioPageState extends State<Stories> {
  AudioPlayer player = AudioPlayer();
  List<String> audioUrls = [
    'stories/stories.mp3',
    'stories/stories1.mp3',
    'stories/stories2.mp3',
    'stories/stories3.mp3',
    'stories/stories4.mp3',
    'stories/stories5.mp3',
    'stories/stories6.mp3',
    'stories/stories7.mp3',
    'stories/stories8.mp3',
    'stories/stories9.mp3',
    'stories/stories10.mp3',
    'stories/stories11.mp3',
    'stories/stories12.mp3',
    'stories/stories13.mp3',
    'stories/stories14.mp3',
    'stories/stories15.mp3',
    'stories/stories16.mp3',
    'stories/stories17.mp3',
    'stories/stories18.mp3',
    // 'stories/stories19.mp3',
    // 'stories/stories20.mp3',
  ];
  List<String> audioName = [
    'محمد رسول الله',
    'الصديق أبو بكر رضي الله عنه',
    'الفاروق عمر رضي الله عنه',
    'سعد بن أبى وقاص رضي الله عنه',
    'طلحة بن عبيد الله رضي الله عنه',
    'ذو النورين عثمان رضي الله عنه',
    'علي بن أبي طالب رضي الله عنه',
    'مصعب بن عمير رضي الله عنه',
    'أبو عبيدة رضي الله عنه',
    'ابن مسعود رضي الله عنه',
    'بلال بن رباح رضي الله عنه',
    'سلمان الفارسي رضي الله عنه',
    // 'خالد بن الوليد رضي الله عنه',
    'عبدالله بن عباس رضي الله عنه',
    'سعد بن معاذ رضي الله عنه',
    'عطاء بن أبي رباح رضي الله عنه',
    // 'عمر بن عبدالعزيز رضي الله عنه',
    'عروة بن الزبير  رضي الله عنه',
    'حمزة بن عبدالمطلب رضي الله عنه',
    'جعفر بن أبي طالب رضي الله عنه',
    'أبو هريرة رضي الله عنه',
  ];
  bool isPlaying = false;

  List<bool> isPlayingList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    // false,
    // false,
  ];
  List<bool> isMaleList = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    // true,
    // true,
  ];
  List<String?> downloadUrls = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    // null,
    // null,
  ];

  @override
  void initState() {
    _loadAudio();
    super.initState();

    // ..........
    player.onPlayerStateChanged.listen((state) {});

    player.onDurationChanged.listen((newDuration) {
      try {
        setState(() {
          duration = newDuration;
        });
      } catch (e) {
        // print(e);
      }
    });

    player.onPositionChanged.listen((newPosition) {
      try {
        setState(() {
          position = newPosition;
        });
      } catch (e) {}
    });
    player.onDurationChanged.listen((newDuration) {
      try {
        setState(() {
          durationsList[songIndex] = newDuration;
        });
      } catch (e) {}
    });

    player.onPositionChanged.listen((newPosition) {
      try {
        setState(() {
          progressList[songIndex] = newPosition.inMilliseconds /
              durationsList[songIndex].inMilliseconds;
        });
      } catch (e) {}
    });
  }

  Future<void> _loadAudio() async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      for (int i = 0; i < audioUrls.length; i++) {
        Reference ref = storage.ref().child(audioUrls[i]);
        Directory appDocDir = await getApplicationDocumentsDirectory();
        File localFile = File('${appDocDir.path}/stories$i.mp3');
        if (await localFile.exists()) {
          print('.تم تحميل الملف $i من التخزين المحلي');

          setState(() {
            downloadUrls[i] = localFile.path;
          });
        } else {
          print('Firebase Storage. يتم تحميل الملف $i من ');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'يتم تحميل ${audioName[i]}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );

          await ref.writeToFile(localFile);
          setState(() {
            downloadUrls[i] = localFile.path;
          });
        }
      }
    } catch (e) {
      print('حدث خطأ أثناء التحميل: $e');
    }
  }

  @override
  void dispose() {
    player.dispose();
    player.pause();
    super.dispose();
  }

  void _playAudio(int index) {
    if (isPlayingList[index]) {
      setState(() {
        isPlayingList[index] = false;
        isMaleList[index] = true;
      });
      player.pause();
    } else {
      // set all other isPlayingList values to false
      for (int i = 0; i < isPlayingList.length; i++) {
        if (i != index && isPlayingList[i]) {
          setState(() {
            isPlayingList[i] = false;
          });
        }
      }
      setState(() {
        isPlayingList[index] = true;
        isMaleList[index] = false;
      });
      if (downloadUrls[index] != null) {
        player.play(UrlSource(downloadUrls[index]!));
      }
    }

    setState(() {
      songIndex = index;
    });
  }

  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  int songIndex = 0;

  //  تنسيق الوقت
  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  List<Duration> durationsList = List.filled(12, Duration.zero);
  List<double> progressList = List.filled(12, 0.0);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, size: 35)),
        title: Text(
          'قصص الصحابة',
          style: TextStyle(
            color: KColorPurpleApp,
            fontFamily: 'Cairo',
          ),
        ),
      ),
      body: Column(
        children: [
          ContainerVoiceAndText(
            text: audioName[songIndex],
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: audioUrls.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: themeProvider.isDarkModeEnabled
                      ? KColorblue
                      : Color(0xffEDEDED),
                  child: GestureDetector(
                    onTap: () => _playAudio(index),
                    child: ListTile(
                      title: Text(
                        '${audioName[index]}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      leading: IconButton(
                        onPressed: () => _playAudio(index),
                        icon: Icon(
                          isPlayingList[index] ? Icons.pause : Icons.play_arrow,
                          size: 45,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 110.0,
              ),
              Slider(
                activeColor: themeProvider.isDarkModeEnabled
                    ? KColorblue
                    : KColor_page_songs_and_page_stories_and_quran_holy,
                value: duration.inSeconds.toDouble() <
                        position.inSeconds.toDouble()
                    ? const Duration(seconds: 0).inSeconds.toDouble()
                    : position.inSeconds.toDouble(),
                max: duration.inSeconds.toDouble(),
                min: Duration.zero.inSeconds.toDouble(),
                onChanged: (value) {
                  final position2 = Duration(seconds: value.toInt());
                  // print(position2);
                  position = position2;
                  player.seek(position);
                  //player.resume();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(formatTime(position.inSeconds)),
                    const SizedBox(
                      width: 200,
                    ),
                    Text(
                      "${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 55),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        //  لما اضغط عليه يقلل 10 ثواني من الوقت الصوت الي شغال
                        if (position.inSeconds == 0 ||
                            position.inSeconds < 10) {
                          seekTo(0);
                        } else if (position.inSeconds > 10) {
                          seekTo(position.inSeconds - 10);
                        }
                      },
                      icon: const Icon(Icons.skip_previous),
                      iconSize: 35,
                    ),
                    IconButton(
                      onPressed: () => _playAudio(songIndex),
                      icon: Icon(
                        isPlayingList[songIndex]
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 45,
                      ),
                      iconSize: 35,
                    ),
                    IconButton(
                      onPressed: () {
                        //  دي لما اضغط عليه يزود 10 ثواني من وقت الصوت الي شغال
                        if (position < duration - Duration(seconds: 10)) {
                          seekTo(position.inSeconds + 10);
                        } else {
                          seekTo(duration.inSeconds);
                          setState(() {
                            isPlaying = false;
                          });
                          player.stop();
                        }
                      },
                      icon: const Icon(Icons.skip_next),
                      iconSize: 35,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  seekTo(int sec) {
    // دي خاصه ان لما اضغط علي زر تزويد او تنقيص يقلل وقت الصوت او يزود وقت الصوت
    player.seek(Duration(seconds: sec));
  }
}
