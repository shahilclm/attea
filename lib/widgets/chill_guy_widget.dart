import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../gen/assets.gen.dart';

class ChillGuyWidget extends StatefulWidget {
  const ChillGuyWidget({super.key});

  @override
  State<ChillGuyWidget> createState() => _ChillGuyWidgetState();
}

class _ChillGuyWidgetState extends State<ChillGuyWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      Assets.lotties.chillGuyLaugh,
      controller: _controller,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward(); // Play once
      },
    );
  }
}
