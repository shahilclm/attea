import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../extensions/app_theme_extensions.dart';
import '../../main.dart';
import '/exporter/exporter.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback openDrawer;
  static const String path = '/home-screen';

  const HomeScreen({super.key, required this.openDrawer});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedGender;
  DateTime _focusDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: appColors.dynamicIconColor),
          onPressed: widget.openDrawer,
        ),
        systemOverlayStyle: Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
            onPressed: () => MyApp.toggleTheme(),
            icon: Icon(Icons.brightness_6, color: appColors.dynamicIconColor),
          ),
        ],
        title: Text(
          'Home Screen',
          style: TextStyle(color: appColors.textContrastColor),
        ),
        centerTitle: true,
        backgroundColor: appColors.background,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 170.h,
              padding: EdgeInsets.symmetric(horizontal: CustomPadding.padding),
              child: EasyDateTimeLinePicker.itemBuilder(
                currentDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 90)),

                lastDate: DateTime.now(),

                focusedDate: _focusDate,
                itemExtent: 70.0.h,

                itemBuilder:
                    (context, date, isSelected, isDisabled, isToday, onTap) {
                      return GestureDetector(
                        onTap: onTap,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: CustomPadding.paddingSmall,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              CustomPadding.paddingLarge,
                            ),
                            color: isSelected
                                ? appColors.primary
                                : isToday
                                ? appColors.primary.withValues(alpha: 0.1)
                                : appColors.secondaryColor,
                            border: isToday && !isSelected
                                ? Border.all(color: appColors.primary, width: 2)
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _getMonthAbbr(date.month),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isSelected
                                      ? Colors.white
                                      : appColors.textGrey,
                                ),
                              ),
                              Text(
                                date.day.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.white
                                      : isToday
                                      ? appColors.primary
                                      : appColors.textContrastColor,
                                ),
                              ),
                              Text(
                                _getDayAbbr(date.weekday),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isSelected
                                      ? Colors.white
                                      : appColors.textGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },

                onDateChange: (date) {
                  setState(() {
                    _focusDate = date;
                  });
                },
              ),
            ),
            Gap(CustomPadding.padding),
            Row(
              children: [
                Expanded(
                  child: DashboardContainer(
                    title: 'Check In',
                    icon: LucideIcons.logIn,
                    count: 20,
                    appColors: appColors,
                  ),
                ),
                Expanded(
                  child: DashboardContainer(
                    title: 'Check Out',
                    icon: LucideIcons.logOut,
                    appColors: appColors,
                  ),
                ),
              ],
            ),
            Gap(CustomPadding.paddingLarge),
            Row(
              children: [
                Expanded(
                  child: DashboardContainer(
                    title: 'Leave',
                    icon: Icons.person_off,
                    count: 20,
                    appColors: appColors,
                  ),
                ),

                Expanded(
                  child: DashboardContainer(
                    title: 'Employees',
                    icon: LucideIcons.users,
                    appColors: appColors,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthAbbr(int month) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return months[month - 1];
  }

  String _getDayAbbr(int weekday) {
    const days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return days[weekday - 1];
  }
}

class DashboardContainer extends StatelessWidget {
  final String title;
  final IconData? icon;
  final int count;
  const DashboardContainer({
    super.key,
    required this.appColors,
    required this.title,
    this.icon,
    this.count = 0,
  });

  final AppThemeColors appColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CustomPadding.paddingLarge),
      margin: EdgeInsets.symmetric(
        horizontal: CustomPadding.paddingSmall + CustomPadding.paddingTiny,
      ),
      height: 140.h,

      decoration: BoxDecoration(
        color: appColors.secondaryColor,
        borderRadius: BorderRadius.circular(CustomPadding.paddingLarge),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 35.v,
                height: 35.v,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    CustomPadding.padding + CustomPadding.paddingSmall,
                  ),
                  color: CustomColors.primaryColor.withAlpha(40),
                ),
                child: Icon(icon, color: appColors.primary),
              ),
              Gap(CustomPadding.paddingLarge),
              Text(
                title,
                style: TextStyle(
                  fontFamily: CustomFont.intelOneMono,
                  fontSize: 18.fSize,
                  color: appColors.textContrastColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 30.fSize,
              fontFamily: CustomFont.intelOneMono,
              fontWeight: FontWeight.w900,
              color: appColors.textContrastColor,
            ),
          ),
        ],
      ),
    );
  }
}
