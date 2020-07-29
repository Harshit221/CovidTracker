import 'dart:convert';

import 'package:corona/service/time_series.dart';
import 'package:http/http.dart';

import 'candle.dart';
import 'candle_list.dart';

class RequestData {
  static Map map = {
    'global': 'https://corona.lmao.ninja/all',
    'countries': 'https://corona.lmao.ninja/countries',
    'globalHistorical': 'https://corona.lmao.ninja/v2/historical/all',
    'historical': 'https://corona.lmao.ninja/v2/historical/'
  };
  CandleList candleList;
  Candle candle;
  String response;
  TimeSeries timeSeries;

  Future<void> requestApi(String url) async {
    Response response = await get(url);
    this.response = response.body;
  }


  RequestData();

  Candle getGlobal() {
    requestApi(map['global']);
    return Candle.fromJson(jsonDecode(response));
  }

  CandleList getCountryList() {
    requestApi(map['countries']);
    return CandleList.fromJson(response);
  }

  Future<void> getData() async {
    await requestApi(map['global']).then((onValue){candle = Candle.fromJsonGlobal(jsonDecode(response));});
//    candle = await Candle.fromJsonGlobal(jsonDecode(response));
    await requestApi(map['countries']).then((onValue){candleList = CandleList.fromJson(response);});
//    candleList = await CandleList.fromJson(response);
    await requestApi(map['historical']).then((value){timeSeries = TimeSeries.fromJson(response);});
    await requestApi(map['globalHistorical']).then((value){
      timeSeries.countrySeries.add(CountrySeries(country: 'Global', countryTimeLine: CountryTimeLine.fromJson(jsonDecode(response))));

    });

  }

  Future<void> getTimeSeries() async {
    await requestApi(map['historical']).then((value){timeSeries = TimeSeries.fromJson(response);});
    await requestApi(map['globalHistorical']).then((value){
      timeSeries.countrySeries.add(CountrySeries(country: 'Global', countryTimeLine: CountryTimeLine.fromJson(jsonDecode(response))));
    });


  }
}
