import 'dart:convert';

import 'package:amazon_clone/models/rating.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String name;
  final String description;
  final num quantity;
  final List<dynamic> images;
  final String category;
  final num price;
  final String? id;
  final List<Rating>? rating;
  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'rating': rating!.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
     name: map['name'] ?? '' ,
      description: map['description'] ?? '',
      quantity: map['quantity']  ,
      images: List<dynamic>.from((map['images'] as List<dynamic>)),
      category: map['category'] ?? '',
      price: map['price'],
      id: map['_id'] != null ? map['_id'] ?? '' : null,
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
