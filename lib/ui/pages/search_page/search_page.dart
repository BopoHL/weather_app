import 'package:flutter/material.dart';
import 'package:nweather_app/ui/theme/app_colors.dart';
import 'package:nweather_app/ui/theme/app_style.dart';
import 'package:provider/provider.dart';
import '../../../domain/provider/weather_provider.dart';
import '../../components/current_region_item.dart';
import '../../components/favorite_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(
          width: 312,
          height: 35,
          child: TextField(
            controller: model.searchController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              fillColor: const Color(0xFFC4C4C4),
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(4)),
              hintText: 'Введите город/регион',
              hintStyle: AppStyle.fontStyle.copyWith(
                fontSize: 14,
                color: AppColors.black.withOpacity(0.5),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              model.setCurrentCity(context);
            },
            icon: const Icon(Icons.search),
            color: AppColors.darkBlueColor,
          ),
        ],
      ),
      body: WeatherSearchBody(
        model: model,
      ),
    );
  }
}

class WeatherSearchBody extends StatelessWidget {
  const WeatherSearchBody({super.key, required this.model});

  final WeatherProvider model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(model.setBg()), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.only(top: 120, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Текущее место',
              style: AppStyle.fontStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkBlueColor),
            ),
            const SizedBox(height: 16),
            const CurrentRegionItem(),
            const SizedBox(height: 28),
            Text(
              'Избранное',
              style: AppStyle.fontStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkBlueColor),
            ),
            const SizedBox(height: 16),
            const Expanded(child: FavoriteList()),
          ],
        ),
      ),
    );
  }
}
