import 'package:flutter/material.dart';

class CardRoquiaQuran extends StatelessWidget {
  CardRoquiaQuran({super.key, this.text});

  TextStyle textStyleFont =
      TextStyle(fontFamily: 'Quran', fontSize: 19, fontWeight: FontWeight.w600);
  String? text;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Text(
            text!,
            style: textStyleFont,
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
