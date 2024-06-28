import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/admin/user_information/order_history_item.dart';
import 'package:magic_bakery/database/model/Admin_Orders_Model.dart';
import 'package:magic_bakery/database/model/Order_Model.dart';

import '../../all_import.dart';
import '../../database/model/user_model.dart';

class UserOrderHistoryForAdmin extends StatelessWidget {
  String userId;

  UserOrderHistoryForAdmin({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      StreamBuilder<QuerySnapshot<AdminOrderModel>>(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var orderList = snapshot.data?.docs.map((doc) => doc.data()).toList();
          if (orderList?.isEmpty == true) {
            return Center(
              child: Text(
                "!! فاضي ",
                style: GoogleFonts.abel(
                  fontSize: 30,
                ),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final order = orderList;
              // return Text("data");
              return OrderItemHistoryForAdmin(
                  orderModel: order![index], userId: userId);
            },
            itemCount: 1,
          );
        },
        stream: MyDataBase.getOrdersRealTimeUpdateWithOutDate(
            userId),
      ),
    );
  }
}
