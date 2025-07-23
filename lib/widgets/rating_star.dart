import '../extensions/app_theme_extensions.dart';
import '/core/logger.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:gaimon/gaimon.dart';

class RatingStar extends StatelessWidget {
  final int maxRating;
  final double initailRating;
  const RatingStar(
      {super.key, required this.maxRating, required this.initailRating});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;
    // return RatingBar.readOnly(
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Star Rating',
          style: TextStyle(color: appColors.textContrastColor),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingBar(
              // emptyColor: Colors.transparent,
              isHalfAllowed: true,
              halfFilledIcon: Icons.star_half,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              onRatingChanged: (value) {
                Gaimon.medium();

                logInfo("Tapped stars: $value");
              },
              initialRating: initailRating,
              maxRating: maxRating,
            ),
          ],
        ),
      ),
    );
  }
}
