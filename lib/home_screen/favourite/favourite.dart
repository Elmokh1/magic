import 'package:magic_bakery/database/model/add_product.dart';
import 'package:magic_bakery/database/model/favorite_product.dart';
import 'package:magic_bakery/home_screen/sections/widget/product/poduct_details.dart';

import '../../all_import.dart';

class FavouriteView extends StatefulWidget {
  final FavouriteProductModel favouriteProductModel;

  FavouriteView({required this.favouriteProductModel});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
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
          textDirection: TextDirection.rtl,
          child: InkWell(
            onTap: () {
            toDetails();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff65451F).withOpacity(.6),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    children: [],
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "${widget.favouriteProductModel.productName}",
                            style: GoogleFonts.inter(
                              color: const Color(0xff65451F),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          "${widget.favouriteProductModel.price}EG",
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
                            "${widget.favouriteProductModel.imageUrl}",
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
      ),
    );
  }

  toDetails() {
    AddProductModel addProductModel = AddProductModel(
      productName: widget.favouriteProductModel.productName,
      price: widget.favouriteProductModel.price,
      imageUrl: widget.favouriteProductModel.imageUrl,
      des: widget.favouriteProductModel.des,
    );
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProductDetails(addProductModel: addProductModel),
        ));
  }
}
