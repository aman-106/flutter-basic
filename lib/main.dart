import 'package:flutter/material.dart';
import 'src/LayoutWidget.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: MyHomePage(),
      theme: new ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
    );
  }
}

const appTitle = 'title';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        backgroundColor: Colors.deepPurple,
      ),
      body: LayoutWidget(),
      backgroundColor: Colors.white,
    );
  }
}
