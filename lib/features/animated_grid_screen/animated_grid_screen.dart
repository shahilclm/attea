import '/extensions/app_theme_extensions.dart';
import 'package:flutter/material.dart';
import '../../widgets/animated_grid_builder.dart';

class AnimatedGridScreen extends StatelessWidget {
  const AnimatedGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Animated Grid",
        style: TextStyle(color: appColors.textContrastColor),
      )),
      body: AnimatedGridBuilder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "Item $index",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
