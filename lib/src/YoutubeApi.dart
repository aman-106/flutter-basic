import 'package:http/http.dart' as http;
import 'dart:async';

class YoutubeApi {
  final String baseUrl = "www.googleapis.com";
  final String videosListUrl = "/youtube/v3/videos";
  final String searchUrl = '/youtube/v3/search';
  // final YoutubeVideosOptions options;

  Future<http.Response> getTrendingVideos(Map<String, String> options) async {
    final Uri uri = new Uri.https(
        "www.googleapis.com", "/youtube/v3/videos", options);
    http.Response response =
        await http.get(uri, headers: {"Accept": "application/json"});
    return response;
  }
}

class YoutubeVideosOptions {
  String
      part; //  snippet property contains the channelId, title, description, tags, and categoryId
  String chart; //mostPopular
  String id;
  String myRating;
  String regionCode; //in
  String apikey;

  YoutubeVideosOptions(
      {String part = 'snippet',
      String regionCode = 'in',
      this.chart,
      this.id,
      this.myRating,
      this.apikey}) {
    this.part = part;
    this.regionCode = regionCode;
  }

  Map<String, String> toJson() {
    return {
      'part': this.part,
      'chart': this.chart,
      'id': this.id,
      'myRating': this.myRating,
      'regionCode': this.regionCode,
      'key': this.apikey,
    };
  }

  Map<String, String> toInMostPoppularJson() {
    return {
      'part': 'snippet',
      'chart': 'mostPopular',
      'regionCode': 'in',
      'key': this.apikey,
    };
  }
}
