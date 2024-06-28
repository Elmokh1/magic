import 'dart:ffi';

import 'package:magic_bakery/database/model/section_ingredients.dart';

class RecipesModel {
  // data class
  static const String collectionName = 'Recipes';
  String? id;
  String? recipeName;
  String? ingredients;
  String? preparation;
  String? imageUrl;

  // List? ingredients;

  RecipesModel({
    this.id,
    this.recipeName,
    this.ingredients,
    this.preparation,
    this.imageUrl,
    // this.ingredients,
  });

  RecipesModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          recipeName: data?['recipeName'],
          ingredients: data?['Ingredients'],
          preparation: data?['preparation'],
          imageUrl: data?['imageUrl'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'recipeName': recipeName,
      'Ingredients': ingredients,
      'preparation': preparation,
      'imageUrl': imageUrl,
    };
  }
}
