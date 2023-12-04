import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_bakery/componant/custom_container.dart';
import 'package:magic_bakery/login/login_screen.dart';
import 'package:magic_bakery/register/register.dart';

class SplashPage2 extends StatelessWidget {
  static const String routeName = "Splash2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/Rectangle 25.png"),
          fit: BoxFit.fill,
        )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Magic bakery",
                style: GoogleFonts.mogra(
                  decoration: TextDecoration.none,
                  color: Color(0xff6D4404),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "100% natural..\nall products baked\n with love for your health eating healthy makes you happy",
                style: GoogleFonts.mogra(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 150,),
            Center(
              child: CustomContainer(
                ontap:(){
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                } ,
                color: Color(0xff65451F),
                text: "Login",
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: CustomContainer(
                ontap: (){
                  Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                },
                color: Colors.white,
                text: "Create Account",
                textColor:  Color(0xff65451F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
