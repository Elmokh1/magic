import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_bakery/splash/splash2.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "Splash";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SplashPage2()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/Rectangle 21.png",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/Rectangle 16.png",
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/Rectangle 23.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 120.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Ellipse 6.png"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Baked with love",
                      style: GoogleFonts.mogra(
                        decoration: TextDecoration.none,
                        color: Color(0xff6D4404),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
