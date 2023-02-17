import 'package:equatable/equatable.dart';
import 'package:shamo_clone/domain/entities/product.dart';

import 'category_model.dart';

class ProductDataModel {
  ProductDataModel({
    required this.currentPage,
    required this.products,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
  });

  final int? currentPage;
  final List<ProductModel> products;
  final int? from;
  final int? lastPage;
  final int? perPage;
  final int? to;
  final int? total;

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ProductModel> productList =
        list.map((i) => ProductModel.fromJson(i)).toList();

    return ProductDataModel(
      currentPage: json["current_page"],
      products: productList,
      from: json["from"],
      lastPage: json["last_page"],
      perPage: json["per_page"],
      to: json["to"],
      total: json["total"],
    );
  }
}

class ProductModel extends Equatable {
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.tags,
    required this.categoriesId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.galleries,
  });

  final int id;
  final String name;
  final int price;
  final String description;
  final dynamic tags;
  final int categoriesId;
  final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CategoryModel category;
  final List<GalleryModel> galleries;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        tags: json["tags"],
        categoriesId: json["categories_id"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: CategoryModel.fromJson(json["category"]),
        galleries: List<GalleryModel>.from(
            json["galleries"].map((x) => GalleryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "tags": tags,
        "categories_id": categoriesId,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category.toJson(),
        "galleries": List<dynamic>.from(galleries.map((x) => x.toJson())),
      };

  Product toEntity() => Product(
        id: id,
        name: name,
        price: price,
        description: description,
        categoriesId: categoriesId,
        category: category.toEntity(),
        galleries: galleries.isNotEmpty
            ? galleries.map((e) => e.toEntity()).toList()
            : <Gallery>[],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        description,
        tags,
        categoriesId,
        deletedAt,
        createdAt,
        updatedAt,
        category,
        galleries,
      ];
}

class GalleryModel extends Equatable {
  GalleryModel({
    required this.id,
    required this.productsId,
    required this.url,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int productsId;
  final String url;
  final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
        id: json["id"],
        productsId: json["products_id"],
        url: json["url"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products_id": productsId,
        "url": url,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  Gallery toEntity() => Gallery(
        id: this.id,
        productsId: this.productsId,
        url: this.url,
      );

  @override
  List<Object?> get props => [
        id,
        productsId,
        url,
        url,
        deletedAt,
        createdAt,
        updatedAt,
      ];
}
