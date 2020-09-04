part of '../../week4.dart';

class MarketplaceResult {
  final String msg;
  final List<Marketplace> data;

  MarketplaceResult({this.msg, this.data});
}

class Marketplace {
  final int id;
  final String title;
  final String description;
  final String category;
  final int price;
  final int star;
  final String image;
  final DateTime createdAt;
  final String name;

  Marketplace({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.star,
    this.image,
    this.createdAt,
    this.name,
  });

  factory Marketplace.fromJson(dynamic json) {
    return Marketplace(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      price: json['price'] as int,
      star: json['star'] as int,
      image: json['image'] as String,
      createdAt: DateTime.parse(json["created_at"]),
      name: json['name'] as String,
    );
  }
}
