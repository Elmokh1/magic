import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/database/model/add_product.dart';
import 'package:magic_bakery/database/model/secttions_model.dart';
import 'package:magic_bakery/home_screen/sections/widget/product/poduct_details.dart';
import 'package:magic_bakery/home_screen/sections/widget/product/product%20review.dart';
import 'package:magic_bakery/home_screen/sections/widget/section/section%20review.dart';
import 'package:magic_bakery/home_screen/sections/widget/section/section_allproduct.dart';

import '../../all_import.dart';

class Sections extends StatefulWidget {
  @override
  State<Sections> createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                "wish you good health",
                style: GoogleFonts.mogra(
                  fontSize: 20,
                  color: const Color(0xff65451F),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Divider(
                  thickness: 3,
                  color: Color(0xffF4DFBA),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot<SectionsModel>>(
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var sectionList =
                        snapshot.data?.docs.map((doc) => doc.data()).toList();
                    if (sectionList?.isEmpty == true) {
                      return Center(
                        child: Text(
                          "!! فاضي ",
                          style: GoogleFonts.abel(
                            fontSize: 30,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: sectionList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final section = sectionList![index];
                        final secId = section.id;

                        return Column(
                          children: [
                            InkWell(
                              child: SectionReview(sections: section),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SectionAllProduct(
                                        sectionsModel: section),
                                  ),
                                );
                              },
                            ),
                            StreamBuilder<QuerySnapshot<AddProductModel>>(
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
                                var productList = snapshot.data?.docs
                                    .map((doc) => doc.data())
                                    .toList();
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

                                return Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    height: 150,
                                    width: double.infinity,
                                    child: ListView.builder(
                                      itemCount: productList?.length ?? 0,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final product = productList![index];
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetails(
                                                        addProductModel:
                                                            product),
                                              ),
                                            );
                                          },
                                          child: ProductView(
                                              addProductModel: product),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              stream: MyDataBase.getAddProductsRealTimeUpdate(
                                  secId ?? ""),
                            ),
                            SizedBox(height: 50,)
                          ],
                        );
                      },
                    );
                  },
                  stream: MyDataBase.getSectionsRealTimeUpdate(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
