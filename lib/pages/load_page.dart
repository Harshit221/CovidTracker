import 'package:corona/service/candle.dart';
import 'package:corona/service/candle_list.dart';
import 'package:corona/service/request_data.dart';
import 'package:corona/service/time_series.dart';
import 'package:corona/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Widget spinner = SpinKitCubeGrid(
    color: Colors.amber,
    size: 50.0,
  );
  Widget myWidget;

  Future<void> getData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        myWidget = spinner;
        RequestData requestData = RequestData();
        await requestData.getData();
        List<Candle> candleList =
            requestData.candleList.candles;
        Candle candle = requestData.candle;
        candleList.add(candle);
        candleList.removeAt(0);
        TimeSeries timeSeries = requestData.timeSeries;
//        print(timeSeries.countrySeries[0].countryTimeLine.cases);

        Map<String, String> flags = {};
        for (int i = 0; i < candleList.length - 1; i++) {
          String url = candleList[i].countryInfo['flag'];
          String cName = candleList[i].country;
          flags[cName] = url.substring(url.length - 6);
        }
        flags['Global'] = 'Global.png';

        Map<String, Candle> result = {for (var v in candleList) v.country: v};


        Navigator.pushReplacementNamed(context, '/home', arguments: {
          'candle': requestData.candle,
          'candleList': requestData.candleList,
          'map': result,
          'flags': flags,
          'timeseries' : timeSeries
        });
      }
    } on SocketException catch (_) {
//      print('Internet not found');
      setState(() {
        myWidget = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.block,
              color: Colors.red,
              size: 80.0,
            ),
            SizedBox(
              height: 25,
            ),
            Text('No internet connection', style: MyTextStyle.label),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Connect to the internet',
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  myWidget = spinner;
                  getData();
                });
              },
              child: Text(
                'RETRY',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: myWidget,
      ),
    );
  }
}
