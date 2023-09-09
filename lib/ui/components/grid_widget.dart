import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../domain/provider/weather_provider.dart';
import '../resources/app_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return SizedBox(
      height: 340,
      child: GridView.builder(
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            mainAxisExtent: 160),
        itemBuilder: (context, i) {
          return SizedBox(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: AppColors.sevenDaysColor.withOpacity(0.5),
              child: Center(
                child: ListTile(
                  leading: SvgPicture.asset(GridIcons.gridIcons[i]),
                  title: Text(
                    '${model.setValues(i)} ${GridUnits.gridUnits[i]}',
                    style: AppStyle.fontStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    GridDescription.gridDescription[i],
                    style: AppStyle.fontStyle.copyWith(
                      fontSize: 10,
                      color: AppColors.darkBlueColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GridIcons {
  static List<String> gridIcons = [
    AppIcons.windSpeed,
    AppIcons.thermometer,
    AppIcons.raindrops,
    AppIcons.glasses,
  ];
}

class GridUnits {
  static List<String> gridUnits = [
    'км/ч',
    '°',
    '%',
    'км',
  ];
}

class GridDescription {
  static List<String> gridDescription = [
    'Скорость ветра',
    'Ощущается',
    'Влажность',
    'Видимость',
  ];
}
