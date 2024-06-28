import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/database/model/heart_model.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

class HeartReadHistoryPage extends StatefulWidget {
  static const String routeName = "HeartReadHistoryPage";

  @override
  State<HeartReadHistoryPage> createState() => _HeartReadHistoryPageState();
}

class _HeartReadHistoryPageState extends State<HeartReadHistoryPage> {
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    print(user?.uid ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("سجل معدل ضربات القلب"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text(" ! تحذير هذا المعدل ليس دقيق",  style: TextStyle(
              color: Colors.red ,
              fontSize: 18.0,
            ),),
            SizedBox(height: 20,), // Add some space for better layout
            StreamBuilder<QuerySnapshot<HeartModel>>(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var heartList = snapshot.data?.docs.map((doc) => doc.data()).toList();
                if (heartList?.isEmpty == true) {
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
                  shrinkWrap: true, // Make ListView scrollable inside SingleChildScrollView
                  physics: NeverScrollableScrollPhysics(), // Disable ListView's scroll
                  itemCount: heartList?.length,
                  itemBuilder: (context, index) {
                    HeartModel heartReading = heartList![index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '❤️ ${heartReading.readNum}',
                                style: TextStyle(
                                  color: Colors.red ,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                ' : معدل النبض',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${formattedDateTime(heartReading.dateTime!)}',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                ' : التاريخ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${formattedDateTimeInHours(heartReading.dateTime!)}',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                ' : الساعة',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              stream: MyDataBase.getHeartRealTimeUpdate(user!.uid), // Replace 'yourUserId' with the actual user ID
            ),
          ],
        ),
      ),
    );
  }

  String formattedDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime); // تنسيق التاريخ والوقت حسب الرغبة
  }

  String formattedDateTimeInHours(DateTime dateTime) {
    return DateFormat(' hh:mm a').format(dateTime); // تنسيق التاريخ والوقت حسب الرغبة
  }
}
