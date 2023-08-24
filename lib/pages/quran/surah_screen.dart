import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart' as quran;
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/dark_provider.dart';

class SurahScreen extends StatefulWidget {
  final int surahNumber;

  SurahScreen({Key? key, required this.surahNumber}) : super(key: key);
// دي صفحه عرض الايات ان لما اضغط علي اسم السوره يفتح ليا الصفحه دي
  @override
  _SurahScreenState createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  late ScrollController scrollController;
  late List<bool> isVerseSavedList;
  late List<bool> isVerseDeletedList;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadSavedVerses();
    scrollController = ScrollController();
    isVerseSavedList =
        List<bool>.filled(quran.getVerseCount(widget.surahNumber), false);
    isVerseDeletedList =
        List<bool>.filled(quran.getVerseCount(widget.surahNumber), false);
  }

  Future<void> _loadSavedVerses() async {
    _prefs = await SharedPreferences.getInstance();
    final savedVerses =
        _prefs.getStringList('savedVerses_${widget.surahNumber}');
    if (savedVerses != null) {
      setState(() {
        isVerseSavedList = savedVerses.map((e) => e == 'true').toList();
      });
    }
  }

  Future<void> _saveVerse(int verseIndex) async {
    final savedVerses =
        _prefs.getStringList('savedVerses_${widget.surahNumber}') ??
            List.filled(quran.getVerseCount(widget.surahNumber), 'false');
    savedVerses[verseIndex] = 'true';
    await _prefs.setStringList(
        'savedVerses_${widget.surahNumber}', savedVerses);
  }

  Future<void> _deleteVerse(int verseIndex) async {
    final savedVerses =
        _prefs.getStringList('savedVerses_${widget.surahNumber}') ??
            List.filled(quran.getVerseCount(widget.surahNumber), 'false');
    savedVerses[verseIndex] = 'false';
    await _prefs.setStringList(
        'savedVerses_${widget.surahNumber}', savedVerses);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        await _prefs.setStringList('savedVerses_${widget.surahNumber}',
            isVerseSavedList.map((e) => e.toString()).toList());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            quran.getSurahNameArabic(widget.surahNumber),
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Quran',
                color: themeProvider.isDarkModeEnabled
                    ? Colors.white
                    : Colors.black),
          ),
        ),
        body: ListView.builder(
          controller: scrollController,
          itemCount: quran.getVerseCount(widget.surahNumber),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.grey, width: 1.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: quran.getVerse(
                                widget.surahNumber,
                                index + 1,
                                // verseEndSymbol: true,
                              ),
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Quran',
                                backgroundColor: isVerseSavedList[index]
                                    ? (themeProvider.isDarkModeEnabled
                                        ? Colors.white24
                                        : Colors.black12)
                                    : null,
                                color: themeProvider.isDarkModeEnabled
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '\uFD3F${index + 1}\uFD3E',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.isDarkModeEnabled
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          isVerseSavedList[index] = !isVerseSavedList[index];
                        });
                        if (isVerseSavedList[index]) {
                          await _saveVerse(index);
                        } else {
                          await _deleteVerse(index);
                        }
                      },
                      icon: Icon(
                        isVerseSavedList[index]
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: isVerseSavedList[index] ? Colors.orange : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
