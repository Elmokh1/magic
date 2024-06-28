import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/database/model/add_product.dart';
import 'package:magic_bakery/database/model/section_ingredients.dart';
import 'package:magic_bakery/database/model/secttions_model.dart';

import '../../database/model/user_model.dart';

class AddSectionIngredients extends StatefulWidget {
  SectionsModel sectionsModel;

  AddSectionIngredients({required this.sectionsModel});

  @override
  State<AddSectionIngredients> createState() => _AddSectionsState();
}

class _AddSectionsState extends State<AddSectionIngredients> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  String? selectedSection;
  String? selectedSectionId;
  var formKey = GlobalKey<FormState>();
  bool isVisiable = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.sectionsModel.name}"),
        ),
        body: Container(
          // color: Colors.white,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "المكونات الاساسيه",
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisiable = !isVisiable;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff65451f),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "اضافه   ",
                          ),
                          Spacer(),
                          isVisiable == false
                              ? Icon(Icons.arrow_circle_down_sharp)
                              : Icon(Icons.arrow_circle_up_sharp),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isVisiable,
                    child: Container(
                      child: CustomTextFormField(
                        Label: '',
                        controller: nameController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter Ingredients name';
                          }
                        },
                        ContainerName: 'الاسم ',
                      ),
                    ),
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
                          addIngredients();
                        },
                        child: const Text(
                          'اضافه ',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                  Expanded(
                    child:
                        StreamBuilder<QuerySnapshot<SectionsIngredientModel>>(
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
                        var sectionIngredientsList = snapshot.data?.docs
                            .map((doc) => doc.data())
                            .toList();
                        if (sectionIngredientsList?.isEmpty == true) {
                          return Center(
                            child: Text(
                              "لا توجد مكونات ",
                              style: TextStyle(fontSize: 30),
                            ),
                          );
                        }

                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Color(0xff65451f),
                          )),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final sectionIngredients =
                                  sectionIngredientsList![index];
                              return Row(
                                children: [
                                  Text("${sectionIngredients.name}"),
                                  Spacer(),
                                  InkWell(
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        deleteIngredients(
                                            sectionIngredients.id ?? "");
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                            itemCount: sectionIngredientsList?.length ?? 0,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                          ),
                        );
                      },
                      stream: MyDataBase.getSectionIngredientsRealTimeUpdate(
                          widget.sectionsModel.id ?? ""),
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

  void addIngredients() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    SectionsIngredientModel sectionsIngredientModel = SectionsIngredientModel(
      name: nameController.text,
    );

    await MyDataBase.addSectionIngredients(
        widget.sectionsModel.id ?? "", sectionsIngredientModel);
    setState(() {
      isVisiable = false;
    });
  }

  void deleteIngredients(String inId) async {
    await MyDataBase.deleteSectionIngredients(
      widget.sectionsModel.id ?? "",
      inId,
    );
    setState(() {
      isVisiable = false;
    });
  }
}
