import 'package:attea/widgets/custom_date_picker.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../extensions/app_theme_extensions.dart';
import '../../main.dart';
import '/exporter/exporter.dart';
import 'widgets/dashboard_container.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback openDrawer;
  static const String path = '/home-screen';

  const HomeScreen({super.key, required this.openDrawer});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.menu, color: appColors.dynamicIconColor),
      //     onPressed: widget.openDrawer,
      //   ),
      //   systemOverlayStyle: Theme.of(context).brightness == Brightness.dark
      //       ? SystemUiOverlayStyle.light
      //       : SystemUiOverlayStyle.dark,

      //   // actions: [
      //   //   IconButton(
      //   //     onPressed: () => MyApp.toggleTheme(),
      //   //     icon: Icon(Icons.brightness_6, color: appColors.dynamicIconColor),
      //   //   ),
      //   // ],
      //   backgroundColor: appColors.background,
      // ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  CustomGap.gap,
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appColors.secondaryColor,
                      boxShadow: [
                        appColors.customBoxShadows,
                        appColors.additionalCustomBoxShadow,
                      ],
                    ),

                    child: IconButton(
                      onPressed: widget.openDrawer,
                      icon: Icon(Icons.menu, color: appColors.dynamicIconColor),
                    ),
                  ),
                ],
              ),
            ),

            /// Timeline Header
            SliverToBoxAdapter(
              child: EasyDateTimeLinePicker.itemBuilder(
                headerOptions: HeaderOptions(
                  headerBuilder: (context, date, onTap) {
                    return CustomDatePicker(
                      date: date,
                      local: 'en',
                      timelinePadding: EdgeInsets.symmetric(
                        horizontal: CustomPadding.padding,
                      ),
                      onPressed: onTap,
                    );
                  },
                ),
                currentDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 90)),
                lastDate: DateTime.now(),
                focusedDate: _focusDate,

                itemExtent: SizeUtils.width * .2,
                itemBuilder:
                    (context, date, isSelected, isDisabled, isToday, onTap) {
                      if (isSelected) {
                        logSuccess(
                          'Selected date: $date, isSelected: $isSelected, isToday: $isToday',
                        );
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // ColoredBox(color: Colors.red),
                          InkWell(
                            onTap: onTap,
                            child: Container(
                              // height: SizeUtils.height * .2,
                              width: SizeUtils.width * .4,
                              margin: EdgeInsets.symmetric(
                                horizontal: CustomPadding.paddingSmall,
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  appColors.customBoxShadows,
                                  appColors.additionalCustomBoxShadow,
                                ],
                                borderRadius: BorderRadius.circular(
                                  CustomPadding.paddingLarge,
                                ),
                                color: isSelected
                                    ? appColors.primary
                                    : isToday
                                    ? appColors.primary.withValues(alpha: .01)
                                    : appColors.secondaryColor,
                                border: isToday && !isSelected
                                    ? Border.all(
                                        color: appColors.primary,
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: Column(
                                // spacing:
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  CustomGap.gap,
                                  Text(
                                    _getMonthAbbr(date.month),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isSelected
                                          ? CustomColors.kDarkScaffold
                                          : isToday
                                          ? CustomColors.kDarkScaffold
                                          : appColors.textContrastColor,
                                      // color: isSelected
                                      //     ? CustomColors.kDarkScaffold
                                      //     : appColors.textGrey,
                                    ),
                                  ),
                                  CustomGap.gap,
                                  Text(
                                    date.day.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? CustomColors.kDarkScaffold
                                          : isToday
                                          ? CustomColors.kDarkScaffold
                                          : appColors.textContrastColor,
                                    ),
                                  ),
                                  CustomGap.gap,
                                  Text(
                                    _getDayAbbr(date.weekday),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isSelected
                                          ? CustomColors.kDarkScaffold
                                          : isToday
                                          ? CustomColors.kDarkScaffold
                                          : appColors.textContrastColor,
                                      // color: isSelected
                                      //     ? CustomColors.kDarkScaffold
                                      //     : appColors.textGrey,
                                    ),
                                  ),
                                  CustomGap.gap,
                                ],
                              ),
                            ),
                          ),

                          // Container(color: Colors.red, height: 50),
                        ],
                      );
                    },
                onDateChange: (date) {
                  setState(() {
                    _focusDate = date;
                  });
                },
              ),
            ),

            /// Spacing between timeline and grid
            SliverToBoxAdapter(child: Gap(CustomPadding.paddingLarge)),

            /// Dashboard Grid
            SliverPadding(
              padding: EdgeInsets.all(CustomPadding.padding),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: CustomPadding.paddingLarge,
                  crossAxisSpacing: CustomPadding.padding,
                  childAspectRatio: 1.2,
                ),
                delegate: SliverChildListDelegate([
                  DashboardContainer(
                    backgroundColor: CustomColors.checkinColor,
                    title: 'Check In',
                    icon: LucideIcons.logIn,
                    count: 20,
                  ),
                  DashboardContainer(
                    backgroundColor: CustomColors.checkoutColor,
                    title: 'Check Out',
                    icon: LucideIcons.logOut,
                    count: 15,
                  ),
                  DashboardContainer(
                    backgroundColor: CustomColors.leaveColor,
                    title: 'Leave',
                    icon: Icons.person_off,
                    count: 5,
                  ),
                  DashboardContainer(
                    backgroundColor: CustomColors.employeesColor,
                    title: 'Employees',
                    icon: LucideIcons.users,
                    count: 42,
                  ),
                ]),
              ),
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
