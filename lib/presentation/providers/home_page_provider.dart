import 'package:flutter/cupertino.dart';
import 'package:shamo_clone/domain/entities/category.dart';
import 'package:shamo_clone/domain/entities/user.dart';
import 'package:shamo_clone/domain/usecases/get_categories.dart';
import 'package:shamo_clone/domain/usecases/get_products.dart';
import 'package:shamo_clone/domain/usecases/get_products_by_category.dart';
import 'package:shamo_clone/domain/usecases/get_profile.dart';
import 'package:shamo_clone/utils/request_state.dart';

import '../../domain/entities/product.dart';

class HomePageProvider with ChangeNotifier {
  final GetProducts _getProducts;
  final GetCategories _getCategories;
  final GetProductsByCategories _getProductsByCategories;
  final GetProfile _getProfile;
  HomePageProvider(
    this._getProducts,
    this._getCategories,
    this._getProductsByCategories,
    this._getProfile,
  );

  List<Product> _products = [];
  List<Product> get products => _products;

  List<Product> _productsPerCategory = [];
  List<Product> get productsPerCategory => _productsPerCategory;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  late UserEntity? _profile = null;
  UserEntity? get profile => _profile;

  RequestState _productState = RequestState.Empty;
  RequestState get productState => _productState;

  RequestState _categoryState = RequestState.Empty;
  RequestState get categoryState => _categoryState;

  RequestState _productsCategoyState = RequestState.Empty;
  RequestState get productsCategoyState => _productsCategoyState;

  String _productMessage = '';
  String get productMessage => _productMessage;

  String _categoryMessage = '';
  String get categoryMessage => _categoryMessage;

  String _productsCategoryMessage = '';
  String get productsCategoryMessage => _productsCategoryMessage;

  String _categoryTitle = 'Popular Products';
  String get categoryTitle => _categoryTitle;

  Future<void> getProducts() async {
    _productState = RequestState.Loading;
    notifyListeners();
    final result = await _getProducts.execute();
    result.fold((error) {
      _productState = RequestState.Error;
      _productMessage = error.message;
    }, (products) {
      _productState = RequestState.Loaded;
      _products = products;
      notifyListeners();
    });
  }

  Future<void> getCategories() async {
    _categoryState = RequestState.Loading;
    notifyListeners();
    final result = await _getCategories.execute();
    result.fold((error) {
      _categoryState = RequestState.Error;
      _categoryMessage = error.message;
      notifyListeners();
    }, (categories) {
      final allShoesCategory = Category(
        id: 0,
        name: 'All Shoes',
        isSelected: true,
      );
      _categories = categories;
      _categories.insert(0, allShoesCategory);
      _categoryState = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> getProductsByCategory(int categoryId) async {
    _productsCategoyState = RequestState.Loading;
    notifyListeners();
    final result = await _getProductsByCategories.execute(categoryId);
    result.fold((error) {
      _productsCategoyState = RequestState.Error;
      _productsCategoryMessage = error.message;
    }, (products) {
      _productsCategoyState = RequestState.Loaded;
      _productsPerCategory = products;
      notifyListeners();
    });
  }

  Future<void> setCategorySelected(int selectedId) async {
    var previousSelected =
        _categories.firstWhere((element) => element.isSelected);
    if (previousSelected != null) {
      _categories = _categories
          .map((category) => category.id == previousSelected.id
              ? category.setSelected(false)
              : category)
          .toList();
    }
    _categories = _categories
        .map((category) =>
            category.id == selectedId ? category.setSelected(true) : category)
        .toList();
    if (selectedId == 0) {
      _categoryTitle = "Popular Products";
    } else {
      _categoryTitle =
          "${_categories.firstWhere((element) => element.id == selectedId).name} Products";
    }
    notifyListeners();
    await getProductsByCategory(selectedId);
  }

  Future<void> getProfile() async {
    final result = await _getProfile.execute();
    result.fold((error) {}, (profile) {
      _profile = profile;
      notifyListeners();
    });
  }
}
