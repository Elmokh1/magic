import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/review_model.dart';
import 'package:magic_bakery/home_screen/setting/widgets/container_review.dart';

import '../../all_import.dart';
import '../../database/model/Order_Model.dart';

class UserOrderItem extends StatefulWidget {
  final OrderModel orderModel;
  String userId;

  UserOrderItem({required this.orderModel, required this.userId});

  @override
  State<UserOrderItem> createState() => _UserOrderItemState();
}

class _UserOrderItemState extends State<UserOrderItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
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
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.2),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ), // Adjust the value to control the roundness
                  ),
                  child: Center(
                    child: Text(
                      " ${widget.orderModel.customerName ?? 'empty'}",
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                for (var cartItem
                    in widget.orderModel.cartItems ?? <PendingOrderModel>[])
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Builder(
                        builder: (context) {
                          if (widget.orderModel.isDelivery == false &&
                              widget.orderModel.state == true &&
                              widget.orderModel.accept == false) {
                            return const Text(
                              "لسه شويه",
                              style: TextStyle(
                                color: Color(0xff65451F),
                                fontSize: 30,
                              ),
                            );
                          } else if (widget.orderModel.isDelivery == true &&
                              widget.orderModel.state == true &&
                              widget.orderModel.accept == true) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "تم التوصيل",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 30,
                                  ),
                                ),
                                InkWell(
                                  child: ReviewWidget(
                                      orderModel: widget.orderModel),
                                  onTap: () {
                                    widget.orderModel.isReview == false
                                        ? addReview()
                                        : Container();
                                  },
                                ),
                              ],
                            );
                          } else if (widget.orderModel.isDelivery == false &&
                              widget.orderModel.state == false &&
                              widget.orderModel.accept == false) {
                            return const Text(
                              "تم الالغاء",
                              style: TextStyle(
                                color: Color(0xff65451F),
                                fontSize: 30,
                              ),
                            );
                          }

                          return Text(
                            "جاري التوصيل",
                            style: TextStyle(
                              color: Color(0xff65451F),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void addReview() async
  {
    TextEditingController reviewController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Image.asset("assets/images/Vector.png"),
              ),
              Text("طلبك وصل ؟"),
              SizedBox(height: 10,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.arrow_turn_left_down),
                    Text("قيمه من هنا  "),
                  ],
                ),
              ),

              SizedBox(height: 10,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  minLines: 4,
                  maxLines: 15,
                  controller: reviewController,
                  decoration: InputDecoration(
                    hintText: 'اكتب تعليقك هنا',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true, // لمحاذاة النص مع الحقل عند التوسيع
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0), // تباعد النص داخل الحقل
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String reviewText = reviewController.text;
                  if (reviewText.isNotEmpty) {
                    ReviewModel reviewModel = ReviewModel(review: reviewText);
                    // await MyDataBase.addReviewToAdmin(widget.orderModel.id ?? "", reviewModel);
                    await MyDataBase.addAddReview(widget.userId ?? "", widget.orderModel.id ?? "", reviewModel);
                    await MyDataBase.editOrderReview(widget.userId ?? "", widget.orderModel.id ?? "", true);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("تم الحفظ بنجاح"),
                      ),
                    );
                    Navigator.pop(context); // إغلاق الـ dialog
                  }
                },
                child: Text('إرسال'),
              ),
            ],
          ),
        );
      },
    );

  }

  void editReview() async {
    ReviewModel reviewModel = ReviewModel(
      review: "Elmokh",
    );
  }
}
