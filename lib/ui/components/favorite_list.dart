import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/hive/favorite_history.dart';
import '../../domain/hive/hive_boxes.dart';
import '../resources/app_bg.dart';
import '../theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../../domain/provider/weather_provider.dart';
import 'current_region_item.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<FavoriteHistory>(HiveBoxes.favoriteBox).listenable(),
        builder: (context, value, _) {
          return ListView.separated(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, i) {
              return FavoriteCard(
                index: i,
                value: value,
              );
            },
            separatorBuilder: (context, i) => const SizedBox(
              height: 10,
            ),
            itemCount: value.length,
          );
        });
  }
}

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required this.index, required this.value});

  final int index;
  final Box<FavoriteHistory> value;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: AssetImage(value.getAt(index)?.bg ?? AppBg.shinyDay),
            fit: BoxFit.cover,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CurrenTimeZone(
            currentCity: value.getAt(index)?.currentCity ?? 'Error',
            currentZone: model.weatherData?.timezone,
          ),
          CurrentRegionTemp(
            icon: value.getAt(index)?.icon ?? model.iconData(),
            currentTemp:
                value.getAt(index)?.currentTemp ?? model.setCurrentTemp(),
          ),
          IconButton(
              onPressed: () {
                model.deleteFavorite(index);
              },
              icon: Icon(
                Icons.close,
                color: AppColors.whiteColor,
              ))
        ],
      ),
    );
  }
}
