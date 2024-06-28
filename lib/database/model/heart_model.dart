import 'package:firebase_auth/firebase_auth.dart';

class HeartModel {
  static const String collectionName = 'Heart';
  String? id;
  String? readNum;
  DateTime? dateTime;

  HeartModel({
    this.id,
    this.readNum,
    this.dateTime,
  });

  HeartModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          readNum: data?['readNum'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(data?["dateTime"]),
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'readNum': readNum,
      "dateTime": dateTime?.millisecondsSinceEpoch,
    };
  }
}
