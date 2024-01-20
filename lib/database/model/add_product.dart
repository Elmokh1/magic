import 'dart:ffi';

class AddProductModel {
  // data class
  static const String collectionName = 'Products';
  String? id;
  String? productName;
  double? price;
  String? des;
  String? imageUrl;

  AddProductModel(
      {this.id,
      this.productName,
      this.price,
      this.des,
      this.imageUrl,});

  AddProductModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          productName: data?['productName'],
          price: data?['price'],
          des: data?['des'],
          imageUrl: data?['imageUrl'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'des': des,
      'imageUrl': imageUrl,
    };
  }
}
