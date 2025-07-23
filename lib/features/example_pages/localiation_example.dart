import '/exporter/exporter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../extensions/app_theme_extensions.dart';
import '../../main.dart';
import '../../widgets/mini_loading_button.dart';

class LocaliationExample extends StatefulWidget {
  const LocaliationExample({super.key});

  @override
  State<LocaliationExample> createState() => _LocaliationExample();
}

class _LocaliationExample extends State<LocaliationExample> {
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.background,
        title: Text(
          'Profile',
          style: TextStyle(color: appColors.textContrastColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LocalizationTextWidget(
              appColors: appColors.textContrastColor,
            ),
            const Gap(20),
            MiniLoadingButton(
                text: 'Malayalam',
                onPressed: () {
                  setState(() {
                    MyApp.setLanguage('ml');
                  });
                }),
            const Gap(20),
            MiniLoadingButton(
                text: 'English',
                onPressed: () {
                  setState(() {
                    MyApp.setLanguage('en');
                  });
                })
          ],
        ),
      ),
    );
  }
}

class LocalizationTextWidget extends StatefulWidget {
  final Color appColors;

  const LocalizationTextWidget({
    super.key,
    required this.appColors,
  });

  @override
  State<LocalizationTextWidget> createState() => _LocalizationTextWidgetState();
}

class _LocalizationTextWidgetState extends State<LocalizationTextWidget> {
  @override
  Widget build(BuildContext context) {
    logError("text Widget Rebuild.");
    return Text(
      localizationService.translate('hello'),
      style: context.headlineMedium.copyWith(color: widget.appColors),
    );
  }
}
