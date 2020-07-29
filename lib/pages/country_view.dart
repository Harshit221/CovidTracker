import 'package:corona/pages/filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corona/service/candle.dart';
import 'package:corona/style/text_style.dart';

class CountryView {
  static Widget countryViewTemplate(
      {Candle candle, String flag, Function delete}) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 10.0,
            child: ListTile(



              title: Container(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        candle.country,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.grey[800]),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: delete,
                      tooltip: 'Remove',
                    ),
                  ],
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/$flag'),
              ),
            ),
          ),
          Card(
            borderOnForeground: false,
            //color: Colors.cyan[100],
            elevation: 10.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    candle.cases.toString(),
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  subtitle: Text('Cases'),
                ),
                Divider(
                  height: 1,
                ),
                ListTile(
                  title: Text(candle.deaths.toString(),
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  subtitle: Text('Deaths'),
                ),
                Divider(
                  height: 1,
                ),
                ListTile(
                  title: Text(candle.recovered.toString(),
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  subtitle: Text('Recovered'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Future<String> selectCountry(context, countryList, flags) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Container(
//                width: 300,
//                height: 400,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: SingleChildScrollView(
                  child: FilterCountry(countries: countryList,flags: flags,),
                )),
          );
        });
  }
}
