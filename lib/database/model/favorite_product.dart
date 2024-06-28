import 'dart:ffi';

class FavouriteProductModel {
  // data class
  static const String collectionName = 'Favourite';
  String? id;
  String? productName;
  double? price;
  String? imageUrl;
  bool? isFavourite = true;
  String? des;

  FavouriteProductModel(
      {
        this.id,
        this.productName,
        this.price,
        this.imageUrl,
        this.des,
        isFavourite,
      }


      );

  FavouriteProductModel.fromFireStore(Map<String, dynamic>? data)
      : this(
      id: data?['id'],
      productName: data?['productName'],
      price: data?['price'],
      imageUrl: data?['imageUrl'],
    isFavourite: data?['isFavourite'],
    des: data?['des'],

  );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'imageUrl': imageUrl,
      'isFavourite': isFavourite,
      'des': des,
    };
  }
}
