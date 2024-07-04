import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/database/model/user_model.dart';
import 'package:magic_bakery/home_screen/setting/heart/heart.dart';
import 'package:magic_bakery/home_screen/setting/history.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
  String photo;
  String name;
  String address;
  String phone;

  Setting(
      {required this.photo,
      required this.name,
      required this.address,
      required this.phone});
}

class _SettingState extends State<Setting> {
  bool editProfile = false;
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController(text: "");
  var addressController = TextEditingController(text: "");
  var phoneController = TextEditingController(text: "");
  ImagePicker imagePicker = ImagePicker();
  String? imageUrl;
  bool loading = false;
  bool photoAdded = false;
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    nameController.text = widget.name;
    addressController.text = widget.address;
    phoneController.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("تم تسجيل الخروج بنجاح")),
                );
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("حدث خطأ أثناء تسجيل الخروج: $e")),
                );
              }
            },
            child: Container(
              child: CircleAvatar(
                child: Icon(Icons.logout, color: Colors.red),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
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
                    photoAdded = true;
                  });
                },
                child: loading
                    ? const CircularProgressIndicator()
                    : imageUrl == null && widget.photo.trim().isEmpty
                        ? CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 40,
                            child: const Icon(
                              Icons.add_a_photo_sharp,
                              size: 40,
                              color: Colors.white,
                            ))
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              imageUrl ?? widget.photo,
                            ),
                          ),
              ),
            ),
            Text(
              "${widget.name}",
              style: GoogleFonts.inter(
                color: const Color(0xff65451F),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  editProfile = !editProfile;
                  print(editProfile);
                });
              },
              child: Container(
                width: 342,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xff65451F).withOpacity(.5),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: editProfile == false
                            ? const Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xff65451F),
                                size: 40,
                              )
                            : const Icon(
                                Icons.arrow_drop_up,
                                color: Color(0xff65451F),
                                size: 40,
                              )),
                    const Spacer(),
                    Text(
                      "تعديل الملف الشخصي",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.edit_note_outlined,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            editProfile == true
                ? Container(
                    height: 300,
                    width: 342,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 10,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Directionality(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: CustomTextFormField(
                                    ContainerName: "الاسم",
                                    Label: "",
                                    validator: (text) {
                                      if (text == null || text.trim().isEmpty) {
                                        return 'Please Enter Name ';
                                      }
                                    },
                                    controller: nameController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        Directionality(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: CustomTextFormField(
                                    ContainerName: "العنوان ",
                                    Label: "",
                                    validator: (text) {
                                      if (text == null || text.trim().isEmpty) {
                                        return 'Please Enter address ';
                                      }
                                    },
                                    controller: addressController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        Directionality(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: CustomTextFormField(
                                    keyboardType: TextInputType.phone,
                                    ContainerName: "رقم التليفون",
                                    Label: "",
                                    validator: (text) {
                                      if (text == null || text.trim().isEmpty) {
                                        return 'Please Enter phone number ';
                                      }
                                    },
                                    controller: phoneController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserSalesScreen(),
                    ));
              },
              child: Container(
                width: 342,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xff65451F).withOpacity(.5),
                  ),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.history,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "السجل ",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                editUserData();
              },
              child: Container(
                height: 48,
                width: 342,
                decoration: BoxDecoration(
                  color: Color(0xff65451F),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "تاكيد",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void editUserData() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    if (imageUrl == null && widget.photo == "") {
      photoAdded = false;
    }
    photoAdded = true;
    await MyDataBase.editUser(
      user?.uid ?? "",
      imageUrl ?? widget.photo,
      nameController.text,
      addressController.text,
      phoneController.text,
      photoAdded,
    );

    DialogUtils.hideDialog(context);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم  التعديل بنجاح")),
    );
  }
}
