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

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    bool isThirst = false;
    bool isNoThirst = false;
    bool isShortBreath = false;
    bool isNoShortBreath = false;
    bool isDifficultyBreathing = false;
    bool isNoDifficultyBreathing = false;
    bool isColic = false;
    bool isNoColic = false;

    void choseIllness() {
      if (isThirst == true && isNoThirst == false) {
        print("مرض السكر");
        index = 1;
        MyDataBase.editUserForSurvey(user?.uid ?? "", "1");
      } else if (isShortBreath == true && isNoShortBreath == false) {
        print("مرض القلب");
        index = 2;
        MyDataBase.editUserForSurvey(user?.uid ?? "", "2");
      } else if (isDifficultyBreathing == true &&
          isNoDifficultyBreathing == false) {
        print("مرض الضغط");
        index = 3;
        MyDataBase.editUserForSurvey(user?.uid ?? "", "3");
      } else if (isColic == true && isNoColic == false) {
        print("حساسية اللاكتوز");
        index = 4;
        MyDataBase.editUserForSurvey(user?.uid ?? "", "4");
      } else {
        print("المرض غير معروف");
        MyDataBase.editUserForSurvey(user?.uid ?? "", "0");
      }
    }

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

                  //مرض السكر
                  Questions(
                    questionsText: "هل تشعر بالعطش اكثر من اللازم؟",
                    checkQuestionTrue: isThirst,
                    checkQuestionFalse: isNoThirst,
                    onTrueTap: () {
                      isNoThirst = false;
                      isThirst = true;
                    },
                    onFalseTap: () {
                      isNoThirst = true;
                      isThirst = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //سكر
                  Questions(
                    questionsText: "هل تفقدان الوزن من دون قصد؟",
                    checkQuestionTrue: isThirst,
                    checkQuestionFalse: isNoThirst,
                    onTrueTap: () {
                      isNoThirst = false;
                      isThirst = true;
                    },
                    onFalseTap: () {
                      isNoThirst = true;
                      isThirst = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // مرض السكر
                  Questions(
                    questionsText:
                        "هل تريد التبول بشكل متكرر، وخاصة في الليل ؟",
                    checkQuestionTrue: isShortBreath,
                    checkQuestionFalse: isNoShortBreath,
                    onTrueTap: () {
                      isNoThirst = false;
                      isThirst = true;
                    },
                    onFalseTap: () {
                      isNoThirst = true;
                      isThirst = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // مرض السكر
                  Questions(
                    questionsText: "هل تشعر صعوبة فى التنفس مع دوخان؟",
                    checkQuestionTrue: isDifficultyBreathing,
                    checkQuestionFalse: isNoDifficultyBreathing,
                    onTrueTap: () {
                      isNoThirst = false;
                      isThirst = true;
                    },
                    onFalseTap: () {
                      isNoThirst = true;
                      isThirst = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //السكر
                  Questions(
                    questionsText: "هل تشعر بتنميل فى اليدين او القدميين؟",
                    checkQuestionTrue: isDifficultyBreathing,
                    checkQuestionFalse: isNoDifficultyBreathing,
                    onTrueTap: () {
                      isNoThirst = false;
                      isThirst = true;
                    },
                    onFalseTap: () {
                      isNoThirst = true;
                      isThirst = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // مرض القلب
                  Questions(
                    questionsText: "هل تشعر بألم او ضغط فى الصدر؟",
                    checkQuestionTrue: isShortBreath,
                    checkQuestionFalse: isNoShortBreath,
                    onTrueTap: () {
                      isNoShortBreath = false;
                      isShortBreath = true;
                    },
                    onFalseTap: () {
                      isNoShortBreath = true;
                      isShortBreath = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //القلب
                  Questions(
                    questionsText: "هل تشعر بضيق فى التنفس؟",
                    checkQuestionTrue: isShortBreath,
                    checkQuestionFalse: isNoShortBreath,
                    onTrueTap: () {
                      isNoShortBreath = false;
                      isShortBreath = true;
                    },
                    onFalseTap: () {
                      isNoShortBreath = true;
                      isShortBreath = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // القلب
                  Questions(
                    questionsText: "هل تشعر بتورم فى القدمين او الكاحلين؟",
                    checkQuestionTrue: isShortBreath,
                    checkQuestionFalse: isNoShortBreath,
                    onTrueTap: () {
                      isNoShortBreath = false;
                      isShortBreath = true;
                    },
                    onFalseTap: () {
                      isNoShortBreath = true;
                      isShortBreath = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // القلب
                  Questions(
                    questionsText: "هل تشعر بالإرهاق والتعب غير المبرر ؟",
                    checkQuestionTrue: isShortBreath,
                    checkQuestionFalse: isNoShortBreath,
                    onTrueTap: () {
                      isNoShortBreath = false;
                      isShortBreath = true;
                    },
                    onFalseTap: () {
                      isNoShortBreath = true;
                      isShortBreath = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //مرض الضغط
                  Questions(
                    questionsText: "هل تشعر بالصداع الشديد؟",
                    checkQuestionTrue: isDifficultyBreathing,
                    checkQuestionFalse: isNoDifficultyBreathing,
                    onTrueTap: () {
                      isNoDifficultyBreathing = false;
                      isDifficultyBreathing = true;
                    },
                    onFalseTap: () {
                      isNoDifficultyBreathing = true;
                      isDifficultyBreathing = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // الضغط
                  Questions(
                    questionsText: "هل تشعر بضيق فى التنفس ؟",
                    checkQuestionTrue: isDifficultyBreathing,
                    checkQuestionFalse: isNoDifficultyBreathing,
                    onTrueTap: () {
                      isNoDifficultyBreathing = false;
                      isDifficultyBreathing = true;
                    },
                    onFalseTap: () {
                      isNoDifficultyBreathing = true;
                      isDifficultyBreathing = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //الضغط
                  Questions(
                    questionsText: "هل تعانى من مشاكل في الرؤية؟",
                    checkQuestionTrue: isDifficultyBreathing,
                    checkQuestionFalse: isNoDifficultyBreathing,
                    onTrueTap: () {
                      isNoDifficultyBreathing = false;
                      isDifficultyBreathing = true;
                    },
                    onFalseTap: () {
                      isNoDifficultyBreathing = true;
                      isDifficultyBreathing = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //الضغط
                  Questions(
                    questionsText: "هل تشعر بنبضات قلب غير منتظمة أو قوية ؟",
                    checkQuestionTrue: isDifficultyBreathing,
                    checkQuestionFalse: isNoDifficultyBreathing,
                    onTrueTap: () {
                      isNoDifficultyBreathing = false;
                      isDifficultyBreathing = true;
                    },
                    onFalseTap: () {
                      isNoDifficultyBreathing = true;
                      isDifficultyBreathing = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //حساسية اللاكتوز
                  Questions(
                    questionsText: "هل تشعر بالامتلاء أو الانتفاخ في البطن ؟",
                    checkQuestionTrue: isColic,
                    checkQuestionFalse: isNoColic,
                    onTrueTap: () {
                      isNoColic = false;
                      isColic = true;
                    },
                    onFalseTap: () {
                      isNoColic = true;
                      isColic = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //حساسية اللاكتوز
                  Questions(
                    questionsText: "هل تشعر بزيادة في الغازات المعوية؟",
                    checkQuestionTrue: isColic,
                    checkQuestionFalse: isNoColic,
                    onTrueTap: () {
                      isNoColic = false;
                      isColic = true;
                    },
                    onFalseTap: () {
                      isNoColic = true;
                      isColic = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // حساسية اللاكتوز
                  Questions(
                    questionsText: "هل تشعر بألم أو تشنجات في البطن؟",
                    checkQuestionTrue: isColic,
                    checkQuestionFalse: isNoColic,
                    onTrueTap: () {
                      isNoColic = false;
                      isColic = true;
                    },
                    onFalseTap: () {
                      isNoColic = true;
                      isColic = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //حساسية اللاكتوز
                  Questions(
                    questionsText:
                        "هل يوجد براز سائل بعد تناول منتجات الألبان؟",
                    checkQuestionTrue: isColic,
                    checkQuestionFalse: isNoColic,
                    onTrueTap: () {
                      isNoColic = false;
                      isColic = true;
                    },
                    onFalseTap: () {
                      isNoColic = true;
                      isColic = false;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (isThirst ||
                          isNoThirst ||
                          isShortBreath ||
                          isNoShortBreath ||
                          isDifficultyBreathing ||
                          isNoDifficultyBreathing) {
                        choseIllness();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                      } else {
                        print("يرجى الإجابة على جميع الأسئلة");
                      }
                    },
                    child: Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xffc8c1c1)),
                      child: const Text(
                        "انتهيت",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
