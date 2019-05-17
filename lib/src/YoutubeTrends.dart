import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/gestures.dart';
import 'dart:convert';

// final YoutubeChart youtubeChartObj = YoutubeChart.fromJson(youtubechart);

class YoutubeTrends extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return YoutubeTrendsState();
  }
}

Future<String> _loadAStudentAsset() async {
  return await rootBundle.loadString('assets/mockdata/youtubechart.json');
}

Future<YoutubeChart> loadStudent() async {
  String jsonString = await _loadAStudentAsset();
  final jsonResponse = json.decode(jsonString);
  return new YoutubeChart.fromJson(jsonResponse);
}

class MovieInfo extends StatefulWidget {
  final VideoInfo videoInfo;
  MovieInfo({this.videoInfo});
  @override
  State<StatefulWidget> createState() {
    return MovieInfoState(videoInfo: videoInfo);
  }
}

class MovieInfoState extends State<StatefulWidget> {
  MovieInfoState({this.videoInfo});
  final VideoInfo videoInfo;
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
                        image: NetworkImage(videoInfo.thumbnailsMediumUrl),
                      ))),
              Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      videoInfo.title,
                      softWrap: true,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ))
            ],
          ),
        ));
  }
}

class YoutubeTrendsState extends State<StatefulWidget> {
  YoutubeChart youtubeChartObj;
  @override
  void initState() {
    super.initState();
    loadStudent().then((s) => setState(() {
          youtubeChartObj = s;
        }));
  }

  List<Widget> _renderListOfVideos(BuildContext context) {
    if (youtubeChartObj != null) {
      return <Widget>[
        Container(
            height: MediaQuery.of(context).size.height * 0.80,
            // decoration: BoxDecoration(
            //   // Box decoration takes a gradient
            //   gradient: LinearGradient(
            //     // Where the linear gradient begins and ends
            //     begin: Alignment.topRight,
            //     end: Alignment.bottomLeft,
            //     // Add one stop for each color. Stops should increase from 0 to 1
            //     stops: [0.1, 0.6, 0.9],
            //     colors: [
            //       // Colors are easy thanks to Flutter's Colors class.
            //       Colors.indigo[50],
            //       Colors.indigo[100],
            //       Colors.indigo[200],
            //     ],
            //   ),
            // ),
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: youtubeChartObj.resultsPerPage, // max upper limit
              itemBuilder: (BuildContext context, int index) {
                return MovieInfo(videoInfo: youtubeChartObj.items[index]);
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

class YoutubeChart {
  String etag;
  List<VideoInfo> items;
  int resultsPerPage;
  int totalResults;
  YoutubeChart({this.etag, this.items, this.resultsPerPage, this.totalResults});

  factory YoutubeChart.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<VideoInfo> itemsList =
        list.map((item) => VideoInfo.fromJson(item)).toList();
    return YoutubeChart(
      etag: parsedJson['etag'],
      items: itemsList,
      resultsPerPage: parsedJson['pageInfo']['resultsPerPage'],
      totalResults: parsedJson['pageInfo']['totalResults'],
    );
  }
}

class VideoInfo {
  String etag;
  String id;
  String title;
  String thumbnailsMediumUrl;

  VideoInfo({this.id, this.etag, this.thumbnailsMediumUrl, this.title});

  factory VideoInfo.fromJson(Map<String, dynamic> parsedJson) {
    return VideoInfo(
        etag: parsedJson['etag'],
        id: parsedJson['id'],
        title: parsedJson['snippet']['title'],
        thumbnailsMediumUrl: parsedJson['snippet']['thumbnails']['medium']
            ['url']);
  }
}
