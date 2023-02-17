import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shamo_clone/domain/entities/product.dart';
import 'package:shamo_clone/domain/entities/wishlist.dart';

class WishListModel extends Equatable {
  final int id;
  final String name;
  final int price;
  final String photo;

  WishListModel({
    required this.id,
    required this.name,
    required this.price,
    required this.photo,
  });

  factory WishListModel.fromProductEntity(Product product) => WishListModel(
        id: product.id,
        name: product.name,
        price: product.price,
        photo: product.galleries[0].url,
      );

  factory WishListModel.fromMap(Map<String, dynamic> map) => WishListModel(
        id: map['id'],
        name: map['name'],
        price: map['price'],
        photo: map['photo'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'photo': photo,
      };

  Wishlist toEntity() => Wishlist(
        id: id,
        name: name,
        price: price,
        photo: photo,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        photo,
      ];
}
