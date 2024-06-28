import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/database/model/add_product.dart';
import 'package:magic_bakery/database/model/favorite_product.dart';

import '../../../../all_import.dart';

class ProductView extends StatefulWidget {
  final AddProductModel addProductModel;
  bool isVisible;
  ProductView({required this.addProductModel,required this.isVisible});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  var auth = FirebaseAuth.instance;
  User? user;
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 140,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            width: 240,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff65451F).withOpacity(.6),
              ),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    StreamBuilder<QuerySnapshot<FavouriteProductModel>>(
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        var favouriteProductList = snapshot.data?.docs
                            .map((doc) => doc.data() as FavouriteProductModel)
                            .toList();

                        bool isProductInFavorites =
                            favouriteProductList != null &&
                                favouriteProductList.any((product) =>
                                    product.productName ==
                                    widget.addProductModel.productName);

                        return GestureDetector(
                          onTap: () {
                            if (isProductInFavorites) {
                              // Remove from favorites
                              MyDataBase.deleteFavouriteProduct(
                                widget.addProductModel.id ?? "",
                                user?.uid ?? "",
                              );
                            } else {
                              // Add to favorites
                              addFavourite(!isProductInFavorites);
                            }
                          },
                          child: Visibility(
                            visible: widget.isVisible,
                            child: Icon(
                              isProductInFavorites
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isProductInFavorites
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                        );
                      },
                      stream: MyDataBase.getFavouriteProductsRealTimeUpdate(
                        user?.uid ?? "",
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "${widget.addProductModel.productName}",
                          style: GoogleFonts.inter(
                            color: const Color(0xff65451F),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.addProductModel.price}EG",
                        style: GoogleFonts.inter(
                          color: const Color(0xff65451F),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "${widget.addProductModel.imageUrl}",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addFavourite(bool isFav) {
    setState(() {
      isFavourite = isFav;
    });

    var favouriteProduct = FavouriteProductModel(
      imageUrl: widget.addProductModel.imageUrl,
      price: widget.addProductModel.price,
      productName: widget.addProductModel.productName,
      isFavourite: isFav,
      des: widget.addProductModel.des,
    );
    MyDataBase.addFavouriteProduct(
      user?.uid ?? "",
      favouriteProduct,
      widget.addProductModel.id ?? "",
    );
  }
}
