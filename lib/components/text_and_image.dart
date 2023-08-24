// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';

class TextAndImage extends StatelessWidget {
  TextAndImage({
    Key? key,
    this.image,
    this.text,
    this.colorText,
    this.onTap,
  }) : super(key: key);

  String? image;
  String? text;
  Color? colorText;
  VoidCallback? onTap;












  

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorText,
      elevation: 8,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: KColorBlackBlack26,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ink.image(
              image: AssetImage(
                image!,
              ),
              height: 125,
              width: 125,
              fit: BoxFit.cover,
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Center(
              child: Text(
                text!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
