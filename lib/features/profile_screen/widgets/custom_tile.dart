import 'package:attea/exporter/exporter.dart';
import 'package:flutter/material.dart';

class CustomProfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;
  final Color? fontColor;
  final VoidCallback? onTap;
  bool needTrailing;
  CustomProfileTile({
    super.key,
    required this.title,
    required this.icon,
    this.color,
    this.fontColor,
    this.needTrailing = true,
    this.onTap
    
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: CustomColors.textColorLightGrey,
        maxRadius: 25.h,
        child: Icon(icon, color: color),
      ),
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'IntelOneMono',
          fontSize: 18.fSize,
          color: fontColor,
        ),
      ),
      trailing: needTrailing
          ? Icon(Icons.arrow_forward_ios, color: CustomColors.kDarkDividerColor)
          : null,
      horizontalTitleGap: 25.h,
    );
  }
}
