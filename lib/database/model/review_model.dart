import 'package:firebase_auth/firebase_auth.dart';

class ReviewModel {
  static const String collectionName = 'review';
  String? id;
  String? review;

  ReviewModel({
    this.id,
    this.review,
  });

  ReviewModel.fromFireStore(Map<String, dynamic>? data)
      : this(id: data?['id'], review: data?['review']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'review': review,
    };
  }
}
