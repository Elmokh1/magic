import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_bakery/all_import.dart';

import 'question.dart';

class SurveyPage2 extends StatefulWidget {
  static const String routeName = "survey_page2";

  const SurveyPage2({
    super.key,
  });

  @override
  State<SurveyPage2> createState() => _SurveyPage2State();
}

int index = 0;

class _SurveyPage2State extends State<SurveyPage2> {
  var auth = FirebaseAuth.instance;
  User? user;

  bool isThirst = false;
  bool isNoThirst = false;
  bool isWeightLoss = false;
  bool isNoWeightLoss = false;
  bool isFrequentUrination = false;
  bool isNoFrequentUrination = false;

  bool isChestPain = false;
  bool isNoChestPain = false;
  bool isSwollenFeet = false;
  bool isNoSwollenFeet = false;
  bool isFatigue = false;
  bool isNoFatigue = false;

  bool isShortBreath = false;
  bool isNoShortBreath = false;
  bool isHeadache = false;
  bool isNoHeadache = false;
  bool isDizziness = false;
  bool isNoDizziness = false;

  bool isColic = false;
  bool isNoColic = false;
  bool isDiarrhea = false;
  bool isNoDiarrhea = false;
  bool isBloating = false;
  bool isNoBloating = false;
  bool isNausea = false;
  bool isNoNausea = false;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  void choseIllness() {
    if (isThirst && isWeightLoss && isFrequentUrination) {
      print("مرض السكر");
      index = 1;
      MyDataBase.editUserForSurvey(user?.uid ?? "", "AA7FQcACPxBR7eKQQqGA");
    } else if (isChestPain && isSwollenFeet && isFatigue) {
      print("مرض القلب");
      index = 2;
      MyDataBase.editUserForSurvey(user?.uid ?? "", "qqTAxEx0vZTcxX26tuoL");
    } else if (isShortBreath && isHeadache && isDizziness) {
      print("مرض الضغط");
      index = 3;
      MyDataBase.editUserForSurvey(user?.uid ?? "", "UlT4kxFNs6McaImvEDA8");
    } else if (isColic && isDiarrhea && isBloating && isNausea) {
      print("حساسية اللاكتوز");
      index = 4;
      MyDataBase.editUserForSurvey(user?.uid ?? "", "6ApcmtXOdyAicloxuh2L");
    } else {
      print("المرض غير معروف");
      MyDataBase.editUserForSurvey(user?.uid ?? "", "UlT4kxFNs6McaImvEDA8");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Center(
                          child: Text(
                            "تخطي",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ));
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 5,
                    color: Color(0xffFFF5E5),
                    height: 10,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "صحتك تهمنا",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff65451F),
                    ),
                  ),

                  // مرض السكر
                  Questions(
                    questionsText: "هل تشعر بالعطش اكثر من اللازم؟",
                    checkQuestionTrue: isThirst,
                    checkQuestionFalse: isNoThirst,
                    onTrueTap: () {
                      setState(() {
                        isThirst = true;
                        isNoThirst = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isThirst = false;
                        isNoThirst = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Questions(
                    questionsText: "هل تفقد الوزن من دون قصد؟",
                    checkQuestionTrue: isWeightLoss,
                    checkQuestionFalse: isNoWeightLoss,
                    onTrueTap: () {
                      setState(() {
                        isWeightLoss = true;
                        isNoWeightLoss = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isWeightLoss = false;
                        isNoWeightLoss = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Questions(
                    questionsText:
                    "هل تريد التبول بشكل متكرر، وخاصة في الليل؟",
                    checkQuestionTrue: isFrequentUrination,
                    checkQuestionFalse: isNoFrequentUrination,
                    onTrueTap: () {
                      setState(() {
                        isFrequentUrination = true;
                        isNoFrequentUrination = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isFrequentUrination = false;
                        isNoFrequentUrination = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // مرض القلب
                  Questions(
                    questionsText: "هل تشعر بألم او ضغط فى الصدر؟",
                    checkQuestionTrue: isChestPain,
                    checkQuestionFalse: isNoChestPain,
                    onTrueTap: () {
                      setState(() {
                        isChestPain = true;
                        isNoChestPain = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isChestPain = false;
                        isNoChestPain = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Questions(
                    questionsText: "هل تشعر بتورم فى القدمين او الكاحلين؟",
                    checkQuestionTrue: isSwollenFeet,
                    checkQuestionFalse: isNoSwollenFeet,
                    onTrueTap: () {
                      setState(() {
                        isSwollenFeet = true;
                        isNoSwollenFeet = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isSwollenFeet = false;
                        isNoSwollenFeet = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Questions(
                    questionsText: "هل تشعر بالإرهاق والتعب غير المبرر؟",
                    checkQuestionTrue: isFatigue,
                    checkQuestionFalse: isNoFatigue,
                    onTrueTap: () {
                      setState(() {
                        isFatigue = true;
                        isNoFatigue = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isFatigue = false;
                        isNoFatigue = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // مرض الضغط
                  Questions(
                    questionsText: "هل تشعر بضيق فى التنفس؟",
                    checkQuestionTrue: isShortBreath,
                    checkQuestionFalse: isNoShortBreath,
                    onTrueTap: () {
                      setState(() {
                        isShortBreath = true;
                        isNoShortBreath = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isShortBreath = false;
                        isNoShortBreath = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Questions(
                    questionsText: "هل تشعر بالصداع بشكل متكرر؟",
                    checkQuestionTrue: isHeadache,
                    checkQuestionFalse: isNoHeadache,
                    onTrueTap: () {
                      setState(() {
                        isHeadache = true;
                        isNoHeadache = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isHeadache = false;
                        isNoHeadache = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Questions(
                    questionsText: "هل تشعر بدوخة (دوار) بشكل مستمر؟",
                    checkQuestionTrue: isDizziness,
                    checkQuestionFalse: isNoDizziness,
                    onTrueTap: () {
                      setState(() {
                        isDizziness = true;
                        isNoDizziness = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isDizziness = false;
                        isNoDizziness = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // حساسية اللاكتوز
                  Questions(
                    questionsText: "هل تشعر بآلام في البطن بعد تناول منتجات الألبان؟",
                    checkQuestionTrue: isColic,
                    checkQuestionFalse: isNoColic,
                    onTrueTap: () {
                      setState(() {
                        isColic = true;
                        isNoColic = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isColic = false;
                        isNoColic = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Questions(
                    questionsText: "هل تشعر بالإسهال بعد تناول منتجات الألبان؟",
                    checkQuestionTrue: isDiarrhea,
                    checkQuestionFalse: isNoDiarrhea,
                    onTrueTap: () {
                      setState(() {
                        isDiarrhea = true;
                        isNoDiarrhea = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isDiarrhea = false;
                        isNoDiarrhea = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Questions(
                    questionsText: "هل تشعر بالإنتفاخ بعد تناول منتجات الألبان؟",
                    checkQuestionTrue: isBloating,
                    checkQuestionFalse: isNoBloating,
                    onTrueTap: () {
                      setState(() {
                        isBloating = true;
                        isNoBloating = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isBloating = false;
                        isNoBloating = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Questions(
                    questionsText: "هل تشعر بالغثيان بعد تناول منتجات الألبان؟",
                    checkQuestionTrue: isNausea,
                    checkQuestionFalse: isNoNausea,
                    onTrueTap: () {
                      setState(() {
                        isNausea = true;
                        isNoNausea = false;
                      });
                    },
                    onFalseTap: () {
                      setState(() {
                        isNausea = false;
                        isNoNausea = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      choseIllness();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(280, 50),
                      backgroundColor: const Color(0xffFDB640),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "حفظ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
