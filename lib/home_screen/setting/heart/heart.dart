import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/database/model/heart_model.dart';
import 'package:magic_bakery/home_screen/setting/heart/heart_read_history_page.dart';

class HeartPage extends StatefulWidget {
  static const String routeName = "HeartPage";

  @override
  State<HeartPage> createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> with SingleTickerProviderStateMixin {
  List<SensorValue> data = [];
  int? bpmValue;
  var auth = FirebaseAuth.instance;
  User? user;
  bool isTimer = false;
  bool isTimerFinished = false;
  int seconds = 60;
  int totalBpm = 0;
  late Timer timer;
  double averageBpmToDataBase = 0 ;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: seconds),
    );
    _animation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.reverse(from: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Heart Rate Monitor',
          style: GoogleFonts.cairo(),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              " % تحذير هذا المعدل ليس دقيق   100",
              style: TextStyle(
                color: Colors.red ,
                fontSize: 18.0,
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HeartReadHistoryPage(),));
              },
              child: Container(
                width: 342,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xff65451F).withOpacity(.5),
                  ),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Icon(Icons.history,),
                      SizedBox(width: 10,),
                      Text("السجل ",style: TextStyle(
                        fontSize: 20,
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "من فضلك ضع اصبعك علي الكاميرا",
              style: GoogleFonts.cairo(
                fontSize: 20,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            Center(
              child: HeartBPMDialog(
                context: context,
                onRawData: (value) {
                  setState(() {
                    if (data.length == 100) data.removeAt(0);
                    data.add(value);
                  });
                },
                onBPM: (value) => setState(() {
                  bpmValue = value;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 36.0,
                    ),
                    SizedBox(width: 16),
                    Text(
                      bpmValue?.toString() ?? "",
                      style: GoogleFonts.cairo(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isTimer == false
                ? InkWell(
              onTap: () {
                setState(() {
                  isTimer = true;
                  startTimer();
                  _controller.reset();
                  _controller.forward();
                });
              },
              child: Container(
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
                        " Start ",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ):
            Container(
              child: Center(
                child: Column(
                  children: [
                    isTimerFinished == true? Container(): SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SizedBox(

                            child: CircularProgressIndicator(
                              value: _animation.value,
                              strokeWidth: 8,
                              backgroundColor: Colors.green,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),

                            ),
                            height: 150,
                            width: 150,
                          ),
                          Text("$seconds",style: TextStyle(fontSize: 40),),
                        ],
                      ),
                    ),
                    isTimerFinished == true ? InkWell(
                      onTap: () {
                        setState(() {
                          double averageBpm = totalBpm / 60;
                          averageBpmToDataBase = averageBpm;
                          addHeartReadToDateBase();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("متوسط النبض"),
                              content: Text("المتوسط: ${averageBpm.toStringAsFixed(0)}"),
                            ),
                          );
                        });
                      },
                      child: Container(
                        height: 48,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " عرض النتيجة ",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ): Container()

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  void addHeartReadToDateBase()async{
    HeartModel heartModel = HeartModel(
      readNum: averageBpmToDataBase.toString(),
      dateTime: DateTime.now(),
    );
    await MyDataBase.addHeart(heartModel, user!.uid);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم الحفظ بنجاح"),),
    );
  }
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds--;
        totalBpm += bpmValue ?? 0;
      });
      if (seconds <= 0) {
        timer.cancel();
        isTimerFinished = true;
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose();
    super.dispose();
  }
}
