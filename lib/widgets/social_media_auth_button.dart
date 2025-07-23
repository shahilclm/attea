import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';

class SocialMediaAuthButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String assetPath;

  const SocialMediaAuthButton({
    super.key,
    required this.assetPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CustomPadding.paddingLarge),
                border: Border.all(color: CustomColors.textColorLightGrey)),
            child: SvgPicture.asset(assetPath)));
  }
}
