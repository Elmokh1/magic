import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';

class OrderModel {
  static const String collectionName = 'order';

  String? id;
  String? customerName;
  List? cartItems;
  DateTime? dateTime;
  double? totalPrice;
  bool accept;
  bool state;
  bool isDelivery;
  bool isReview;
  OrderModel({
    this.id,
    this.customerName,
    this.cartItems,
    this.dateTime,
    this.totalPrice,
    this.accept = false,
    this.state = true,
    this.isDelivery = false,
    this.isReview = false,
  });

  OrderModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?["id"],
          customerName: data?["customerName"],
          cartItems: (data?["cartItems"] as List<dynamic>)
              .map((item) => PendingOrderModel.fromFireStore(item))
              .toList(),
          dateTime: DateTime.fromMillisecondsSinceEpoch(data?["dateTime"]),
          totalPrice: data?['totalPrice'],
          accept: data?['accept'],
          state: data?['state'],
          isDelivery: data?['isDelivery'],
          isReview: data?['isReview'],
        );

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'customerName': customerName,
      'cartItems': cartItems?.map((item) => item.toFireStore()).toList(),
      "dateTime": dateTime?.millisecondsSinceEpoch,
      'totalPrice': totalPrice,
      'accept' :accept,
      'state' :state,
      'isDelivery' :isDelivery,
      'isReview' :isReview,
    };
  }
}
