import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../exporter/exporter.dart';
import '../../../extensions/app_theme_extensions.dart';

class DashboardContainer extends StatelessWidget {
  final String title;
  final IconData? icon;
  final int count;
  const DashboardContainer({
    super.key,
    required this.appColors,
    required this.title,
    this.icon,
    this.count = 0,
  });

  final AppThemeColors appColors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(CustomPadding.paddingLarge),
        margin: EdgeInsets.symmetric(
          horizontal: CustomPadding.paddingSmall + CustomPadding.paddingTiny,
        ),

        decoration: BoxDecoration(
          color: appColors.secondaryColor,
          borderRadius: BorderRadius.circular(CustomPadding.paddingLarge),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      CustomPadding.padding + CustomPadding.paddingSmall,
                    ),
                    color: CustomColors.primaryColor.withAlpha(40),
                  ),
                  child: Icon(icon, color: appColors.primary),
                ),
                Gap(CustomPadding.paddingLarge),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: CustomFont.intelOneMono,
                    fontSize: 18.fSize,
                    color: appColors.textContrastColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 30.fSize,
                fontFamily: CustomFont.intelOneMono,
                fontWeight: FontWeight.w900,
                color: appColors.textContrastColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
