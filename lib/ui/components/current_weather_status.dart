import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/provider/weather_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class CurrentWeatherStatus extends StatelessWidget {
  const CurrentWeatherStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          model.iconData(),
        ),
        const SizedBox(
          width: 25,
        ),
        Text(
          model.getCurrentStatus(),
          style: AppStyle.fontStyle.copyWith(
            color: AppColors.darkBlueColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
