import 'package:magic_bakery/database/model/add_product.dart';
import 'package:magic_bakery/database/model/add_recipes.dart';
import 'package:magic_bakery/database/model/favorite_product.dart';
import 'package:magic_bakery/database/model/favorite_product.dart';
import 'package:magic_bakery/database/model/favorite_product.dart';
import 'package:magic_bakery/database/model/favorite_product.dart';
import 'package:magic_bakery/database/model/favorite_product.dart';
import 'package:magic_bakery/database/model/favorite_product.dart';
import 'package:magic_bakery/database/model/favorite_product.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/database/model/section_ingredients.dart';
import 'package:magic_bakery/database/model/secttions_model.dart';

import 'model/Admin_Orders_Model.dart';
import 'model/Order_Model.dart';
import 'model/heart_model.dart';
import 'model/review_model.dart';
import 'model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDataBase {
  //user
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromFireStore(snapshot.data()),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUser(UserModel user) {
    var collection = getUserCollection();
    return collection.doc(user.id).set(user);
  }

  static Future<void> editUser(String uId, String userPhoto, String userName, String userAddress, String userPhone, bool isPhoto) {
    Map<String, dynamic> userData = {
      'photo': userPhoto,
      'name': userName,
      'address': userAddress,
      'phone': userPhone,
      'isPhoto': isPhoto,
    };

    return getUserCollection().doc(uId).update(userData);
  }
  static Future<void> editUserForSurvey(String uId,  String illNum) {
    Map<String, dynamic> userData = {
      'illnessNum': illNum,
    };

    return getUserCollection().doc(uId).update(userData);
  }

  static Future<UserModel?> readUser(String id) async {
    var collection = getUserCollection();
    var docSnapShot = await collection.doc(id).get();
    return docSnapShot.data();
  }

  static Stream<QuerySnapshot<UserModel>> getUserRealTimeUpdate(String uId) {
    return getUserCollection().where('id', isEqualTo: uId).snapshots();
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
  static Future<void> deleteSection(String sId) {
    return getSectionsCollection().doc(sId).delete();
  }  static Stream<QuerySnapshot<SectionsModel>> getSectionsRealTimeUpdateForRecommend(String sectionId) {
    return getSectionsCollection()
        .where("id", isEqualTo: sectionId)
        .snapshots();
  }

  //AddSectionIngredients
  static CollectionReference<SectionsIngredientModel> getSectionIngredientsCollection(String secId) {
    return getSectionsCollection()
        .doc(secId)
        .collection(SectionsIngredientModel.collectionName)
        .withConverter<SectionsIngredientModel>(
      fromFirestore: (snapshot, options) =>
          SectionsIngredientModel.fromFireStore(snapshot.data()),
      toFirestore: (product, options) => product.toFireStore(),
    );
  }

  static Future<void> addSectionIngredients(String secId, SectionsIngredientModel product) {
    var newSectionIngredients = getSectionIngredientsCollection(secId).doc();
    product.id = newSectionIngredients.id;
    return newSectionIngredients.set(product);
  }

  static Future<void> deleteSectionIngredients(String sId, String inId) {
    return getSectionIngredientsCollection(sId).doc(inId).delete();
  }
  static Future<QuerySnapshot<SectionsIngredientModel>> getSectionIngredients(String secId) {
    return getSectionIngredientsCollection(secId).get();
  }

  static Stream<QuerySnapshot<SectionsIngredientModel>> getSectionIngredientsRealTimeUpdate(String secId) {
    return getSectionIngredientsCollection(secId).snapshots();
  }


  //Heart
  static CollectionReference<HeartModel> getHeartCollection(String uid) {
    return getUserCollection()
        .doc(uid)
        .collection(HeartModel.collectionName)
        .withConverter<HeartModel>(
          fromFirestore: (snapshot, options) =>
              HeartModel.fromFireStore(snapshot.data()),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  static Future<void> addHeart(HeartModel addHeart, String uId) {
    var addsections = getHeartCollection(uId).doc();
    addHeart.id = addsections.id;
    return addsections.set(addHeart);
  }

  static Future<HeartModel?> readHeart(String id, String uId) async {
    var collection = getHeartCollection(uId);
    var docSnapShot = await collection.doc(id).get();
    return docSnapShot.data();
  }

  static Stream<QuerySnapshot<HeartModel>> getHeartRealTimeUpdate(String uId) {
    return getHeartCollection(uId).snapshots();
  }

  //AddProduct
  static CollectionReference<AddProductModel> getAddProductCollection(String secId) {
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

  static Stream<QuerySnapshot<AddProductModel>> getAddProductsRealTimeUpdate(String secId) {
    return getAddProductCollection(secId).snapshots();
  }

  static Future<void> editProduct(String secId, String productId, String name, String des, double price, String Photo) {
    return getAddProductCollection(secId).doc(productId).update({
      "price": price,
      "imageUrl": Photo,
      "productName": name,
      "des": des,
    });
  }

  //AddProductIngredients
  static CollectionReference<SectionsIngredientModel> getProductIngredientsCollection(String secId,String pId) {
    return getAddProductCollection(secId)
        .doc(pId)
        .collection(SectionsIngredientModel.collectionName)
        .withConverter<SectionsIngredientModel>(
      fromFirestore: (snapshot, options) =>
          SectionsIngredientModel.fromFireStore(snapshot.data()),
      toFirestore: (product, options) => product.toFireStore(),
    );
  }

  static Future<void> addProductIngredients(String secId,String pId, SectionsIngredientModel product) {
    var newSectionIngredients = getProductIngredientsCollection(secId,pId).doc();
    product.id = newSectionIngredients.id;
    return newSectionIngredients.set(product);
  }

  static Future<void> deleteProductIngredients(String secId,String pId, String inId) {
    return getProductIngredientsCollection(secId,pId).doc(inId).delete();
  }
  static Future<QuerySnapshot<SectionsIngredientModel>> getProductIngredients(String secId,String pId) {
    return getProductIngredientsCollection(secId,pId).get();
  }

  static Stream<QuerySnapshot<SectionsIngredientModel>> getProductIngredientsRealTimeUpdate(String secId,String pId) {
    return getProductIngredientsCollection(secId,pId).snapshots();
  }


  //AddRecipes
  static CollectionReference<RecipesModel> getRecipesCollection() {
    return FirebaseFirestore.instance
        .collection(RecipesModel.collectionName)
        .withConverter<RecipesModel>(
      fromFirestore: (snapshot, options) =>
          RecipesModel.fromFireStore(snapshot.data()),
      toFirestore: (recipes, options) => recipes.toFireStore(),
    );
  }

  static Future<void> addRecipes(RecipesModel recipes) {
    var newAddProduct = getRecipesCollection().doc();
    recipes.id = newAddProduct.id;
    return newAddProduct.set(recipes);
  }

  static Future<QuerySnapshot<RecipesModel>> getRecipes() {
    return getRecipesCollection().get();
  }

  static Stream<QuerySnapshot<RecipesModel>> getRecipesRealTimeUpdate() {
    return getRecipesCollection().snapshots();
  }

  static Future<void> editRecipes(String recipesId, String recipeName, String preparation, String ingredients, String Photo) {
    return getRecipesCollection().doc(recipesId).update({
      "ingredients": ingredients,
      "imageUrl": Photo,
      "recipeName": recipeName,
      "preparation": preparation,
    });
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

  static Future<void> deletePendingOrder(String pId, String uId) {
    return getPendingOrderCollection(uId).doc(pId).delete();
  }

  static Future<void> deleteCartItems(String uId) {
    return getPendingOrderCollection(uId).get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  static Future<void> editPendingOrder(String uId, String PId, int Quantity, double Price) {
    return getPendingOrderCollection(uId).doc(PId).update(
      {
        "quantity": Quantity,
        "totalPrice": Price,
      },
    );
  }

  //Fav
  static CollectionReference<FavouriteProductModel> getFavouriteProductCollection(String userId) {
    return getUserCollection()
        .doc(userId)
        .collection(FavouriteProductModel.collectionName)
        .withConverter<FavouriteProductModel>(
          fromFirestore: (snapshot, options) =>
              FavouriteProductModel.fromFireStore(snapshot.data()),
          toFirestore: (product, options) => product.toFireStore(),
        );
  }
  static Future<void> addFavouriteProduct(String userId, FavouriteProductModel favouriteProduct, String documentId) {
    var newFavouriteProduct =
        getFavouriteProductCollection(userId).doc(documentId);
    return newFavouriteProduct.set(favouriteProduct);
  }
  static Future<QuerySnapshot<FavouriteProductModel>> getFavouriteProducts(String userId) {
    return getFavouriteProductCollection(userId).get();
  }
  static Stream<QuerySnapshot<FavouriteProductModel>> getFavouriteProductsRealTimeUpdate(String userId) {
    return getFavouriteProductCollection(userId).snapshots();
  }
  static Future<void> deleteFavouriteProduct(String pId, String uId) {
    return getFavouriteProductCollection(uId).doc(pId).delete();
  }


//Order
  static CollectionReference<OrderModel> getOrderCollection(String uid) {
    return getUserCollection()
        .doc(uid)
        .collection(OrderModel.collectionName)
        .withConverter<OrderModel>(
          fromFirestore: (snapshot, options) {
            final data = snapshot.data() as Map<String, dynamic>;
            return OrderModel.fromFireStore(data);
          },
          toFirestore: (order, options) => order.toFirestore(),
        );
  }

  static Future<void> addOrder(String uid, OrderModel orderModel) {
    var newOrder = getOrderCollection(uid).doc();
    orderModel.id = newOrder.id;
    return newOrder.set(orderModel);
  }

  static Future<QuerySnapshot<OrderModel>> getOrder(String uId) {
    return getOrderCollection(uId).get();
  }

  static Stream<QuerySnapshot<OrderModel>> getOrderRealTimeUpdate(String uId, int date) {
    return getOrderCollection(uId)
        .where("dateTime", isGreaterThanOrEqualTo: date)
        .where("dateTime",
            isLessThan: date + 86400000) // 86400000 ميلي ثانية في يوم واحد
        .snapshots();
  }
  static Stream<QuerySnapshot<OrderModel>> getAllOrderRealTimeUpdate(String uId) {
    return getOrderCollection(uId).snapshots();
  }

  static Stream<QuerySnapshot<OrderModel>> getOrderRealTimeUpdateReview(String uId,String orderId, int date) {
    return getOrderCollection(uId)
        .where("dateTime", isGreaterThanOrEqualTo: date)
        .where("dateTime", isLessThan: date + 86400000) // 86400000 ميلي ثانية في يوم واحد
        .where("id", isEqualTo: orderId)
        .snapshots();
  }

  static Future<void> editOrder(String uId, String orderID, bool accept, bool state, bool delivery) {
    return getOrderCollection(uId).doc(orderID).update(
      {
        "accept": accept,
        "state": state,
        "isDelivery": delivery,
      },
    );
  }
  static Future<void> editOrderReview(String uId, String orderID,  bool isReview) {
    return getOrderCollection(uId).doc(orderID).update(
      {
        "isReview": isReview,

      },
    );
  }

  static Future<void> confirmOrder(String uId, String orderID, bool state, String name, double price) {
    return getOrderCollection(uId).doc(orderID).update(
      {
        "state": state,
        "customerName": name,
        "totalPrice": price,
      },
    );
  }

  //Order To Admin

  static CollectionReference<AdminOrderModel> getOrdersCollection() {
    return FirebaseFirestore.instance
        .collection(AdminOrderModel.collectionName)
        .withConverter<AdminOrderModel>(
          fromFirestore: (snapshot, options) =>
              AdminOrderModel.fromFireStore(snapshot.data()),
          toFirestore: (user, options) => user.toFirestore(),
        );
  }
  static Future<void> addOrders(AdminOrderModel orderModel) {
    var newOrder = getOrdersCollection().doc();
    orderModel.id = newOrder.id;
    return newOrder.set(orderModel);
  }
  static Stream<QuerySnapshot<AdminOrderModel>> getOrdersRealTimeUpdate(int date) {
    return getOrdersCollection()
        .orderBy("dateTime", descending: false)
        .where("dateTime", isGreaterThanOrEqualTo: date)
        .where("dateTime", isLessThan: date + 86400000)
        .snapshots();
  }
  static Stream<QuerySnapshot<AdminOrderModel>> getOrdersRealTimeUpdateWithOutDate(String uId) {
    return getOrdersCollection()
        // .orderBy("dateTime", descending: false)
        .where("uId", isEqualTo: uId)
        .snapshots();
  }
  static Future<void> editOrderInAdmin(String orderID, bool accept, bool state, bool delivery) {
    return getOrdersCollection().doc(orderID).update(
      {
        "accept": accept,
        "state": state,
        "isDelivery": delivery,
      },
    );
  }
  static Future<void> editOrderReviewInAdmin(String orderID, bool isReview) {
    return getOrdersCollection().doc(orderID).update(
      {
        "isReview": isReview,
      },
    );
  }

  //Review
  static CollectionReference<ReviewModel> getReviewCollection(String orderId) {
    return getOrdersCollection()
        .doc(orderId)
        .collection(ReviewModel.collectionName)
        .withConverter<ReviewModel>(
          fromFirestore: (snapshot, options) =>
              ReviewModel.fromFireStore(snapshot.data()),
          toFirestore: (review, options) => review.toFireStore(),
        );
  }
  static CollectionReference<ReviewModel> getAddUserReviewCollection(String uId, String orderId) {
    return getOrderCollection(uId)
        .doc(orderId)
        .collection(ReviewModel.collectionName)
        .withConverter<ReviewModel>(
          fromFirestore: (snapshot, options) =>
              ReviewModel.fromFireStore(snapshot.data()),
          toFirestore: (review, options) => review.toFireStore(),
        );
  }
  static Future<void> addReviewToAdmin(String orderId, ReviewModel review) {
    var newAddReview = getReviewCollection(orderId).doc();
    review.id = newAddReview.id;
    return newAddReview.set(review);
  }
  static Future<void> addAddReview(String uId, String orderId, ReviewModel review) {
    var newAddReview = getAddUserReviewCollection(uId, orderId).doc();
    review.id = newAddReview.id;
    return newAddReview.set(review);
  }
  static Future<QuerySnapshot<ReviewModel>> getAddReviews(String orderId) {
    return getReviewCollection(orderId).get();
  }
  static Stream<QuerySnapshot<ReviewModel>> getAddReviewsRealTimeUpdate(String orderId) {
    return getReviewCollection(orderId).snapshots();
  }
  static Stream<QuerySnapshot<ReviewModel>> getAddReviewsRealTimeUpdateForUser(String uId,String orderId) {
    return getAddUserReviewCollection(uId,orderId).snapshots();
  }
  static Future<void> editReview(String orderId, String reviewId, String review) {
    return getReviewCollection(orderId).doc(reviewId).update({
      "review": review,
    });
  }
}
