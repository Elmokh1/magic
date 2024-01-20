import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/database/model/add_product.dart';
import 'package:magic_bakery/database/model/secttions_model.dart';

import '../../database/model/user_model.dart';

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddSectionsState();
}

class _AddSectionsState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  String? selectedSection;
  String? selectedSectionId;
  var formKey = GlobalKey<FormState>();

  // var auth = FirebaseAuth.instance;
  // User? user;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   user = auth.currentUser;
  // }

  String? imageUrl;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          // color: Colors.white,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
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
                          await referencImageToUpLoad.putFile(File(xfile.path));
                          imageUrl =
                              await referencImageToUpLoad.getDownloadURL();
                          print("imageUrl:$imageUrl");
                        } catch (error) {
                          print(error);
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.black,
                        child: loading
                            ? const CircularProgressIndicator() // رمز الانتظار
                            : imageUrl == null
                                ? const Icon(Icons.image)
                                : CircleAvatar(
                                    radius: 75,
                                    backgroundImage: NetworkImage(
                                      imageUrl ?? "",
                                    ),
                                  ),
                      ),
                    ),
                    CustomTextFormField(
                      Label: '',
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter product named';
                        }
                      },
                      ContainerName: 'اسم المنتج',
                    ),
                    CustomTextFormField(
                      Label: '',
                      controller: priceController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter product Price';
                        }
                      },
                      ContainerName: 'سعر المنتج',
                    ),
                    CustomTextFormField(
                      Label: '',
                      controller: detailsController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter product description';
                        }
                      },
                      lines: 10,
                      ContainerName: 'التفاصيل',
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "الفئه",
                            style: TextStyle(
                              color: Color(0xff6D4404),
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: StreamBuilder<QuerySnapshot<SectionsModel>>(
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
                              var sectionList = snapshot.data?.docs
                                  .map((doc) => doc.data())
                                  .toList();
                              print(sectionList.toString());
                              if (sectionList?.isEmpty == true) {
                                return Center(
                                  child: Text(
                                    "لا توجد فئات ",
                                    style: GoogleFonts.abel(
                                      fontSize: 30,
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                height: 50,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    final section = sectionList![index];
                                    return Container(
                                      width: 342,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: const Color(0xffB6B6B6),
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Container(
                                          height: 48,
                                          child: DropdownButton<String>(
                                            value: selectedSection,
                                            items: sectionList?.map((section) {
                                              return DropdownMenuItem<String>(
                                                value: section.name,
                                                child: Text(section.name ?? ""),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedSection = newValue;
                                                var selectedSectionData =
                                                    sectionList?.firstWhere(
                                                  (section) =>
                                                      section.name == newValue,
                                                  orElse: () => SectionsModel(),
                                                );
                                                if (selectedSectionData !=
                                                    null) {
                                                  print(
                                                      'Selected section ID: ${selectedSectionData.id}');
                                                }
                                                selectedSectionId =
                                                    selectedSectionData?.id;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: 1, // Use the length of sectionList
                                ),
                              );
                            },
                            stream: MyDataBase.getSectionsRealTimeUpdate(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff65451f),
                              fixedSize: const Size(200, 100),
                              padding: const EdgeInsets.all(16)),
                          onPressed: () {
                            addProduct();
                          },
                          child: const Text(
                            'اضافه ',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addProduct() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    AddProductModel addProductModel = AddProductModel(
      imageUrl: imageUrl,
      des: detailsController.text,
      price: double.parse(priceController.text),
      productName: nameController.text,
    );

    await MyDataBase.addAddProduct(
      selectedSectionId ?? "",
      addProductModel,
    );

    DialogUtils.hideDialog(context);
    Fluttertoast.showToast(
        msg: "Product Added Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
