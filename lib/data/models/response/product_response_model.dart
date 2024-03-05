import 'dart:convert';

import 'package:flutter/widgets.dart';

class ProductResponseModel {
    final bool success;
    final String message;
    final List<Product> data;

    ProductResponseModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ProductResponseModel.fromJson(String str) => ProductResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductResponseModel.fromMap(Map<String, dynamic> json) => ProductResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Product {
    final int? id;
    final String name;
    final String? description;
    final int price;
    final int stock;
    final String category;
    final String image;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final bool isBestSeller;
    final bool isSync;

    Product({
        this.id,
        required this.name,
        this.description,
        required this.price,
        required this.stock,
        required this.category,
        required this.image,
        this.createdAt,
        this.updatedAt,
        this.isBestSeller = false,
        this.isSync = true,
    });

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"] ?? " ",
        price: json["price"],
        stock: json["stock"],
        category: json["category"],
        // category: categoryValues.map[json["category"]]!,
        image: json["image"] ?? " ",
        isBestSeller: json["isBestSeller"] == 1 ? true : false,
        isSync: json["isSync"] == null ? true : json["isSync"] == 1 ? true : false,

    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "price": price,
        "stock": stock,
        "category": category,
        "image": image,
        "is_best_seller": isBestSeller ? 1 : 0,
        "is_sync": isSync ? 1 : 0,
    };

  Product copyWith({
    int? id,
    String? name,
    ValueGetter<String?>? description,
    int? price,
    int? stock,
    String? category,
    String? image,
    ValueGetter<DateTime?>? createdAt,
    ValueGetter<DateTime?>? updatedAt,
    bool? isBestSeller,
    bool? isSync,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description != null ? description() : this.description,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      category: category ?? this.category,
      image: image ?? this.image,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
      updatedAt: updatedAt != null ? updatedAt() : this.updatedAt,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      isSync: isSync ?? this.isSync,
    );
  }
}
