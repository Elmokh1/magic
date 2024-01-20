import 'package:magic_bakery/database/model/add_product.dart';

import '../../../../all_import.dart';

class ProductViewInSection extends StatelessWidget {
  final AddProductModel addProductModel;

  ProductViewInSection({required this.addProductModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 140,
        width: double.infinity,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: 240,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff65451F).withOpacity(.6)),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                NetworkImage("${addProductModel.imageUrl}"))),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0,top: 5),
                            child: Text(
                              "${addProductModel.productName}",
                              style: GoogleFonts.inter(
                                color: const Color(0xff65451F),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              "${addProductModel.price}EG",
                              style: GoogleFonts.inter(
                                color: const Color(0xff65451F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Color(0xff65451F),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
