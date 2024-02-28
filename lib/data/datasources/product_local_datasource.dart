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
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute("""
    CREATE TABLE $tableProducts(
      id INTEGER PRIMARY KEY AUTO INCREAMENT,
      name TEXT,
      price INTEGER,
      stock INTEGER,
      image TEXT,
      category TEXT
    )
    """);
  }

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb('pos.db');
    return _database!;
  }

  Future<void> removeAllProduct() async{
    final db = await instance.database;
    await db.delete(tableProducts);
  }

  Future<void> insertProduct(List<Product> products) async {
    final db = await instance.database;
    for (var product in products) {
      await db.insert(tableProducts, product.toMap());
    }
  }

}


