import 'package:flutter/material.dart';
import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/database/model/add_recipes.dart';
import 'package:magic_bakery/home_screen/recipes_view/recipes_preparation.dart';

class RecipesViewWidget extends StatelessWidget {
  final RecipesModel recipesModel;

  RecipesViewWidget({required this.recipesModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RecipesPreparation(recipesModel: recipesModel),
                ));
          },
          child: Container(
            width: 160,
            height: 250,
            decoration: BoxDecoration(
              color: Color(0xff65451F).withOpacity(.4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 136,
                    height: 168,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("${recipesModel.imageUrl}"),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Text("${recipesModel.recipeName}"),
              ],
            ),
          ),
        )
      ],
    );
  }
}
