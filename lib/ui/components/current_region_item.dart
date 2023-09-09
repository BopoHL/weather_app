import 'package:flutter/material.dart';
import 'package:nweather_app/ui/theme/app_colors.dart';
import 'package:nweather_app/ui/theme/app_style.dart';
import 'package:provider/provider.dart';

import '../../domain/provider/weather_provider.dart';

class CurrentRegionItem extends StatelessWidget {
  const CurrentRegionItem({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              image: AssetImage(
                model.setBg(),
              ),
              fit: BoxFit.cover),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CurrenTimeZone(
              currentCity: model.weatherData?.timezone,
              currentZone: model.weatherData?.timezone,
            ),
            CurrentRegionTemp(
              icon: model.iconData(),
              currentTemp: model.setCurrentTemp(),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrenTimeZone extends StatelessWidget {
  const CurrenTimeZone(
      {super.key, required this.currentCity, required this.currentZone});
  final String? currentCity, currentZone;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Регион/город',
        //   style: AppStyle.fontStyle.copyWith(
        //     color: AppColors.darkBlueColor,
        //     fontSize: 12,
        //   ),
        // ),
        const SizedBox(height: 6),
        Text(
          currentCity ?? 'Ошибка',
          style: AppStyle.fontStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBlueColor),
        ),
        const SizedBox(height: 6),
        // Text(
        //   currentZone ?? 'Ошибка',
        //   style: AppStyle.fontStyle
        //       .copyWith(fontSize: 14, color: AppColors.darkBlueColor),
        // ),
      ],
    );
  }
}

class CurrentRegionTemp extends StatelessWidget {
  const CurrentRegionTemp(
      {super.key, required this.icon, required this.currentTemp});
  final String icon;
  final int currentTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(icon),
        Text(
          '$currentTemp °C',
          style: AppStyle.fontStyle
              .copyWith(fontSize: 18, color: AppColors.darkBlueColor),
        ),
      ],
    );
  }
}
