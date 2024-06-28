import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Questions extends StatefulWidget {
  String questionsText;
  bool checkQuestionTrue;
  bool checkQuestionFalse;
  Function onTrueTap;
  Function onFalseTap;

  Questions(
      {super.key,
      required this.questionsText,
      required this.checkQuestionTrue,
      required this.checkQuestionFalse,
        required this.onTrueTap,
        required this.onFalseTap,
      });

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xffF5F5F5),
        ),
        child: Column(
          children: [
            Text(
              widget.questionsText,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            // choice ?
            Row(
              children: [
                Text(
                  "نعم",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.onTrueTap();
                      widget.checkQuestionTrue = true;
                      widget.checkQuestionFalse = false;
                    });
                  },
                  icon: Icon(widget.checkQuestionTrue == true
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "لا",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 22,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.onFalseTap();
                      widget.checkQuestionFalse = true;
                      widget.checkQuestionTrue = false;
                    });
                  },
                  icon: Icon(widget.checkQuestionFalse == true
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
