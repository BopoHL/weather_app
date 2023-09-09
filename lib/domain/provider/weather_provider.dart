import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../hive/favorite_history.dart';
import '../hive/hive_boxes.dart';
import '../api/api.dart';
import '../../ui/resources/app_bg.dart';
import '../../ui/theme/app_colors.dart';
import '../models/coord.dart';
import '../models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  // Хранение координат
  Coord? coords;

  // Хранение данных о погоде
  WeatherData? weatherData;

  // Хранение текущих данных о погоде
  Current? current;

  // Контроллер для поиска
  final searchController = TextEditingController();

  final pref = SharedPreferences.getInstance();

  String currentCity = 'Tashkent';

  Future<WeatherData?> setUp({String? cityName}) async {
    cityName = (await pref).getString('city');
    // (await pref).clear();
    coords = await Api.getCoords(cityName: cityName ?? currentCity);
    weatherData = await Api.getWeather(coords);
    current = weatherData?.current;
    setCurrentTime();
    setCurrentTemp();
    setDays();
    getCurrentCity();

    return weatherData;
  }

  // Получение текущего города из SharedPreference
  Future<String> getCurrentCity() async {
    currentCity = (await pref).getString('city') ?? currentCity;
    return currentCity;
  }

  // Изменение заднего фона

  String? currentBg;
  String setBg() {
    int id = current?.weather?[0].id ?? -1;
    if (id == -1 || current?.sunset == null || current?.dt == null) {
      currentBg = AppBg.shinyDay;
    }
    try {
      if (current?.sunset < current?.dt) {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyNight;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowNight;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.foggyNight;
        } else if (id == 800) {
          currentBg = AppBg.shinyNight;
          AppColors.darkBlueColor = AppColors.whiteColor;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyNight;
          AppColors.darkBlueColor = AppColors.whiteColor;
        }
      } else {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyDay;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowDay;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.foggyDay;
        } else if (id == 800) {
          currentBg = AppBg.shinyDay;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyDay;
        }
      }
    } catch (e) {
      return AppBg.shinyDay;
    }
    return currentBg ?? AppBg.shinyDay;
  }

  // Текущее время
  String? currentTime;

  String setCurrentTime() {
    final getTime = (current?.dt ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setTime = DateTime.fromMillisecondsSinceEpoch(getTime * 1000);
    currentTime = DateFormat('HH:mm').format(setTime);

    return currentTime ?? 'Error';
  }

  // Текущий статус погоды
  String currentStatus = '';

  String getCurrentStatus() {
    currentStatus = current?.weather?[0].description ?? 'Error';
    return capitalize(currentStatus);
  }

  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);

  // Текущая иконка
  final String _iconUrlPath = 'http://openweathermap.org/img/wn/';

  String iconData() {
    return '$_iconUrlPath${current?.weather?[0].icon}.png';
  }

  // Перевод температуры из K (Кельвин) в C (Цельсий)
  int kelvin = -273;
  int currentTemp = 0;

  int setCurrentTemp() {
    currentTemp = ((current?.temp ?? -kelvin) + kelvin).round();
    return currentTemp;
  }

  // Максимальная и минимальная температуры текущего дня
  int maxTemp = 0;

  int setMaxTemp() {
    maxTemp = ((weatherData?.daily?[0].temp?.max ?? -kelvin) + kelvin).round();
    return maxTemp;
  }

  int minTemp = 0;
  int setMinTemp() {
    minTemp = ((weatherData?.daily?[0].temp?.min ?? -kelvin) + kelvin).round();
    return minTemp;
  }

  // Установка дней недели

  final List<String> date = [];
  List<Daily> daily = [];

  void setDays() {
    daily = weatherData!.daily!;
    for (int i = 0; i < daily.length; i++) {
      if (i == 0 && daily.isNotEmpty) {
        date.clear();
      }

      // if (i == 0) {
      //   date.add('Сегодня');
      // }
      else {
        var timeNum = daily[i].dt * 1000;
        var itemdate = DateTime.fromMillisecondsSinceEpoch(timeNum);
        date.add(capitalize(DateFormat(
          'EEEE',
          'ru',
        ).format(itemdate)));
      }
    }
  }

  // Иконки на неделю
  String setDailyIcon(int index) {
    final String getIcon = '${weatherData?.daily?[index].weather?[0].icon}';
    final String setIcon = '$_iconUrlPath$getIcon.png';
    return setIcon;
  }

  // Дневная и ночная температуры на 7 дней

  int dailyDayTemp = 0;
  int setDailyDayTemp(int index) {
    dailyDayTemp =
        ((weatherData?.daily?[index].temp?.day ?? -kelvin) + kelvin).round();
    return dailyDayTemp;
  }

  int dailyNightTemp = 0;
  int setDailyNightTemp(int index) {
    dailyNightTemp =
        ((weatherData?.daily?[index].temp?.night ?? -kelvin) + kelvin).round();
    return dailyNightTemp;
  }

  // Погодные данные

  final List<dynamic> weatherValues = [];

  dynamic setValues(int index) {
    weatherValues.add((current?.windSpeed ?? 0));
    weatherValues.add(((current?.feelsLike ?? -kelvin) + kelvin).round());
    weatherValues.add((current?.humidity ?? 0) / 1);
    weatherValues.add((current?.visibility ?? 0) / 1000);
    return weatherValues[index];
  }

  // Восход/Закат

  String sunRise = '';

  String currentSunRise() {
    final getSunTime =
        (current?.sunrise ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setSunRise = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunRise = DateFormat('HH:mm').format(setSunRise);
    return sunRise;
  }

  String sunSet = '';

  String currentSunSet() {
    final getSunTime =
        (current?.sunset ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setSunSet = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunSet = DateFormat('HH:mm').format(setSunSet);
    return sunSet;
  }

  // Добавление города в избранное

  var box = Hive.box<FavoriteHistory>(HiveBoxes.favoriteBox);

  Future<void> setFavorite(BuildContext context, {String? cityName}) async {
    box
        .add(
          FavoriteHistory(
            currentCity: cityName ?? 'Error',
            currentZone: weatherData?.timezone ?? 'Error',
            bg: currentBg ?? AppBg.shinyDay,
            icon: iconData(),
            currentTemp: currentTemp,
          ),
        )
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.sevenDaysColor,
            content: Text('Город $cityName добавлен в избранное'))));
  }

  // Удаление из избранного

  Future<void> deleteFavorite(int index) async {
    box.deleteAt(index);
  }

  // Установка текущего города

  Future<void> setCurrentCity(BuildContext context, {String? cityName}) async {
    if (searchController.text != '') {
      cityName = searchController.text;
      (await pref).setString('city', cityName);
      await setUp(cityName: (await pref).getString('city'))
          .then((value) => Navigator.pop(context))
          .then((value) => searchController.clear());
      notifyListeners();
    }
  }
}
