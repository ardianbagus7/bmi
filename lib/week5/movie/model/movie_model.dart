part of '../../week5.dart';

class MovieResult {
  final String msg;
  final List<Movie> data;

  MovieResult({this.msg, this.data});
}

class Movie {
  final int id;
  final String title;
  final String description;
  final String category;
  final String video;
  final int favorite;
  final int rating;
  final String image;
  final bool status;
  final DateTime createdAt;

  Movie({
    this.id,
    this.title,
    this.description,
    this.category,
    this.video,
    this.favorite,
    this.image,
    this.rating,
    this.status,
    this.createdAt,
  });

  factory Movie.fromJson(dynamic json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      video: json['video'] as String,
      favorite: json['favorite'] as int,
      image: json['image'] as String,
      rating: json['rating'] as int,
      status: json['status'] as bool,
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}
