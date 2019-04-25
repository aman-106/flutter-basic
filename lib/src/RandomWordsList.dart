import 'package:flutter/material.dart';
import 'dart:async';

String getRandomWord(int index) {
  return 'random' + index.toString();
}

class RandomWordsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsListState();
  }
}

class RandomWordsListState extends State<StatefulWidget> {
  List<Widget> _getList() {
    return <Widget>[
      Container(
          height: 300.0,
          width: 300.0,
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            itemCount: 20, // max upper limit
            itemBuilder: (BuildContext context, int index) {
              return SimpleDialogOption(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(getRandomWord(index)),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black12),
                    ),
                  ),
                ),
                onPressed: () => Navigator.pop(context, index),
              );
            },
          ))
    ];
  }

  Future<void> _getRandomWordsList(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('random word list'),
            children: _getList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Random word'),
            onPressed: () => _getRandomWordsList(context),
          )
        ],
      ),
    );
  }
}
