// import '../example_pages/carousel_example.dart';
import 'package:attea/main.dart';
import 'package:attea/widgets/day_night_switch.dart';

import '../example_pages/carousel_example.dart';
import '../example_pages/features_example.dart';
import '../profile_screen/view/profile_screen.dart';

import '../employee_screen/view/employee_screen.dart';
import '/features/search_screen.dart/view/search_screen.dart';

import '../../extensions/app_theme_extensions.dart';
import '/exporter/exporter.dart';
import 'package:flutter/material.dart';

import '../../services/show_exit_confirmation_dialogue.dart';
import '../home_screen/view/home_screen.dart';

class NavigationScreen extends StatefulWidget {
  static const String path = '/navigation-screen';

  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool _isDarkTheme = true;
  int _selectedIndex = 0;
  bool _canPop = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final List<Widget?> _pages = List.filled(5, null);
  Widget _getPage(int index) {
    if (_pages[index] == null) {
      _pages[index] = _buildPage(index);
    }
    return _pages[index]!;
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen(
          openDrawer: () => _scaffoldKey.currentState?.openDrawer(),
        );
      case 1:
        return SearchScreen();
      case 2:
        return EmployeeScreen();
      case 3:
        // return const Center(child: Text('Notifications Page'));
        // return AlertScreen();
        return CarouselExample();
      case 4:
        return const ProfileScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  // List<Widget> get _pages => [
  //       // const Center(child: Text('Search Page')),
  //       HomeScreen(openDrawer: () => _scaffoldKey.currentState?.openDrawer()),
  //       // PaginatedHomescreen(
  //       //     openDrawer: () => _scaffoldKey.currentState?.openDrawer()),

  //       SearchScreen(),
  //       // const Center(child: Text('Search Page')),
  //       AddScreen(),
  //       // const Center(child: Text('Add Page')),
  //       // const Center(child: Text('Notifications Page')),
  //       AnimatedGridScreen(),
  //       // const Center(child: Text('Profile Page')),
  //       ProfileScreen()
  //     ];
  void changeTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
      MyApp.toggleTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppThemeColors>()!;
    final TextStyle drawerTextStyle = context.labelMedium.copyWith(
      color: appColors.textContrastColor,
    );
    final navBarTheme = NavigationBarTheme.of(context);

    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final navigator = Navigator.of(context);

          final confirm = await showExitConfirmationToast(context);
          // final confirm = await showExitConfirmationDialog(context);
          if (!mounted) return;
          if (confirm) {
            setState(() => _canPop = true);
            navigator.maybePop(result);
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: theme.scaffoldBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: CustomColors.secondaryColor),
                child: Text('Drawer Header'),
              ),
              ListTile(title: Text('Home', style: drawerTextStyle)),
              ListTile(title: Text('Settings', style: drawerTextStyle)),
              ListTile(
                onTap: () {
                  Navigator.popAndPushNamed(context, FeaturesExample.path);

                  // Navigator.pop(context);
                  // Navigator.restorablePushReplacementNamed(
                  //     context, FeaturesExample.path);
                },
                title: Text('Features', style: drawerTextStyle),
              ),
              Row(
                children: [
                  CustomGap.gapLarge,
                  Text('Toggle Theme', style: drawerTextStyle),
                  CustomGap.gapLarge,
                  DayNightSwitch(
                    onChanged: (value) => changeTheme(),
                    initialValue: _isDarkTheme,
                  ),
                  // Switch(
                  //   value: _isDarkTheme,
                  //   onChanged: (value) => changeTheme(),
                  // ),
                ],
              ),
            ],
          ),
        ),

        // key: _scaffoldKey,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: IndexedStack(
            index: _selectedIndex,
            children: List.generate(5, (index) => _getPage(index)),
          ),
        ),
        bottomNavigationBar: Material(
          elevation: 40,
          shadowColor: Colors.black,
          child: BottomNavigationBar(
            elevation: 10,
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
            type: BottomNavigationBarType.fixed,
            // backgroundColor: appColors.background,
            backgroundColor: navBarTheme.backgroundColor,

            // backgroundColor: CustomColors.kDarkDividerColor,
            selectedItemColor: CustomColors.navigationForegroundColor,
            unselectedItemColor: CustomColors.textColorGrey,
            selectedFontSize: 12.fSize,
            unselectedFontSize: 12.fSize,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            selectedIconTheme: IconThemeData(size: 24.h),
            unselectedIconTheme: IconThemeData(size: 24.h),
            items: List.generate(5, (index) => _buildNavItem(index)),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(int index) {
    final icons = [
      Icons.home,
      Icons.search,
      Icons.group_add_rounded,
      Icons.notifications,
      Icons.person,
    ];
    final labels = ['Home', 'Search', 'Employees', 'Alerts', 'Profile'];
    final bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: isSelected ? 16.h : 0,
            height: isSelected ? 3.v : 0,
            margin: EdgeInsets.only(bottom: isSelected ? 2 : 0),
            decoration: BoxDecoration(
              color: CustomColors.navigationForegroundColor,
              borderRadius: BorderRadius.circular(CustomPadding.paddingSmall),
            ),
          ),
          Icon(icons[index]),
        ],
      ),
      label: labels[index],
    );
  }
}
