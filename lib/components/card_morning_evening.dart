// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:provider/provider.dart';

// خاص باذكار الصباح واذكار المساء
class CardMorningEveningComponent extends StatelessWidget {
  CardMorningEveningComponent({
    super.key,
    this.repeatNumber,
    this.copy,
    this.share,
    this.text2,
    this.text3,
    this.onTap,
    this.textNumber,
    this.onTapNumber,
    this.color,
    this.textNumberB,
  });

  Color colorNumber = Color(0xffF7F7F7);
  Color colorDivider = Color(0xffF5F5F5);

  String? repeatNumber;
  VoidCallback? copy;
  VoidCallback? share;
  String? text2;
  String? text3;
  VoidCallback? onTap;
  Text? textNumber;
  VoidCallback? onTapNumber;
  Color? color;
  Text? textNumberB;

  TextStyle textStyleFont =
      TextStyle(fontFamily: 'Quran', fontSize: 20, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: themeProvider.isDarkModeEnabled ? Colors.black : Colors.grey,
            width: 2.0,
          ),
        ),
        elevation: 2,
        // color: KColorWhite,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 4),
                  Stack(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // KColorPurpleApp
                                repeatNumber!,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: themeProvider.isDarkModeEnabled
                                      ? KColorWhite
                                      : KColorPurpleApp,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            color: themeProvider.isDarkModeEnabled
                                ? KColorblue
                                : colorDivider,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    onPressed: copy,
                    icon: Icon(
                      Icons.content_copy,
                      size: 30,
                    ),
                    color: KColorAmber,
                  ),
                  SizedBox(width: 25),
                  IconButton(
                    onPressed: share,
                    icon: Icon(
                      Icons.share,
                      size: 30,
                    ),
                    color: KColorAmber,
                  ),
                ],
              ),
              Text(
                text2!,
                style: textStyleFont,
              ),
              Divider(
                color:
                    themeProvider.isDarkModeEnabled ? KColorblue : colorDivider,
                thickness: 3,
                // indent: 60,
                // endIndent: 60,
              ),
              Text(
                text3!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: onTapNumber,
                child: Container(
                  // color: Colors.orange,
                  height: 75,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: color!, width: 2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: textNumber),
                      Row(
                        children: [
                          SizedBox(width: 12),
                          Center(child: textNumberB),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
