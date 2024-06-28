import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/database/model/add_product.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../database/my_database.dart';

class EditProductItem extends StatefulWidget {
  final AddProductModel addProductModel;
  String secId;
  EditProductItem({required this.addProductModel,required this.secId});

  @override
  State<EditProductItem> createState() => _EditProductItemState();
}

class _EditProductItemState extends State<EditProductItem>
    with TickerProviderStateMixin {

  @override
  void dispose() {
    super.dispose();
  }

  var auth = FirebaseAuth.instance;
  User? user;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController desController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    nameController.text = widget.addProductModel.productName!;
    priceController.text = widget.addProductModel.price.toString();
    desController.text = widget.addProductModel.des!;
  }

  ImagePicker imagePicker = ImagePicker();
  String? imageUrl;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          InkWell(
                            onTap: () async {
                              XFile? xfile = await imagePicker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (xfile == null) return;

                              String uniqueFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();
                              Reference referencRoot = FirebaseStorage.instance.ref();
                              Reference referencDirImages = referencRoot.child('images');
                              Reference referencImageToUpLoad =
                              referencDirImages.child(uniqueFileName);
                              try {
                                setState(() {
                                  loading = true;
                                });
                                await referencImageToUpLoad.putFile(File(xfile.path));
                                imageUrl = await referencImageToUpLoad.getDownloadURL();
                                print("imageUrl:$imageUrl");
                              } catch (error) {
                                print(error);
                              }
                              setState(() {
                                loading = false;
                              });
                            },
                            child: Center(
                              child: loading
                                  ? CircularProgressIndicator()
                                  : CircleAvatar(
                                radius: 109,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  radius: 109,
                                  backgroundColor: Colors.grey.shade300,
                                  child: InkWell(
                                    onTap: () async {
                                      XFile? xfile = await imagePicker.pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      if (xfile == null) return;

                                      String uniqueFileName =
                                      DateTime.now().millisecondsSinceEpoch.toString();
                                      Reference referencRoot = FirebaseStorage.instance.ref();
                                      Reference referencDirImages =
                                      referencRoot.child('images');
                                      Reference referencImageToUpLoad =
                                      referencDirImages.child(uniqueFileName);
                                      try {
                                        setState(() {
                                          loading = true;
                                        });
                                        await referencImageToUpLoad
                                            .putFile(File(xfile.path));
                                        imageUrl = await referencImageToUpLoad
                                            .getDownloadURL();
                                        print("imageUrl:$imageUrl");
                                      } catch (error) {
                                        print(error);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 100,
                                      backgroundImage: imageUrl != null
                                          ? NetworkImage(imageUrl!)
                                          : NetworkImage(
                                        "${widget.addProductModel.imageUrl}",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'اسم المنتج',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextField(
                              controller: priceController,
                              decoration: InputDecoration(
                                labelText: 'سعر المنتج',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextField(
                              controller: desController,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: 'التفاصيل',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              edit();
            },
            child: Container(
              width: 240,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xff65451F),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  "تاكيد",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void edit() {
    String name = nameController.text;
    double price = double.parse(priceController.text);
    String des = desController.text;
    String? photo = imageUrl ?? widget.addProductModel.imageUrl;
    MyDataBase.editProduct(
      widget.secId,
      widget.addProductModel.id ?? "",
      name,
      des,
      price,
      photo ?? "",

    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم التعديل بنجاح")),
    );    }
}
