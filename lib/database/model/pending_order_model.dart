import 'dart:ffi';

class PendingOrderModel {
  // data class
  static const String collectionName = 'PendingOrderModel';
  String? id;
  String? productName;
  String? note;
  double? price;
  double? totalPrice;
  String? imageUrl;
  int? quantity ;
  PendingOrderModel(
      {
        this.id,
        this.productName,
        this.note,
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
    note: data?['note'],
    price: data?['price'],
    imageUrl: data?['imageUrl'],
    quantity: data?['quantity'],
    totalPrice: data?['totalPrice']
  );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'productName': productName,
      'note': note,
      'price': price,
      'imageUrl': imageUrl,
      "quantity":quantity,
      "totalPrice":totalPrice,
    };
  }
}
