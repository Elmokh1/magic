import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magic_bakery/admin/product/add_ingredient_widget.dart';
import 'package:magic_bakery/database/model/section_ingredients.dart';

import '../../all_import.dart';
import '../../database/model/add_product.dart';

class AddIngredientToProduct extends StatefulWidget {
  AddProductModel addProductModel;
  String secId;

  AddIngredientToProduct({required this.addProductModel, required this.secId});

  @override
  _AddIngredientToProductState createState() => _AddIngredientToProductState();
}

class _AddIngredientToProductState extends State<AddIngredientToProduct> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey,
          child: StreamBuilder<QuerySnapshot<SectionsIngredientModel>>(
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var sectionIngredientsList =
                  snapshot.data?.docs.map((doc) => doc.data()).toList();
              if (sectionIngredientsList?.isEmpty == true) {
                return Text("");
              }

              return ListView.separated(
                itemBuilder: (context, index) {
                final  sectionIngredients = sectionIngredientsList?[index];

                return AddIngredientWidget(
                  secId: widget.secId,
                  addProductModel:widget.addProductModel ,
                  ingredient: sectionIngredients,
                );
                },
                separatorBuilder: (context, index) => SizedBox(height: 20,),
                itemCount: sectionIngredientsList!.length,
              );
            },
            stream: MyDataBase.getSectionIngredientsRealTimeUpdate(
                widget.secId ?? "TwjUEARpphB1vaIdrGhr"),
          ),
        ));
  }

  void addIngredient(String name, String quantity) async {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    SectionsIngredientModel sectionsIngredientModel = SectionsIngredientModel(
      name: name,
      quantity: double.tryParse(quantity) ?? 0,
    );
    await MyDataBase.addProductIngredients(
      widget.secId,
      widget.addProductModel.id ?? "",
      sectionsIngredientModel,
    );
    print("Doneeeeeeeeeeeeeee");
  }
}
