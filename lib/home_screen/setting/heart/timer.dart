import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int seconds = 0;
  late Timer timer;
  bool isTimerFinished = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            isTimerFinished == true? Container(): Text(
              ' $seconds ',
              style: TextStyle(fontSize: 40),
            ),
         isTimerFinished == true ? InkWell(
           onTap: () {
             setState(() {
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
                     " عرض النتيجه ",
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
    );
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
      if (seconds >= 3) {
        timer.cancel();
        // Here you can add your logic after the timer finishes
        print('Timer finished!');
        // Future.delayed(Duration(milliseconds: 500), () {
        //   Navigator.pop(context); // Close the page
        // });
        isTimerFinished = true;
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
