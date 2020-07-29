import 'package:corona/pages/home_page.dart';
import 'package:corona/pages/load_page.dart';
import 'package:corona/service/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      routes: {'/': (context) => Loading(), '/home': (context) => HomePage(storage: Storage(),)},

//  home: Loading(),
      theme:ThemeData(
        // Define the default brightness and colors.
        //brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.

      )
    ));
