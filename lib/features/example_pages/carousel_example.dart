import '/constants/constants.dart';
import '/extensions/app_theme_extensions.dart';
import '/extensions/font_extension.dart';
import '/widgets/carousel_view_widget.dart';
import 'package:flutter/material.dart';

import '../../core/logger.dart';

class CarouselExample extends StatelessWidget {
  const CarouselExample({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;

    logError('CarouselExample build called');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carousel Screen',
          style: TextStyle(color: appColors.textContrastColor),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselViewWidget(
            height: 250,
            autoScroll: true,
            // padding: const EdgeInsets.symmetric(horizontal: 20),
            borderRadius: BorderRadius.circular(16),
            shadow: BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: CustomPadding.padding,
              offset: const Offset(0, 4),
            ),
            items: [
              Image.network('https://picsum.photos/id/1/800/400',
                  fit: BoxFit.cover),
              Image.network('https://picsum.photos/id/2/800/400',
                  fit: BoxFit.cover),
              Image.network('https://picsum.photos/id/3/800/400',
                  fit: BoxFit.cover),
            ],
          )
        ],
      ),
    );
  }
}
