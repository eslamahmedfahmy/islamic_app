import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:islam_app/components/container_voice.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';

class VoiceRoquia extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

// Firebase Storage الرقية الشرعية صوت يتم الحصول علي الصوت من
class _AudioPageState extends State<VoiceRoquia> {
  AudioPlayer player = AudioPlayer();
  List<String> audioUrls = [
    'roquia/roquia.mp3',
    'roquia/roquia1.mp3',
    // 'roquia/roquia2.mp3',
  ];
  List<String> audioName = [
    'الرُّقية الشرعية من القرآن الكريم',
    'الرُّقية الشرعية من السنة النبوية',
    // 'الرقية الشرعية كاملة',
  ];

  bool isPlaying = false;

  List<bool> isPlayingList = [false, false];
  List<bool> isMaleList = [true, true];
  List<String?> downloadUrls = [null, null];

  @override
  void initState() {
    _loadAudio();
    super.initState();

    // يستخدم للاستماع إلى حالة تشغيل الصوت وحالة الوقت الحالية والمدة الكلية للصوت
    player.onPlayerStateChanged.listen((state) {});

    player.onDurationChanged.listen((newDuration) {
      try {
        setState(() {
          this.duration = newDuration;
        });
      } catch (e) {}
    });

    player.onPositionChanged.listen((newPosition) {
      try {
        setState(() {
          this.position = newPosition;
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

// ................
  Future<void> _loadAudio() async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      for (int i = 0; i < audioUrls.length; i++) {
        Reference ref = storage.ref().child(audioUrls[i]);
        Directory appDocDir = await getApplicationDocumentsDirectory();
        File localFile = File('${appDocDir.path}/roquia$i.mp3');
        if (await localFile.exists()) {
          print('تم تحميل الملف $i من التخزين المحلي');

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
      // false الأخرى على isPlayingList ضبط جميع قيم
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
            icon: Icon(Icons.arrow_back, size: 30)),
        title: Text(
          ' الرقية الشرعية صوت',
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
