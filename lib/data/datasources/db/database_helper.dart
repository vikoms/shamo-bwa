import 'package:shamo_clone/data/models/cart_model.dart';
import 'package:shamo_clone/data/models/wishlist_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWishlist = 'wishlist';
  static const String _tblCart = 'cart';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/shamo.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWishlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        photo TEXT,
        price INTEGER
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblCart (
        id INTEGER PRIMARY KEY,
        name TEXT,
        photo TEXT,
        price INTEGER,
        quantity INTEGER
      );
    ''');
  }

  Future<int> insertWatchlist(WishListModel wishlist) async {
    final db = await database;
    return await db!.insert(_tblWishlist, wishlist.toJson());
  }

  Future<int> removeWatchlist(int id) async {
    final db = await database;
    return await db!.delete(
      _tblWishlist,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>?> getWishlistById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWishlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWishlist() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWishlist);

    return results;
  }

  Future<int> clearWishlist() async {
    final db = await database;
    return await db!.delete(_tblWishlist);
  }

  Future<List<Map<String, dynamic>>> getCarts() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblCart);

    return results;
  }

  Future<Map<String, dynamic>?> getCartById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblCart,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<int> insertCart(CartModel cart) async {
    final db = await database;
    return await db!.insert(_tblCart, cart.toJson());
  }

  Future<int> updateCart(CartModel cart) async {
    final db = await database;
    return await db!.update(
      _tblCart,
      cart.toJson(),
      where: 'id = ?',
      whereArgs: [cart.id],
    );
  }

  Future<int> removeCart(int id) async {
    final db = await database;
    return await db!.delete(
      _tblCart,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> clearCart() async {
    final db = await database;
    return await db!.delete(_tblCart);
  }
}
