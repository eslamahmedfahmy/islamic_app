// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';

class ListTileConst extends StatelessWidget {
  ListTileConst({Key? key, this.text, this.onTap, this.color, this.icon})
      : super(key: key);

  Icon? icon;
  String? text;
  VoidCallback? onTap;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        textColor: KColorDarkGreen,
        leading: icon,
        title: Text(text!),
        onTap: onTap,
      ),
    );
  }
}
