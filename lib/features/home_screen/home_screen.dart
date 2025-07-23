import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';

import '../../extensions/app_theme_extensions.dart';
import '../../gen/assets.gen.dart';
import '../../main.dart';
import '/exporter/exporter.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback openDrawer;
  static const String path = '/home-screen';

  const HomeScreen({super.key, required this.openDrawer});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: appColors.dynamicIconColor),
          onPressed: widget.openDrawer,
        ),
        systemOverlayStyle: Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
            onPressed: () => MyApp.toggleTheme(),
            icon: Icon(Icons.brightness_6, color: appColors.dynamicIconColor),
          ),
        ],
        title: Text('Home Screen',
            style: TextStyle(color: appColors.textContrastColor)),
        centerTitle: true,
        backgroundColor: appColors.background,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // IconButton(
          //   onPressed: () => MyApp.toggleTheme(),
          //   icon: Icon(Icons.brightness_6, color: appColors.dynamicIconColor),
          // ),
          SvgPicture.asset(Assets.svg.rocket),
          const SizedBox(height: CustomPadding.paddingLarge),
          Text('Welcome to the Home Screen',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: appColors.textContrastColor)),
          const SizedBox(height: CustomPadding.paddingLarge),
          Text('This is a simple home screen for our app.',
              style: TextStyle(fontSize: 16, color: appColors.textGrey)),
        ],
      ),
    );
  }
}
