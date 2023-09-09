import 'package:flutter/material.dart';
import 'package:nweather_app/domain/provider/weather_provider.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_style.dart';
import '../../components/current_weather_status.dart';
import '../../components/grid_widget.dart';
import '../../components/max_min_temp.dart';
import '../../components/seven_days.dart';
import '../../components/sunset_sunrise.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return FutureBuilder(
        future: model.setUp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ScaffoldWidget(model: model);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    super.key,
    required this.model,
  });

  final WeatherProvider model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextButton.icon(
            onPressed: () {
              model.setFavorite(context, cityName: model.weatherData?.timezone);
            },
            icon: Icon(
              Icons.location_on,
              color: AppColors.redColor,
            ),
            label: Text(
              '${model.weatherData?.timezone}',
              style: AppStyle.fontStyle.copyWith(
                color: AppColors.darkBlueColor,
              ),
            )),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.search);
            },
            icon: Icon(
              Icons.add,
              color: AppColors.darkBlueColor,
            ),
          )
        ],
      ),
      body: const HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(model.setBg()), fit: BoxFit.cover),
      ),
      child: ListView(
        children: [
          Text(
            '${model.date.last} ${model.currentTime}',
            textAlign: TextAlign.center,
            style: AppStyle.fontStyle
                .copyWith(color: AppColors.darkBlueColor, fontSize: 14),
          ),
          const SizedBox(
            height: 36,
          ),
          const CurrentWeatherStatus(),
          const SizedBox(
            height: 28,
          ),
          Text(
            '${model.currentTemp}℃',
            textAlign: TextAlign.center,
            style: AppStyle.fontStyle.copyWith(
              fontSize: 90,
              color: AppColors.darkBlueColor,
            ),
          ),
          const SizedBox(height: 18),
          const MaxMinTemp(),
          const SizedBox(height: 40),
          const SevenDaysWidget(),
          const SizedBox(height: 28),
          const GridWidget(),
          const SizedBox(height: 30),
          const SunSetSunRise(),
        ],
      ),
    );
  }
}
