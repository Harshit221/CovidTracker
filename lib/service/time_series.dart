import 'dart:convert';

class TimeSeries {
  List<CountrySeries> countrySeries = List<CountrySeries>();
  TimeSeries();
  TimeSeries.fromJson(String jsonStr) {
    List<dynamic> list = jsonDecode(jsonStr);
    for (int i = 0; i < list.length; i++)
      countrySeries.add(CountrySeries.fromJson(list[i]));
  }
}

class CountrySeries {
  String country;
  CountryTimeLine countryTimeLine;
  CountrySeries({this.country, this.countryTimeLine});
  CountrySeries.fromJson(Map<String, dynamic> jsonMap) {

    this.country = jsonMap['country'];
    this.countryTimeLine = CountryTimeLine.fromJson(jsonMap['timeline']);
  }

}

class CountryTimeLine {

  Map cases;
  Map deaths;
  Map recovered;
  CountryTimeLine.fromJson(Map<String, dynamic> jsonMap) {
    this.cases = jsonMap['cases'];
    this.deaths = jsonMap['deaths'];
    this.recovered = jsonMap['recovered'];
  }

}