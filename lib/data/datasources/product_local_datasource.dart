import 'dart:async';

import 'package:flutter_pos/data/models/response/product_response_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDatasource {
  ProductLocalDatasource._init();

  static final ProductLocalDatasource instance = ProductLocalDatasource._init();

  final String tableProducts = 'products';

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute("""
    CREATE TABLE $tableProducts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price INTEGER,
        stock INTEGER,
        category TEXT,
        image TEXT,
        is_best_seller INTEGER,
        is_sync INTEGER DEFAULT 0
    )
    """);
  }

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb('pos2.db');
    return _database!;
  }

  Future<void> removeAllProduct() async{
    final db = await instance.database;
    await db.delete(tableProducts);
  }

  Future<void> insertAllProduct(List<Product> products) async {
    final db = await instance.database;
    for (var product in products) {
      await db.insert(tableProducts, product.toMap());
    }
    
  }

  Future<Product> insertProduct(Product product) async {
    final db = await instance.database; 
    int id = await db.insert(tableProducts, product.toMap());
    return product.copyWith(id: id);
  }



  Future<List<Product>> getAllProduct() async {
    final db = await instance.database;
    final result = await db.query(tableProducts);
    print('coba simpan local data');
    return result.map((e) => Product.fromMap(e)).toList();
  }

}


