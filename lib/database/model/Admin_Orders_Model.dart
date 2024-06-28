import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';

class AdminOrderModel {
  static const String collectionName = 'order';

  String? id;
  String? uId;
  String? orderId;
  String? customerName;
  String? phone;
  String? customerAddress;
  List? cartItems;
  DateTime? dateTime;
  double? totalPrice;
  bool accept;
  bool state;
  bool isDelivery;
  bool isReview;

  AdminOrderModel({
    this.id,
    this.uId,
    this.orderId,
    this.customerName,
    this.cartItems,
    this.dateTime,
    this.phone,
    this.customerAddress,
    this.totalPrice,
    this.accept = false,
    this.state = true,
    this.isDelivery = false,
    this.isReview = false,
  });

  AdminOrderModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?["id"],
          orderId: data?["orderId"],
          uId: data?["uId"],
    phone: data?["phone"],
          customerAddress: data?["customerAddress"],
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
      'uId': uId,
      'orderId': orderId,
      'customerName': customerName,
      'cartItems': cartItems?.map((item) => item.toFireStore()).toList(),
      "dateTime": dateTime?.millisecondsSinceEpoch,
      'totalPrice': totalPrice,
      'accept' :accept,
      'state' :state,
      'isDelivery' :isDelivery,
      'isReview' :isReview,
      'customerAddress':customerAddress,
      'phone' :phone,
    };
  }
}
