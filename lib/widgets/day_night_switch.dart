import 'package:attea/constants/constants.dart';
import 'package:attea/gen/assets.gen.dart';
import 'package:attea/services/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DayNightSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const DayNightSwitch({
    Key? key,
    this.initialValue = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DayNightSwitch> createState() => _DayNightSwitchState();
}

class _DayNightSwitchState extends State<DayNightSwitch> {
  late bool isDay;

  @override
  void initState() {
    super.initState();
    isDay = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDay = !isDay;
        });
        widget.onChanged(isDay);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 60.h,
        height: 35.h,
        padding: EdgeInsets.symmetric(horizontal: CustomPadding.paddingSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isDay
              ? CustomColors.primaryColor
              : CustomColors.textColorDarkGrey,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: isDay ? Alignment.centerLeft : Alignment.centerRight,
              child: isDay
                  ? CircleAvatar(
                      radius: 14.h,
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset(
                        Assets.svg.sun,
                        fit: BoxFit.contain,
                      ),
                    )
                  : CircleAvatar(
                      radius: 14.h,
                      backgroundColor: const Color.fromARGB(255, 51, 51, 51),
                      child: SvgPicture.asset(
                        Assets.svg.moon,

                        fit: BoxFit.cover,
                        // width: SizeUtils.width * .5,
                        // height: SizeUtils.width * .5,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
