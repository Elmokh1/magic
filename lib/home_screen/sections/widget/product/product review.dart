import 'package:magic_bakery/database/model/add_product.dart';

import '../../../../all_import.dart';

class ProductView extends StatelessWidget {
  final AddProductModel addProductModel;

  ProductView({required this.addProductModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 140,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: 240,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff65451F).withOpacity(.6)),
            ),
            child: Row(
              children: [
                const Column(
                  children: [
                    Icon(
                      Icons.favorite_outlined,
                      color: Colors.red,
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
                          "${addProductModel.productName}",
                          style: GoogleFonts.inter(
                            color: const Color(0xff65451F),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        "${addProductModel.price}EG",
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
                            image:
                                NetworkImage("${addProductModel.imageUrl}"))),
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
