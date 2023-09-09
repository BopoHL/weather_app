import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class DayItem extends StatelessWidget {
  const DayItem(
      {super.key,
      required this.weekDay,
      required this.dailyIcon,
      this.dayTemp = 0,
      this.nightTemp = 0});

  final String weekDay, dailyIcon;
  final int dayTemp, nightTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            weekDay,
            style: AppStyle.fontStyle.copyWith(
              color: AppColors.darkBlueColor,
            ),
          ),
        ),
        Expanded(
          child: Image.network(
            dailyIcon,
            width: 30,
            height: 30,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '$dayTemp℃',
            style: AppStyle.fontStyle.copyWith(color: AppColors.darkBlueColor),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '$nightTemp℃',
            style: AppStyle.fontStyle,
          ),
        )
      ],
    );
  }
}
