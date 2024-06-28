import 'dart:ffi';

class PendingOrderModel {
  // data class
  static const String collectionName = 'PendingOrderModel';
  String? id;
  String? productName;
  double? price;
  double? totalPrice;
  String? imageUrl;
  int? quantity ;


  PendingOrderModel(
      {
        this.id,
        this.productName,
        this.price,
        this.imageUrl,
        this.quantity,
        this.totalPrice,

      }


);

  PendingOrderModel.fromFireStore(Map<String, dynamic>? data)
      : this(
    id: data?['id'],
    productName: data?['productName'],
    price: data?['price'],
    imageUrl: data?['imageUrl'],
    quantity: data?['quantity'],
    totalPrice: data?['totalPrice']
  );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'imageUrl': imageUrl,
      "quantity":quantity,
      "totalPrice":totalPrice,
    };
  }
}
