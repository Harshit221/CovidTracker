class Candle {
  String country;
  Map countryInfo;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  num casesPerOneMillion;
  num deathsPerOneMillion;
  Candle();
  Candle.fromJson(Map<String, dynamic> jsonMap) {
    this.country = jsonMap['country'];
    this.countryInfo = jsonMap['countryInfo'];
    this.cases = jsonMap['cases'];
    this.todayCases = jsonMap['todayCases'];
    this.deaths = jsonMap['deaths'];
    this.todayDeaths = jsonMap['todayDeaths'];
    this.recovered = jsonMap['recovered'];
    this.active = jsonMap['active'];
    this.critical = jsonMap['critical'];
    this.casesPerOneMillion = jsonMap['casesPerOneMillion'];
    this.deathsPerOneMillion = jsonMap['deathsPerOneMillion'];
  }
  Candle.fromJsonGlobal(Map<String, dynamic> jsonMap) {
    this.country = 'Global';
    this.countryInfo = jsonMap['countryInfo'];
    this.cases = jsonMap['cases'];
    this.todayCases = jsonMap['todayCases'];
    this.deaths = jsonMap['deaths'];
    this.todayDeaths = jsonMap['todayDeaths'];
    this.recovered = jsonMap['recovered'];
    this.active = jsonMap['active'];
    this.critical = jsonMap['critical'];
    this.casesPerOneMillion = jsonMap['casesPerOneMillion'];
    this.deathsPerOneMillion = jsonMap['deathsPerOneMillion'];
  }
}
