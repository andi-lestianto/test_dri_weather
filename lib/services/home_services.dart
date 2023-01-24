// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_dri_weather/model/wilayah_model.dart';

class HomeServices extends ChangeNotifier {
  final Dio dio = Dio();
  List<Wilayah> dataWilayah = [];

  List<Wilayah> get getDataWilayah {
    return dataWilayah;
  }

  Future<dynamic> fetchApi() async {
    try {
      final response = await dio
          .get('https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json');
      List<dynamic> data = response.data;
      dataWilayah.addAll(data.map((e) => Wilayah.fromJson(e)));
    } on DioError catch (e) {
      print(e.response);
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
