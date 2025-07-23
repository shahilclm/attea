import '/exporter/exporter.dart';
import '/extensions/app_theme_extensions.dart';
import '/gen/assets.gen.dart';
import '/services/size_utils.dart';
import '/widgets/mini_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/chill_guy_widget.dart';

class SampleModalExample extends StatefulWidget {
  const SampleModalExample({super.key});

  @override
  State<SampleModalExample> createState() => _SampleModalExampleState();
}

class _SampleModalExampleState extends State<SampleModalExample> {
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sample Modal Example',
          style: TextStyle(color: appColors.textContrastColor),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: MiniLoadingButton(
                text: "Tap to show modal ",
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: appColors.secondaryColor,
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(CustomPadding.paddingXL),
                      ),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: SizedBox(
                          width: double.maxFinite,
                          height: SizeUtils.height * .54,
                          child: Column(
                            children: [
                              CustomGap.gapLarge,

                              ChillGuyWidget(),

                              // Text(
                              //   'This is a sample modal',
                              //   style: Theme.of(context).textTheme.titleLarge,
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
