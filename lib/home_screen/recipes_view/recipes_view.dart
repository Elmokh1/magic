import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/database/model/add_recipes.dart';
import 'package:magic_bakery/home_screen/recipes_view/recipes_view_widget.dart';

import '../../all_import.dart';

class RecipesView extends StatefulWidget {
  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  String searchQuery = '';
  late Stream<QuerySnapshot<RecipesModel>> searchStream;

  @override
  void initState() {
    super.initState();
    searchStream = MyDataBase.getRecipesRealTimeUpdate();
  }

  void handleSearch() {
    setState(() {
      if (searchQuery.isNotEmpty) {
        searchStream = MyDataBase.getRecipesCollection()
            .where('recipeName', isGreaterThanOrEqualTo: searchQuery)
            .where('recipeName', isLessThanOrEqualTo: searchQuery + '\uf8ff')
            .snapshots();
      } else {
        searchStream = MyDataBase.getRecipesRealTimeUpdate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اكتشف معانا!!",
          style: GoogleFonts.mogra(
            color: Color(0xff65451F),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "حلو النهارده ايه؟",
              style: GoogleFonts.mogra(
                color: Color(0xff65451F),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),

          /// searchbar --
          Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Container(
              width: 342,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xff65451F),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "اسم الوصفه",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Color(0xff65451F)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        handleSearch();
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          /// Recipes list --
          Expanded(
            child: StreamBuilder<QuerySnapshot<RecipesModel>>(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var recipesList =
                snapshot.data?.docs.map((doc) => doc.data()).toList();
                if (recipesList?.isEmpty == true) {
                  return Center(
                    child: Text(
                      "لا توجد نتائج للبحث",
                      style: GoogleFonts.abel(
                        fontSize: 30,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: (recipesList?.length ?? 0) ~/ 2,
                  itemBuilder: (context, index) {
                    final firstIndex = index * 2;
                    final secondIndex = firstIndex + 1;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: recipesList!.length > firstIndex
                                ? RecipesViewWidget(
                                recipesModel: recipesList![firstIndex])
                                : Container(),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: recipesList!.length > secondIndex
                                ? RecipesViewWidget(
                                recipesModel: recipesList![secondIndex])
                                : Container(),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              stream: searchStream,
            ),
          ),
        ],
      ),
    );
  }
}
