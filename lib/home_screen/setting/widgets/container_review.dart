import 'package:flutter/material.dart';
import 'package:magic_bakery/database/model/Order_Model.dart';

class ReviewWidget extends StatelessWidget {
  OrderModel orderModel;

  ReviewWidget({required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap:  ,
      child: orderModel.isReview == false
          ? Container(
              height: 48,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "تقييم ",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
        height: 48,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                " تم ارسال المراجعه ",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
