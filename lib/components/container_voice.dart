// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:provider/provider.dart';

// الصفحه دي خاصه بالمكان الي في اعلي الصفحه في صفحه
//  اناشيد اسلاميه
//  قران كريم
// قصص الصحابة

class ContainerVoiceAndText extends StatelessWidget {
  ContainerVoiceAndText({super.key, this.text});

  final String? text;

  TextStyle textStyleFont = TextStyle(
    fontFamily: 'Quran',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          child: Container(
            // color: Colors.orange,
            height: 65,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                    color: themeProvider.isDarkModeEnabled
                        ? KColorAmber
                        : KColorSabha,
                    width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 35),
            ),
            Text(
              text!,
              style: textStyleFont,
            )
          ],
        ),
      ],
    );
  }
}
