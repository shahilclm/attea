import 'package:attea/exporter/exporter.dart';
import 'package:attea/extensions/app_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  static const String path = '/employeeDetails';

  const EmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(LucideIcons.edit, color: appColors.dynamicIconColor),
          ),
        ],
      ),
      body: Column(
        children: [
          SafeArea(
            child: CircleAvatar(
              maxRadius: 50,
              backgroundImage: NetworkImage(
                'https://example.com/employee_photo.jpg',
              ),
            ),
          ),
          Text(
            'Name',
            style: TextStyle(
              color: appColors.textContrastColor,
              fontFamily: CustomFont.intelOneMono,
              fontSize: 24.fSize,
            ),
          ),
          Text(
            'EMPID',
            style: TextStyle(
              color: appColors.textContrastColor,
              fontFamily: CustomFont.intelOneMono,
            ),
          ),
          //TODO : GAP
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(CustomPadding.padding),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        CustomPadding.paddingLarge,
                      ),
                      color: Color(0xFF333333),
                    ),

                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: appColors.textLightGrey,
                        child: Icon(Icons.task),
                      ),
                      title: Text(
                        'Task ${index + 1}',
                        style: TextStyle(
                          color: appColors.textContrastColor,
                          fontFamily: CustomFont.intelOneMono,
                        ),
                      ),
                      subtitle: Text(
                        'Description for task ${index + 1}',
                        style: TextStyle(
                          color: appColors.textLightGrey,
                          fontFamily: CustomFont.intelOneMono,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
