import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/home_screen/setting/user_order_item.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../MyDateUtils.dart';
import '../../all_import.dart';
import '../../database/model/Order_Model.dart';

class UserSalesScreen extends StatefulWidget {
  static const String routeName = "UserSalesScreen";

  @override
  State<UserSalesScreen> createState() => _NotDoneState();
}

class _NotDoneState extends State<UserSalesScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Uncomment the TableCalendar if needed
            // TableCalendar(
            //   firstDay: DateTime.now().subtract(Duration(days: 365)),
            //   lastDay: DateTime.now().add(Duration(days: 365)),
            //   focusedDay: focusedDate,
            //   calendarFormat: CalendarFormat.week,
            //   selectedDayPredicate: (day) {
            //     return isSameDay(selectedDate, day);
            //   },
            //   onFormatChanged: (format) => null,
            //   onDaySelected: (selectedDay, focusedDay) {
            //     setState(() {
            //       this.selectedDate = selectedDay;
            //       this.focusedDate = focusedDay;
            //       print(selectedDay);
            //     });
            //   },
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("اليوم",style: GoogleFonts.almarai(
                    fontSize:18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff6D4404),
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot<OrderModel>>(
                    stream: MyDataBase.getOrderRealTimeUpdate(
                      user!.uid,
                      MyDateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
                    ),
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
                      var OrdersList = snapshot.data!.docs.map((doc) => doc.data()).toList();
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
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final order = OrdersList[index];
                          return UserOrderItem(
                            orderModel: order,
                            userId: user!.uid,
                          );
                        },
                        itemCount: OrdersList.length,
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("الكل",style: GoogleFonts.almarai(
                    fontSize:18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff6D4404),
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot<OrderModel>>(
                    stream: MyDataBase.getAllOrderRealTimeUpdate(
                      user!.uid,
                    ),
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
                      var OrdersList = snapshot.data!.docs.map((doc) => doc.data()).toList();
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
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final order = OrdersList[index];
                          return UserOrderItem(
                            orderModel: order,
                            userId: user!.uid,
                          );
                        },
                        itemCount: OrdersList.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
