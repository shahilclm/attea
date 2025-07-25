import 'package:attea/exporter/exporter.dart';
import 'package:attea/features/profile_screen/widgets/custom_tile.dart';
import 'package:attea/features/profile_screen/widgets/logout_dialog.dart';
import 'package:attea/gen/assets.gen.dart';
import 'package:gap/gap.dart';

import 'package:flutter/material.dart';

import '../../../extensions/app_theme_extensions.dart';

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
      backgroundColor: appColors.background,
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
                  color: appColors.textContrastColor,
                ),
              ),
              Text(
                'Software Development and Digital Marketing',
                style: TextStyle(
                  color: CustomColors.textColorLightGrey,
                  fontFamily: CustomFont.intelOneMono,
                ),
              ),
              Gap(CustomPadding.paddingXXL),

              Expanded(
                child: ListView(
                  children: [
                    CustomProfileTile(
                      icon: Icons.settings,
                      title: 'Settings',
                      fontColor: CustomColors.textColorLightGrey,

                      color: CustomColors.kDarkDividerColor,
                    ),
                    Divider(thickness: 0.1),
                    CustomProfileTile(
                      title: 'Log out',
                      icon: Icons.logout,
                      fontColor: CustomColors.scaffoldRed,
                      color: CustomColors.scaffoldRed,
                      needTrailing: false,
                      onTap: () {
                        showLogoutDialog(context);
                      },
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
