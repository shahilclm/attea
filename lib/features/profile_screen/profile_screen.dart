import 'package:attea/exporter/exporter.dart';
import 'package:attea/gen/assets.gen.dart';
import 'package:attea/services/size_utils.dart';
import 'package:gap/gap.dart';

import '/core/logger.dart';

import 'package:flutter/material.dart';

import '../../extensions/app_theme_extensions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    logError("⚠️ ProfileScreen build called");
    final appColors = Theme.of(context).extension<AppThemeColors>()!;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: appColors.background,
      //   title: Text(
      //     'Profile',
      //     style: TextStyle(color: appColors.textContrastColor),
      //   ),
      // ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Gap(CustomPadding.paddingXL),

              CircleAvatar(
                radius: 50.h,
                backgroundColor: CustomColors.kDarkScaffold,
                child: ClipOval(
                  child: Image.asset(
                    Assets.png.supporttalogo.path,
                    fit: BoxFit.contain, // or BoxFit.contain
                    width: 100.h,
                    height: 100.h,
                  ),
                ),
              ),
              Gap(CustomPadding.padding),
              Text(
                'Supportta Solution',
                style: context.headlineLarge.copyWith(
                  fontFamily: 'IntelOneMono',
                  fontSize: 20.fSize,
                ),
              ),
              Text('Software Development and Digital Marketing'),

              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: CircleAvatar(child: Icon(Icons.settings)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
