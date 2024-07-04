import 'package:magic_bakery/database/model/add_recipes.dart';

import '../../all_import.dart';

class RecipesPreparation extends StatelessWidget {
  RecipesModel recipesModel;

  RecipesPreparation({required this.recipesModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${recipesModel.recipeName}"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                width: 342,
                height: 240,
                decoration: BoxDecoration(
                  color: Color(0xff65451F).withOpacity(.4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 310,
                        height: 176,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage("${recipesModel.imageUrl}"),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 342,
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff65451F).withOpacity(.4),
                      offset: const Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "المقادير",
                            style: GoogleFonts.mogra(
                              color: Color(0xff65451F),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${recipesModel.ingredients}",
                            style: GoogleFonts.mogra(
                              color: Color(0xff65451F),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 342,
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff65451F).withOpacity(.4),
                      offset: const Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "التحضير",
                            style: GoogleFonts.mogra(
                              color: Color(0xff65451F),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${recipesModel.preparation}",
                            style: GoogleFonts.mogra(
                              color: Color(0xff65451F),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
