// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_dri_weather/model/weather_model.dart';

class WeatherServices extends ChangeNotifier {
  final Dio dio = Dio();
  List<Weather> dataWeather = [];
  String? datenow;

  String? get getDateNow {
    return datenow;
  }

  List<Weather> get getDataWeather {
    return dataWeather;
  }

  Future<dynamic> fetchWeatherDetail({required String id}) async {
    try {
      final response =
          await dio.get('https://ibnux.github.io/BMKG-importer/cuaca/$id.json');
      List<dynamic> data = response.data;
      dataWeather.addAll(data.map((e) => Weather.fromJson(e)));
    } on DioError catch (e) {
      print(e.response);
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  setDateNow() {
    List<String> date = DateTime.now().toString().substring(0, 10).split('-');
    datenow = date.reversed.join('-');
  }
}
