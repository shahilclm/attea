import '/widgets/custom_tabbar_with_view.dart';
import 'package:flutter/material.dart';

import '../../extensions/app_theme_extensions.dart';

class SampleTabPage extends StatelessWidget {
  const SampleTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appColor = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      appBar: AppBar(
          title: Text("Tab Template",
              style: TextStyle(color: appColor.textContrastColor))),
      body: CustomTabBarWithView(
        tabs: const ["All", "Active", "Inactive"],
        tabViews: const [
          Center(child: Text("All Content")),
          Center(child: Text("Active Content")),
          Center(child: Text("Inactive Content")),
        ],
      ),
    );
  }
}
