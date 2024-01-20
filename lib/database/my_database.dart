import 'package:magic_bakery/database/model/add_product.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/secttions_model.dart';

import 'model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDataBase {
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

  //Sections
  static CollectionReference<SectionsModel> getSectionsCollection() {
    return FirebaseFirestore.instance
        .collection(SectionsModel.collectionName)
        .withConverter<SectionsModel>(
          fromFirestore: (snapshot, options) =>
              SectionsModel.fromFireStore(snapshot.data()),
          toFirestore: (sections, options) => sections.toFireStore(),
        );
  }

  static Future<void> addSections(SectionsModel addSections) {
    var addsections = getSectionsCollection().doc();
    addSections.id = addsections.id;
    return addsections.set(addSections);
  }

  static Future<SectionsModel?> readSections(String id) async {
    var collection = getSectionsCollection();
    var docSnapShot = await collection.doc(id).get();
    return docSnapShot.data();
  }

  static Stream<QuerySnapshot<SectionsModel>> getSectionsRealTimeUpdate() {
    return getSectionsCollection().snapshots();
  }

  //AddProduct
  static CollectionReference<AddProductModel> getAddProductCollection(
      String secId) {
    return getSectionsCollection()
        .doc(secId)
        .collection(AddProductModel.collectionName)
        .withConverter<AddProductModel>(
          fromFirestore: (snapshot, options) =>
              AddProductModel.fromFireStore(snapshot.data()),
          toFirestore: (product, options) => product.toFireStore(),
        );
  }

  static Future<void> addAddProduct(String secId, AddProductModel product) {
    var newAddProduct = getAddProductCollection(secId).doc();
    product.id = newAddProduct.id;
    return newAddProduct.set(product);
  }

  static Future<QuerySnapshot<AddProductModel>> getAddProducts(String secId) {
    return getAddProductCollection(secId).get();
  }

  static Stream<QuerySnapshot<AddProductModel>> getAddProductsRealTimeUpdate(
      String secId) {
    return getAddProductCollection(secId).snapshots();
  }

  // pendingOrder
  static CollectionReference<PendingOrderModel> getPendingOrderCollection(String userId) {
    return getUserCollection()
        .doc(userId)
        .collection(PendingOrderModel.collectionName)
        .withConverter<PendingOrderModel>(
          fromFirestore: (snapshot, options) =>
              PendingOrderModel.fromFireStore(snapshot.data()),
          toFirestore: (product, options) => product.toFireStore(),
        );
  }

  static Future<void> addPendingOrder(String userId, PendingOrderModel pendingProduct) {
    var newPendingOrder = getPendingOrderCollection(userId).doc();
    pendingProduct.id = newPendingOrder.id;
    return newPendingOrder.set(pendingProduct);
  }

  static Future<QuerySnapshot<PendingOrderModel>> getPendingOrders(String userId) {
    return getPendingOrderCollection(userId).get();
  }

  static Stream<QuerySnapshot<PendingOrderModel>> getPendingOrdersRealTimeUpdate(String userId) {
    return getPendingOrderCollection(userId).snapshots();
  }
  static Future<void> deletePendingOrder(String pId,String uId){
    return getPendingOrderCollection(uId).doc(pId).delete();
  }
}
