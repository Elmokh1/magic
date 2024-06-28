import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:magic_bakery/admin/admin.dart';
import 'package:magic_bakery/database/model/Admin_Orders_Model.dart';
import 'package:magic_bakery/database/model/review_model.dart';
import 'package:intl/intl.dart';

import '../../MyDateUtils.dart';
import '../../all_import.dart';
import '../../database/model/Order_Model.dart';

class OrderItemHistoryForAdmin extends StatefulWidget {
  final AdminOrderModel orderModel;
  String userId;

  OrderItemHistoryForAdmin({
    required this.orderModel,
    required this.userId,
  });

  @override
  State<OrderItemHistoryForAdmin> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItemHistoryForAdmin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Container(
          // padding: EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            // Background color
            borderRadius: BorderRadius.circular(12.0),
            // Adjust the value to control the roundness
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 2), // Offset
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   width: 400,
                //   height: 150,
                //   decoration: BoxDecoration(
                //     color: Colors.green.withOpacity(.2),
                //     borderRadius: const BorderRadius.only(
                //       bottomLeft: Radius.circular(20),
                //       bottomRight: Radius.circular(20),
                //     ), // Adjust the value to control the roundness
                //   ),
                //   child: Center(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Center(
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: SizedBox(
                //               height: 20,
                //               child: StreamBuilder<QuerySnapshot<ReviewModel>>(
                //                 builder: (context, snapshot) {
                //                   if (snapshot.hasError) {
                //                     print(snapshot.error);
                //
                //                     return Text("Error: ");
                //                   }
                //                   if (snapshot.connectionState ==
                //                       ConnectionState.waiting) {
                //                     return const Center(
                //                       child: CircularProgressIndicator(),
                //                     );
                //                   }
                //                   if (snapshot.data == null) {
                //                     return Text("");
                //                   }
                //                   var OrdersList = snapshot.data!.docs
                //                       .map((doc) => doc.data())
                //                       .toList();
                //                   print(
                //                       "OrdersList: $OrdersList"); // Add this line to debug
                //                   if (OrdersList.isEmpty) {
                //                     return Center(
                //                       child: Text(
                //                         "",
                //                         style: GoogleFonts.abel(
                //                           fontSize: 30,
                //                         ),
                //                       ),
                //                     );
                //                   }
                //
                //                   return Center(
                //                     child: SizedBox(
                //                       height: 50,
                //                       child: ListView.builder(
                //                         itemBuilder: (context, index) {
                //                           final order = OrdersList[index];
                //                           // if (order.accept == true){
                //                           //   return SizedBox.shrink();
                //                           // }
                //                           print(order.review);
                //                           return InkWell(
                //                             onTap: () {
                //                               showDialog(
                //                                 context: context,
                //                                 builder: (context) {
                //                                   return AlertDialog(
                //                                     title: Center(
                //                                         child:
                //                                             Text(' التعليق')),
                //                                     content: Center(
                //                                         child: Text(
                //                                             order.review ??
                //                                                 "")),
                //                                     actions: [
                //                                       TextButton(
                //                                         onPressed: () {
                //                                           Navigator.of(context)
                //                                               .pop(); // لإغلاق الـ AlertDialog
                //                                         },
                //                                         child: Text('إغلاق'),
                //                                       ),
                //                                     ],
                //                                   );
                //                                 },
                //                               );
                //                             },
                //                             child: Icon(
                //                               Icons.rate_review,
                //                             ),
                //                           );
                //                         },
                //                         itemCount: 1,
                //                       ),
                //                     ),
                //                   );
                //                 },
                //                 stream: MyDataBase
                //                     .getAddReviewsRealTimeUpdateForUser(
                //                   widget.userId ?? "",
                //                   widget.orderModel.id ?? "",
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //         Directionality(
                //           textDirection: TextDirection.rtl,
                //           child: Row(
                //             children: [
                //               Text(
                //                 " الاسم :  ",
                //                 style: GoogleFonts.aBeeZee(
                //                   color: Colors.black,
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //               Text(
                //                 " ${widget.orderModel.customerName ?? 'empty'}",
                //                 style: const TextStyle(
                //                   color: Colors.red,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Directionality(
                //           textDirection: TextDirection.rtl,
                //           child: Row(
                //             children: [
                //               Text(
                //                 " العنوان :  ",
                //                 style: GoogleFonts.aBeeZee(
                //                   color: Colors.black,
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         SizedBox(
                //           height: 10,
                //         ),
                //
                //       ],
                //     ),
                //   ),
                // ),
                Center(
                  child: Text(
                      formatDate(widget.orderModel.dateTime ?? DateTime.now())),
                ),
                for (var cartItem in widget.orderModel.cartItems ?? [])
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: Text("${cartItem.productName ?? 'N/A'}")),
                        Expanded(
                            flex: 2,
                            child: Center(
                                child: Column(
                              children: [
                                Text(
                                    " ${cartItem.quantity?.toString() ?? 'empty'}"),
                              ],
                            ))),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                '${cartItem.price.toString()}' ?? 'N/A',
                                style: const TextStyle(),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const Text('\$' ?? 'N/A'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Divider(
                  thickness: 1,
                  color: Colors.green.withOpacity(.4),
                ),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ), // Adjust the value to control the roundness
                  ),
                  child: Center(
                    child: Text(
                      "Total Price:  ${widget.orderModel.totalPrice ?? 'N/A'} \$",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // if (!widget.orderModel.isDelivery &&
                    //     widget.orderModel.state &&
                    //     !widget.orderModel.accept)
                    //   GestureDetector(
                    //     child: Container(
                    //       padding: const EdgeInsets.all(10),
                    //       child: Text(
                    //         "تم التوصيل ؟",
                    //         style: TextStyle(fontSize: 20),
                    //       ),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.black),
                    //       ),
                    //     ),
                    //   ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    if (!widget.orderModel.isDelivery &&
                        !widget.orderModel.state &&
                        !widget.orderModel.accept)
                      Text(
                        "تم الرفض",
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    widget.orderModel.isDelivery &&
                            widget.orderModel.state &&
                            widget.orderModel.accept
                        ? Text(
                            "تم التوصيل",
                            style: GoogleFonts.cairo(
                              fontSize: 20,
                              color: Colors.green,
                            ),
                          )
                        : Text("لم يتم التحديد"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String formatDate(DateTime dateTime) {
    DateFormat formatter = DateFormat('yyyy-MM-dd     HH:mm a');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }
}
