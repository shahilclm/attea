import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
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
              padding: EdgeInsets.symmetric(horizontal: CustomPadding.padding),
              child: EasyDateTimeLinePicker.itemBuilder(
                currentDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 90)),

                lastDate: DateTime.now(),

                focusedDate: _focusDate,
                itemExtent: SizeUtils.width * .2,

                itemBuilder:
                    (context, date, isSelected, isDisabled, isToday, onTap) {
                      if (isSelected)
                        logSuccess(
                          'Selected date: $date, isSelected: $isSelected, isToday: $isToday',
                        );

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

CustomScrollView(
  slivers: [
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
            title: 'Check In',
            icon: LucideIcons.logIn,
            count: 20,
            appColors: appColors,
          ),
          DashboardContainer(
            title: 'Check Out',
            icon: LucideIcons.logOut,
            count: 15, 
            appColors: appColors,
          ),
          DashboardContainer(
            title: 'Leave',
            icon: Icons.person_off,
            count: 5,
            appColors: appColors,
          ),
          DashboardContainer(
            title: 'Employees',
            icon: LucideIcons.users,
            count: 42,
            appColors: appColors,
          ),
        ]),
      ),
    ),
  ],
)
,


            




       
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            

            
            
            
            
            

            
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
