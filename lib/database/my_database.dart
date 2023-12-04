import 'model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDataBase{
  //user
  static CollectionReference<User> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(User.collectionName)
        .withConverter<User>(
      fromFirestore: (snapshot, options) =>
          User.fromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFireStore(),
    );
  }
  static Future<void> addUser(User user) {
    var collection = getUserCollection();
    return collection.doc(user.id).set(user);
  }
  static Future<User?> readUser(String id) async {
    var collection = getUserCollection();
    var docSnapShot = await collection.doc(id).get();
    return docSnapShot.data();
  }
  static Stream<QuerySnapshot<User>> getUserRealTimeUpdate() {
    return getUserCollection().snapshots();
  }

}