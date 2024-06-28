import 'dart:ffi';

import 'package:magic_bakery/database/model/section_ingredients.dart';

class AddProductModel {
  // data class
  static const String collectionName = 'Products';
  String? id;
  String? productName;
  double? price;
  String? des;
  String? imageUrl;

  // List? ingredients;

  AddProductModel({
    this.id,
    this.productName,
    this.price,
    this.des,
    this.imageUrl,
    // this.ingredients,
  });

  AddProductModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          productName: data?['productName'],
          price: data?['price'],
          des: data?['des'],
          imageUrl: data?['imageUrl'],
          // ingredients: (data?["cartItems"] as List<dynamic>)
          //     .map((item) => SectionsIngredientModel.fromFireStore(item))
          //     .toList(),
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'des': des,
      'imageUrl': imageUrl,
      // 'ingredients': ingredients?.map((item) => item.toFireStore()).toList(),
    };
  }
}
