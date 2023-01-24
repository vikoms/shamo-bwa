import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/models/product_model.dart';
import 'package:shamo_clone/services/product_services.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      _products = products;
    } catch (e) {
      print(e);
    }
  }
}
