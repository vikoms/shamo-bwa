import 'package:equatable/equatable.dart';
import 'package:shamo_clone/data/models/product_model.dart';

class ProductDetailModel extends Equatable {
  final ProductModel product;
  const ProductDetailModel({required this.product});
  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      product: ProductModel.fromJson(json['data']),
    );
  }
  @override
  List<Object?> get props => [
        product,
      ];
}
