import 'package:flutter/material.dart';

import '../extensions/app_theme_extensions.dart';

class CustomTabBarWithView extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> tabViews;

  const CustomTabBarWithView({
    super.key,
    required this.tabs,
    required this.tabViews,
  });

  @override
  State<CustomTabBarWithView> createState() => _CustomTabBarWithViewState();
}

class _CustomTabBarWithViewState extends State<CustomTabBarWithView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColor = Theme.of(context).extension<AppThemeColors>();

    return Column(
      children: [
        Container(
          color: appColor!.background,
          child: TabBar(
            controller: _tabController,
            labelColor: appColor.textContrastColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: appColor.dynamicIconColor,
            isScrollable: true,
            tabs: widget.tabs.map((tab) => Tab(text: tab)).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabViews,
          ),
        ),
      ],
    );
  }
}
