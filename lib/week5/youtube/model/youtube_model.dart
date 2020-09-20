part of '../../week5.dart';

class YoutubeResult {
  final String msg;
  final List<Youtube> data;

  YoutubeResult({this.msg, this.data});
}

class Youtube {
  final DateTime publishedAt;
  final String channelTitle;
  final String title;
  final String description;
  final String image;
  final String video;

  Youtube({
    this.publishedAt,
    this.channelTitle,
    this.title,
    this.description,
    this.image,
    this.video,
  });

  factory Youtube.fromJson(dynamic json) {
    return Youtube(
      publishedAt: DateTime.parse(json['snippet']["publishedAt"]),
      title: json['snippet']['title'] as String,
      channelTitle: json['snippet']['channelTitle'] as String,
      description: json['snippet']['description'] as String,
      image: json['snippet']['thumbnails']['standard']['url'] as String,
      video: json['snippet']['resourceId']['videoId'] as String,
    );
  }
}
