import '/exporter/exporter.dart';
import '/extensions/app_theme_extensions.dart';
import '/widgets/loading_button.dart';
import '/widgets/mini_loading_button.dart';
import 'package:flutter/material.dart';

class MiniLoadingExample extends StatefulWidget {
  const MiniLoadingExample({super.key});

  @override
  State<MiniLoadingExample> createState() => _MiniLoadingExampleState();
}

class _MiniLoadingExampleState extends State<MiniLoadingExample> {
  bool isLoadingButton = false;
  bool isLoadingGradient = false;
  bool isLoadingOutline = false;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buttons',
          style: TextStyle(color: appColors.textContrastColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetCase(
              label: 'Gradient Loading Button',
              child: LoadingButton(
                buttonType: ButtonType.filled,
                enabled: true,
                buttonLoading: isLoadingGradient,
                text: 'Click here',
                onPressed: () {
                  setState(() {
                    isLoadingGradient = !isLoadingGradient;
                    Future.delayed(Duration(seconds: 1)).then((value) {
                      setState(() {
                        isLoadingGradient = !isLoadingGradient;
                      });
                    });
                  });
                },
              ),
            ),
            WidgetCase(
              label: ' Loading Button',
              child: LoadingButton(
                buttonType: ButtonType.outlined,
                buttonLoading: isLoadingOutline,
                text: 'Click here',
                textColor: appColors.textContrastColor,
                onPressed: () {
                  setState(() {
                    isLoadingOutline = !isLoadingOutline;
                    Future.delayed(Duration(seconds: 1)).then((value) {
                      setState(() {
                        isLoadingOutline = !isLoadingOutline;
                      });
                    });
                  });
                },
              ),
            ),
            WidgetCase(
              label: 'Button',
              child: MiniLoadingButton(
                isLoading: isLoadingButton,
                text: 'Click here',
                onPressed: () {
                  setState(() {
                    isLoadingButton = !isLoadingButton;
                    Future.delayed(Duration(seconds: 1)).then((value) {
                      setState(() {
                        isLoadingButton = !isLoadingButton;
                      });
                    });
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetCase extends StatelessWidget {
  final String label;
  final Widget child;
  const WidgetCase({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: appColors.textContrastColor),
        ),
        CustomGap.gap,
        child,
        CustomGap.gapXL,
        SizedBox(),
      ],
    );
  }
}
