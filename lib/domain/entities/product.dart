import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

import 'category.dart';

class Product extends Equatable {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.categoriesId,
    required this.category,
    required this.galleries,
  });

  final int id;
  final String name;
  final int price;
  final String description;
  final int categoriesId;
  final Category category;
  final List<Gallery> galleries;

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        description,
        categoriesId,
        category,
        galleries,
      ];
}

class Gallery extends Equatable {
  Gallery({
    required this.id,
    required this.productsId,
    required this.url,
  });

  final int id;
  final int productsId;
  final String url;

  @override
  List<Object?> get props => [id, productsId, url];
}
