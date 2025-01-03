import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magic_bakery/admin/product/edit_product/edit_product.dart';
import 'package:magic_bakery/database/model/add_product.dart';
import 'package:magic_bakery/database/model/secttions_model.dart';
import 'package:magic_bakery/database/model/user_model.dart';
import 'package:magic_bakery/home_screen/sections/widget/product/poduct_details.dart';
import 'package:magic_bakery/home_screen/sections/widget/product/product%20review.dart';
import 'package:magic_bakery/home_screen/sections/widget/section/section%20review.dart';
import 'package:magic_bakery/home_screen/sections/widget/section/section_allproduct.dart';
import 'package:magic_bakery/home_screen/setting/settings.dart';

import '../../../all_import.dart';
import 'edit_product_item.dart';

class EditProductPage extends StatefulWidget {
  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    print(user?.uid ?? "");
  }

  @override
  Widget build(BuildContext context) {
    String userId = user?.uid ?? "";
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        // appBar: AppBar(
        //   title: Column(
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.only(left: 50.0),
        //             child: Text(
        //               "wish you good health",
        //               style: GoogleFonts.mogra(
        //                 fontSize: 20,
        //                 color: const Color(0xff65451F),
        //               ),
        //             ),
        //           ),
        //           Expanded(
        //             child: StreamBuilder<QuerySnapshot<UserModel>>(
        //               builder: (context, snapshot) {
        //                 if (snapshot.hasError) {
        //                   return Text(snapshot.error.toString());
        //                 }
        //                 if (snapshot.connectionState ==
        //                     ConnectionState.waiting) {
        //                   return const Center(
        //                     child: CircularProgressIndicator(),
        //                   );
        //                 }
        //                 var userList = snapshot.data?.docs
        //                     .map((doc) => doc.data())
        //                     .toList();
        //                 if (userList?.isEmpty == true) {
        //                   return Center(
        //                     child: Text(
        //                       "!! فاضي ",
        //                       style: GoogleFonts.abel(
        //                         fontSize: 30,
        //                       ),
        //                     ),
        //                   );
        //                 }
        //                 return Container(
        //                   height: 40,
        //                   child: ListView.builder(
        //                     itemBuilder: (context, index) {
        //                       final user = userList;
        //                       return InkWell(
        //                         onTap: () {
        //                           Navigator.push(
        //                             context,
        //                             MaterialPageRoute(
        //                               builder: (context) => Setting(
        //                                 photo: user?[index].photo??"",
        //                                 address: user?[index].address??"",
        //                                 name: user?[index].name??"",
        //                                 phone: user?[index].phone??"",
        //                               ),
        //                             ),
        //                           );
        //                           print(user?[index].id);
        //                           print(user?[index].photo);
        //                           print(user?[index].isPhoto);
        //                         },
        //                         child: CircleAvatar(
        //                           radius: 20,
        //                           backgroundColor: Colors.transparent,
        //                           child: ClipOval(
        //                             child: user?[index].isPhoto == false
        //                                 ? Icon(Icons.person,
        //                                 size: 40)
        //                                 : Image.network(
        //                               "${user?[index].photo}",
        //                               fit: BoxFit.cover,
        //                               width: 40,
        //                               height: 40,
        //                             ),
        //                           ),
        //                         ),
        //                       );
        //                     },
        //                     itemCount: 1,
        //                   ),
        //                 );
        //               },
        //               stream: MyDataBase.getUserRealTimeUpdate(
        //                   userId), // Replace 'yourUserId' with the actual user ID
        //             ),
        //           ),
        //         ],
        //       ),
        //       const Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 20.0),
        //         child: Divider(
        //           thickness: 3,
        //           color: Color(0xffF4DFBA),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
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
                              child: SectionReview(
                                  sectionsName: section.name ?? ""),
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
                                                    EditProductItem(
                                                  addProductModel: product,
                                                  secId: section.id ?? "",
                                                ),
                                              ),
                                            );
                                          },
                                          child: ProductView(
                                            addProductModel: product,
                                            isVisible: false,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              stream: MyDataBase.getAddProductsRealTimeUpdate(
                                  secId ?? ""),
                            ),
                            SizedBox(
                              height: 50,
                            )
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
