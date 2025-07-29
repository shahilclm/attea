import 'package:attea/extensions/app_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

const double _innerPadding = 4.0;

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.date,
    required this.local,
    required this.timelinePadding,
    required this.onPressed,
  });

  final DateTime date;
  final String local;
  final EdgeInsets timelinePadding;
  final VoidCallback onPressed;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isDialogOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleRotation() {
    setState(() {
      _isDialogOpen = !_isDialogOpen;
      _isDialogOpen ? _controller.forward() : _controller.reverse();
    });
  }

  Future<void> _showPickerDialog() async {
    _toggleRotation();
    widget.onPressed();
    _toggleRotation();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;

    final double effectiveHorizontalPadding = math.max(
      0,
      widget.timelinePadding.horizontal - _innerPadding,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: effectiveHorizontalPadding,
        vertical: 4.0,
      ),
      child: SizedBox(
        height: 52.0,
        child: InkWell(
          onTap: _showPickerDialog,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: _innerPadding),
            child: Center(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      DateFormat(
                        DateFormatSettings.dMonthY,
                        widget.local,
                      ).format(widget.date),
                      style: TextStyle(
                        color: appColors.textContrastColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: appColors.textContrastColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

abstract final class DateFormatSettings {
  static const String dMonthY = "d MMMM y";
  static const String monthY = "MMMM y";
  static const String monthName = "MMMM";
  static const String yearNumber = "y";
}
