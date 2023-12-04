import '../../all_import.dart';

class Sections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                "wish you good health",
                style: GoogleFonts.mogra(
                  fontSize: 20,
                  color: Color(0xff65451F),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Divider(
                  thickness: 3,
                  color: Color(0xffF4DFBA),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("الكل"),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("مخبوزات خاليه من السكر"),
                    ),
                  ],
                ),
                Container(
                  height: 140,
                  width: double.infinity,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 10,),
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) => Container(
                        width: 240,
                        height: 140,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffE5E5E5))
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.favorite_outlined,color: Colors.red,),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text("دونتس شيكولاته",style: GoogleFonts.inter(
                                    color: Color(0xff65451F),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),),
                                ),
                                Text("20 LE",style: GoogleFonts.inter(
                                  color: Color(0xff65451F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),),
                              ],
                            ),
                            Image.asset("assets/images/Rectangle 29.png"),

                          ],
                        ),
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("الكل"),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("مخبوزات خاليه من السكر"),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 140,

                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 10,),
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) => Container(
                        width: 240,
                        height: 140,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffE5E5E5))
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.favorite_outlined,color: Colors.red,),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text("دونتس شيكولاته",style: GoogleFonts.inter(
                                    color: Color(0xff65451F),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),),
                                ),
                                Text("20 LE",style: GoogleFonts.inter(
                                  color: Color(0xff65451F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),),
                              ],
                            ),
                            Image.asset("assets/images/Rectangle 29.png"),

                          ],
                        ),
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("الكل"),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("مخبوزات خاليه من السكر"),
                    ),
                  ],
                ),
                Container(
                  height: 140,
                  width: double.infinity,
                  child:Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 10,),
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) => Container(
                        width: 240,
                        height: 140,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffE5E5E5))
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.favorite_outlined,color: Colors.red,),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text("دونتس شيكولاته",style: GoogleFonts.inter(
                                    color: Color(0xff65451F),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),),
                                ),
                                Text("20 LE",style: GoogleFonts.inter(
                                  color: Color(0xff65451F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),),
                              ],
                            ),
                            Image.asset("assets/images/Rectangle 29.png"),

                          ],
                        ),
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
