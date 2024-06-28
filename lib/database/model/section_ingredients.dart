import 'package:firebase_auth/firebase_auth.dart';

class SectionsIngredientModel {
  static const String collectionName = 'Ingredient';
  String? id;
  String? name;
  double? quantity;

  SectionsIngredientModel({
    this.id,
    this.name,
    this.quantity = 0,
  });

  SectionsIngredientModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          name: data?['name'],
          quantity: data?['quantity'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }
}
