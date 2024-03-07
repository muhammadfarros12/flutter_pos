import 'dart:convert';

import 'package:flutter_pos/data/models/response/product_response_model.dart';

class AddProductResponseModel {
    final bool success;
    final String message;
    final Product data;

    AddProductResponseModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory AddProductResponseModel.fromJson(String str) => AddProductResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddProductResponseModel.fromMap(Map<String, dynamic> json) => AddProductResponseModel(
        success: json["success"],
        message: json["message"],
        data: Product.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data.toMap(),
    };
}

class Data {
    final String name;
    final int price;
    final int stock;
    final String category;
    final String image;
    final DateTime updatedAt;
    final DateTime createdAt;
    final int id;

    Data({
        required this.name,
        required this.price,
        required this.stock,
        required this.category,
        required this.image,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        name: json["name"],
        price: json["price"],
        stock: json["stock"],
        category: json["category"],
        image: json["image"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "price": price,
        "stock": stock,
        "category": category,
        "image": image,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
