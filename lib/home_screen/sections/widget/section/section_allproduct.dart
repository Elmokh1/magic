import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/database/model/secttions_model.dart';
import 'package:magic_bakery/home_screen/sections/widget/product/poduct_details.dart';
import 'package:magic_bakery/home_screen/sections/widget/product/product%20review.dart';
import 'package:magic_bakery/home_screen/sections/widget/section/product_view_insection.dart';

import '../../../../all_import.dart';
import '../../../../database/model/add_product.dart';

class SectionAllProduct extends StatelessWidget {
  SectionsModel sectionsModel;

  SectionAllProduct({required this.sectionsModel});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(sectionsModel.name ?? ""),
        ),
        body: Container(
          color: Colors.white,
          child: StreamBuilder<QuerySnapshot<AddProductModel>>(
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var productList =
                  snapshot.data?.docs.map((doc) => doc.data()).toList();
              if (productList?.isEmpty == true) {
                return Center(
                  child: Text(
                    "!! فاضي ",
                    style: GoogleFonts.abel(
                      fontSize: 30,
                    ),
                  ),
                );
              }

              return Container(
                  child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final product = productList![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(addProductModel: product),
                        ),
                      );
                    },
                    child: ProductViewInSection(addProductModel: product),
                  );
                },
                itemCount: productList?.length ?? 0,
              ));
            },
            stream:
                MyDataBase.getAddProductsRealTimeUpdate(sectionsModel.id ?? ""),
          ),
        ),
      ),
    );
  }
}
// ListView.builder(
// itemCount: productList?.length ?? 0,
// scrollDirection: Axis.vertical,
// shrinkWrap: true,
// itemBuilder: (context, index) {
// final product = productList![index];
// return InkWell(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// ProductDetails(
// addProductModel: product),
// ),
// );
// },
// child: ProductView(addProductModel: product),
// );
// },
// ),
