import 'dart:ffi';

class PendingOrderModel {
  // data class
  static const String collectionName = 'PendingOrderModel';
  String? id;
  String? productName;
  double? price;
  String? imageUrl;

  PendingOrderModel(
      {this.id,
        this.productName,
        this.price,
        this.imageUrl,});

  PendingOrderModel.fromFireStore(Map<String, dynamic>? data)
      : this(
    id: data?['id'],
    productName: data?['productName'],
    price: data?['price'],
    imageUrl: data?['imageUrl'],
  );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
