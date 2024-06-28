import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_bakery/admin/order/order_item.dart';
import 'package:magic_bakery/admin/user_information/user_information.dart';
import 'package:magic_bakery/database/model/Admin_Orders_Model.dart';
import 'package:magic_bakery/database/model/user_model.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../MyDateUtils.dart';
import '../../database/model/Order_Model.dart';
import '../../database/my_database.dart';

class SalesScreen extends StatefulWidget {
  static const String routeName = "SalesScreen";

  final UserModel? user;

  SalesScreen({this.user});

  @override
  State<SalesScreen> createState() => _NotDoneState();
}

class _NotDoneState extends State<SalesScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(Duration(days: 365)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            focusedDay: focusedDate,
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDate, day);
            },
            onFormatChanged: (format) => null,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDate = selectedDay;
                this.focusedDate = focusedDay;
                print(selectedDay);
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot<AdminOrderModel>>(
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data == null) {
                    return Text("Data is null");
                  }
                  var OrdersList =
                      snapshot.data!.docs.map((doc) => doc.data()).toList();
                  print("OrdersList: $OrdersList"); // Add this line to debug
                  if (OrdersList.isEmpty) {
                    return Center(
                      child: Text(
                        "No orders available",
                        style: GoogleFonts.abel(
                          fontSize: 30,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final order = OrdersList[index];
                      // if (order.accept == true){
                      //   return SizedBox.shrink();
                      // }
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserInformation(
                                    userId: order.uId ??"",
                                  ),
                                ));
                          },
                          child: OrderItemForAdmin(
                            orderModel: order,
                            userId: widget.user?.id ?? "",
                            selectedDate: selectedDate,
                          ));
                    },
                    itemCount: OrdersList.length,
                  );
                },
                stream: MyDataBase.getOrdersRealTimeUpdate(
                  MyDateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
