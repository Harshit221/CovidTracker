import 'dart:convert';

import 'candle.dart';

class CandleList {
  List<Candle> candles = List<Candle>();
  CandleList();

  CandleList.fromJson(String jsonStr) {
    List<dynamic> list = jsonDecode(jsonStr);
    for (int i = 0; i < list.length; i++) candles.add(Candle.fromJson(list[i]));
  }
}
