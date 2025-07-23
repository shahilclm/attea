import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../extensions/app_theme_extensions.dart';
import '../gen/assets.gen.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Not Found',
          style: TextStyle(color: appColors.textContrastColor),
        ),
      ),
      body:
          Center(child: Expanded(child: Lottie.asset(Assets.lotties.notFound))),
    );
  }
}
