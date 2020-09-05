part of '../../week3.dart';

class KamusResult {
  final String msg;
  final List<Kamus> data;
  final json;

  KamusResult({this.msg, this.data,this.json});
}

class Kamus {
  final String title;
  final String description;

  Kamus({this.title, this.description});

  factory Kamus.fromJson(dynamic json) {
    return Kamus(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
