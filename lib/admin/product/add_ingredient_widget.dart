import 'package:magic_bakery/database/model/add_product.dart';
import 'package:magic_bakery/database/model/section_ingredients.dart';

import '../../all_import.dart';

class AddIngredientWidget extends StatefulWidget {
  SectionsIngredientModel? ingredient;
  AddProductModel addProductModel;
  String secId;

  AddIngredientWidget(
      {required this.ingredient,
      required this.addProductModel,
      required this.secId});

  @override
  State<AddIngredientWidget> createState() => _AddIngredientWidgetState();
}

class _AddIngredientWidgetState extends State<AddIngredientWidget> {
  TextEditingController _quantityController = TextEditingController();

  bool isVisiable = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisiable,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  "${widget.ingredient?.name}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    addIngredient();
                  },
                  child: Text("Add"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addIngredient() async {
    SectionsIngredientModel sectionsIngredientModel = SectionsIngredientModel(
      name: widget.ingredient?.name ?? "",
      quantity: double.parse(_quantityController.text),
    );
    await MyDataBase.addProductIngredients(
        widget.secId, widget.addProductModel.id ?? "", sectionsIngredientModel);
    setState(() {
      isVisiable = false;

    });
  }
}
