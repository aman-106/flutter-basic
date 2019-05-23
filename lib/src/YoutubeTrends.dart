import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/gestures.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import './AuthUser.dart';
import './Model.dart';

// mock youtube api
Future<String> _loadYouTubeMockData() async {
  return await rootBundle.loadString('assets/mockdata/youtubechart.json');
}

Future<YoutubeChart> loadYouTubeApi() async {
  String jsonString = await _loadYouTubeMockData();
  final jsonResponse = json.decode(jsonString);
  return new YoutubeChart.fromJson(jsonResponse);
}

// show card to display youtube content
class YoutubeInfoCard extends StatefulWidget {
  final VideoInfo videoInfo;
  YoutubeInfoCard({this.videoInfo});
  @override
  State<StatefulWidget> createState() {
    return YoutubeInfoCardState();
  }
}

class YoutubeInfoCardState extends State<StatefulWidget> {
  bool _focused = false;

  void _focusCard(DragDownDetails _) {
    setState(() {
      _focused = true;
    });
  }

  void _unfocusCard() {
    setState(() {
      _focused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        elevation: _focused ? 10.0 : 1.0,
        borderOnForeground: true,
        child: GestureDetector(
          onPanDown: _focusCard,
          onPanCancel: _unfocusCard,
          child: Column(
            children: <Widget>[
              Container(
                  width: 300.0,
                  height: 100.0,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage(widget.videoInfo.thumbnailsMediumUrl),
                      ))),
              Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      widget.videoInfo.title,
                      softWrap: true,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ))
            ],
          ),
        ));
  }
}

// render list of youtube videos
class YoutubeTrends extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return YoutubeTrendsState();
  }
}

class YoutubeTrendsState extends State<StatefulWidget> {
  YoutubeChart youtubeChartObj;
  @override
  void initState() {
    super.initState();
    handleSignIn()
        .then((FirebaseUser user) => print(user))
        .catchError((e) => print(e));
    loadYouTubeApi().then((s) => setState(() {
          youtubeChartObj = s;
        }));
  }

  List<Widget> _renderListOfVideos(BuildContext context) {
    if (youtubeChartObj != null) {
      return <Widget>[
        Container(
            height: MediaQuery.of(context).size.height * 0.80,
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: youtubeChartObj.resultsPerPage, // max upper limit
              itemBuilder: (BuildContext context, int index) {
                return YoutubeInfoCard(videoInfo: youtubeChartObj.items[index]);
              },
            ))
      ];
    }

    return <Widget>[];
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: _renderListOfVideos(context));
  }
}
