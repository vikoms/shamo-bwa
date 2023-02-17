import 'package:equatable/equatable.dart';

import '../../domain/entities/category.dart';

class CategoryDataModel extends Equatable {
  CategoryDataModel({
    required this.currentPage,
    required this.data,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
  });

  final int currentPage;
  final List<CategoryModel> data;
  final int from;
  final int lastPage;
  final int perPage;
  final int to;
  final int total;

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryDataModel(
        currentPage: json["current_page"],
        data: List<CategoryModel>.from(
            json["data"].map((x) => CategoryModel.fromJson(x))),
        from: json["from"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "from": from,
        "last_page": lastPage,
        "per_page": perPage,
        "to": to,
        "total": total,
      };

  @override
  List<Object?> get props => [
        currentPage,
        data,
        from,
        lastPage,
        perPage,
        to,
        total,
      ];
}

class CategoryModel extends Equatable {
  CategoryModel({
    required this.id,
    required this.name,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  Category toEntity() => Category(id: id, name: name);

  @override
  List<Object?> get props => [
        id,
        name,
        deletedAt,
        createdAt,
        updatedAt,
      ];
}
