import 'package:attea/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EmployeeAvatar extends StatelessWidget {
  final String employeeUrl;
  const EmployeeAvatar({super.key, required this.employeeUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 50,
      backgroundColor: CustomColors.textColorLightGrey,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: employeeUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: CustomColors.textColorGrey,
            highlightColor: CustomColors.textColorLightGrey,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: CustomColors.textColorGrey,
                shape: BoxShape.circle,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: CustomColors.textColorGrey,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              size: 40,
              color: CustomColors.kDarkDividerColor,
            ),
          ),
        ),
      ),
    );
  }
}
