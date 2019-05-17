import 'package:flutter/material.dart';
import './src/YoutubeTrends.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() => runApp(MyApp());

const Color appbarcolor = Color.fromRGBO(98, 3, 239, 1);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: MyHomePage(),
      theme: new ThemeData(
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            color: appbarcolor,
          )),
    );
  }
}

const appTitle = 'TrendyTube';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Stack(
        children: <Widget>[
          FlareActor(
            "assets/images/wallpaper.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: 'rotate',
          ),
          YoutubeTrends(),
        ],
      ),
      // backgroundColor: Colors.white,
    );
  }
}
