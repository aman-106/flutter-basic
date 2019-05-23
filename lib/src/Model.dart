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