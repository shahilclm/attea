import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../exporter/exporter.dart';
import '../../../extensions/app_theme_extensions.dart';

class DashboardContainer extends StatelessWidget {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String title;
  final IconData? icon;
  final int count;
  const DashboardContainer({
    super.key,
    // required this.appColors,
    required this.title,
    this.icon,
    this.count = 0,
    this.backgroundColor,
    this.foregroundColor,
  });

  // final AppThemeColors appColors;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;
    return Container(
      padding: EdgeInsets.all(CustomPadding.paddingLarge),
      margin: EdgeInsets.symmetric(
        horizontal: CustomPadding.paddingSmall + CustomPadding.paddingTiny,
      ),
      // required this.appColors,
      decoration: BoxDecoration(
        boxShadow: [
          appColors.customBoxShadows,
          appColors.additionalCustomBoxShadow,
        ],
        color: backgroundColor ?? CustomColors.kDarkDividerColor,
        borderRadius: BorderRadius.circular(CustomPadding.paddingLarge),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  // boxShadow: ,
                  borderRadius: BorderRadius.circular(
                    CustomPadding.padding + CustomPadding.paddingSmall,
                  ),
                  // color: CustomColors.primaryColor.withAlpha(40),
                ),
                child: Icon(
                  icon,
                  color: foregroundColor ?? CustomColors.universalForeground,
                ),
              ),
              Gap(CustomPadding.paddingLarge),
              Text(
                title,
                style: TextStyle(
                  fontFamily: CustomFont.intelOneMono,
                  fontSize: 16.fSize,
                  color: foregroundColor ?? CustomColors.universalForeground,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 24.fSize,
              fontFamily: CustomFont.intelOneMono,
              fontWeight: FontWeight.w900,
              color: foregroundColor ?? CustomColors.universalForeground,
            ),
          ),
        ],
      ),
    );
  }
}
