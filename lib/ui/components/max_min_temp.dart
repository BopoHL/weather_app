import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../domain/provider/weather_provider.dart';
import '../resources/app_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class MaxMinTemp extends StatelessWidget {
  const MaxMinTemp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          AppIcons.highTemp,
          color: AppColors.redColor,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          '${model.setMaxTemp()}°',
          style: AppStyle.fontStyle
              .copyWith(fontSize: 25, color: AppColors.darkBlueColor),
        ),
        const SizedBox(
          width: 65,
        ),
        SvgPicture.asset(
          AppIcons.lowTemp,
          color: AppColors.lightBlueColor,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          '${model.setMinTemp()}°',
          style: AppStyle.fontStyle
              .copyWith(fontSize: 25, color: AppColors.darkBlueColor),
        ),
      ],
    );
  }
}
