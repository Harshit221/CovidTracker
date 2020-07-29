import 'dart:io';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:corona/pages/country_view.dart';
import 'package:corona/service/candle.dart';
import 'package:corona/service/time_series.dart';
import 'package:corona/service/user_data.dart';
import 'package:flutter/material.dart';
import 'package:corona/style/text_style.dart';

class HomePage extends StatefulWidget {
  final Storage storage;
  HomePage({Key key, @required this.storage}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map args = {};
  List<String> countries = ['Global'];
  List<String> allCountries;
  List<String> remainedCountries = List<String>();
  TimeSeries timeSeries;
  Map<String, Candle> map;
  Map<String, String> flags;

  @override
  void initState() {
    super.initState();

    widget.storage.readData().then((String value) {
      if (value.length > 0) {
        setState(() {
          countries = value.split(",");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (args.length == 0) {
      args = ModalRoute.of(context).settings.arguments;
      map = args['map'];
      flags = args['flags'];
      allCountries = map.keys.toList();
      timeSeries = args['timeseries'];
    }

    if (countries == null) countries = ['Global'];
    Candle candle = args['candle'];
    if (remainedCountries.length == 0) {
      remainedCountries.addAll(allCountries);
      for (var v in countries) {
        remainedCountries.remove(v);
      }
    } else {
      remainedCountries.remove(countries.last);
    }

    remainedCountries.sort();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Corona",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Column(
                  children: countries
                      .map(
                        (country) => CountryView.countryViewTemplate(
                            candle: map[country],
                            flag: flags[country],
                            delete: () {
                              setState(() {
                                countries.remove(country);
                                remainedCountries.add(country);
                                countries.length == 0
                                    ? countries.add('Global')
                                    : {};
                                updateFile();
                              });
                            }),
                      )
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    child: Card(
                      elevation: 10.0,
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                      child: Container(
                        child: FlatButton.icon(
                            onPressed: () async {
                              String data = await CountryView.selectCountry(
                                  context, remainedCountries, flags);
                              if (data != null) {
                                setState(() {
                                  countries.add(data);
                                  updateFile();
                                });
                              }
                            },
                            icon: Icon(Icons.add),
                            label: Text('Add Country')),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateFile() {
    var buffer = StringBuffer();
    buffer.write(countries[0]);
    for (int i = 1; i < countries.length; i++) {
      buffer.write(',${countries[i]}');
    }
    Future<File> file = widget.storage.writeData(buffer.toString());
    //file.then((onValue){print(onValue.readAsStringSync());});
  }
}
