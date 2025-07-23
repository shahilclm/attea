import 'package:firebase_auth/firebase_auth.dart';

import '/features/landing_screen/landing_page.dart';
import '/features/navigation_screen/navigation_screen.dart';

import '../../services/shared_pref_services.dart';
import '/exporter/exporter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/error_widget_with_retry.dart';
import '../../widgets/network_resources.dart';

class SplashScreen extends StatefulWidget {
  static const String path = "/splash-screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Future<void>? future;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final user = FirebaseAuth.instance.currentUser;
        logInfo(' Firebase current user: ${user?.email ?? "No user"}');

        if (user != null) {
          Navigator.of(context).pushReplacementNamed(NavigationScreen.path);
        } else {
          Navigator.of(context).pushReplacementNamed(LandingPage.path);
        }
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: NetworkResource(
        future,
        error: (error) => ErrorWidgetWithRetry(exception: error, retry: () {}),
        success: (data) => const SizedBox(),
        loading: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double scale;
              double opacity = 1.0;
              if (_controller.value < 1 / 3) {
                scale = 1.5 - (_controller.value * 1.5);
                opacity = 1.0;
              } else {
                double t = ((_controller.value - 1 / 3) / (2 / 3)).clamp(
                  0.0,
                  1.0,
                );
                scale = 1 + 9 * t;
                opacity = (1 - t).clamp(0.0, 1.0);
              }

              opacity = opacity.clamp(0.0, 1.0);
              return Opacity(
                opacity: opacity,
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    padding: const EdgeInsets.all(CustomPadding.paddingLarge),
                    width: 140,
                    height: 140,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Placeholder(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
