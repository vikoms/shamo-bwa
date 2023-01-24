import 'category_model.dart';
import 'gallery_model.dart';

class ProductModel {
  final int id;
  final String name;
  final int price;
  final String description;
  final String? tags;
  final CategoryModel category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<GalleryModel> galleries;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.tags,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.galleries,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        description: json['description'],
        tags: json['tags'],
        category: CategoryModel.fromJson(json['category']),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        galleries: List<GalleryModel>.from(
            json["galleries"].map((x) => GalleryModel.fromJson(x))),
      );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'tags': tags,
      'category': category.toJson(),
      'galleries': galleries.map((gallery) => gallery.toJson()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}

class UninitializedProductModel extends ProductModel {
  UninitializedProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.description,
    required super.tags,
    required super.category,
    required super.createdAt,
    required super.updatedAt,
    required super.galleries,
  });
}
