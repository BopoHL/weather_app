import 'package:flutter/material.dart';
import '../../domain/provider/weather_provider.dart';
import 'package:provider/provider.dart';
import '../theme/app_colors.dart';
import 'day_item.dart';

class SevenDaysWidget extends StatelessWidget {
  const SevenDaysWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: AppColors.sevenDaysColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 34),
        itemBuilder: (context, i) {
          return DayItem(
            weekDay: model.date[i],
            dailyIcon: model.setDailyIcon(i),
            dayTemp: model.setDailyDayTemp(i),
            nightTemp: model.setDailyNightTemp(i),
          );
        },
        separatorBuilder: (context, i) => const SizedBox(
          height: 16,
        ),
        itemCount: 7,
      ),
    );
  }
}
