import 'dart:convert';

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
    final int id;
    final String name;
    final String description;
    final int price;
    final int stock;
    final String category;
    final String image;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    // final int isBestSeller;

    Product({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.stock,
        required this.category,
        required this.image,
        this.createdAt,
        this.updatedAt,
        // required this.isBestSeller,
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
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "price": price,
        "stock": stock,
        "category": category,
        "image": image,
        
    };
}

enum Category {
    DRINK,
    FOOD,
    SNACK
}

final categoryValues = EnumValues({
    "drink": Category.DRINK,
    "food": Category.FOOD,
    "snack": Category.SNACK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
