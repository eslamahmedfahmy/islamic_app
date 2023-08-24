import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';

// ignore: must_be_immutable
class ListTileMenuAppBar extends StatelessWidget {
  ListTileMenuAppBar({super.key, this.onTap,this.title,this.subtitle,this.rightIcon,this.leftIcon});
  VoidCallback? onTap;
  String? title;
  IconData? rightIcon;
  Widget? leftIcon;
  Widget? subtitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title!,
        style:  Theme.of(context).textTheme.headline6,
      ),
      leading: Icon(
        rightIcon,
        color: KColorAmber,
        size: 35,
      ),
      subtitle: subtitle,
      trailing: leftIcon
    );
  }
}
