import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magic_bakery/admin/product/add_ingredient_to_product.dart';
import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/database/model/add_product.dart';
import 'package:magic_bakery/database/model/add_recipes.dart';
import 'package:magic_bakery/database/model/secttions_model.dart';
import 'package:magic_bakery/notifications/firebase_notifications.dart';

import '../../database/model/section_ingredients.dart';
import '../../database/model/user_model.dart';

class AddRecipes extends StatefulWidget {
  @override
  State<AddRecipes> createState() => _AddSectionsState();
}

class _AddSectionsState extends State<AddRecipes> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController preparationController = TextEditingController();
  String? selectedSection;
  String? selectedSectionId;
  var formKey = GlobalKey<FormState>();
  ImagePicker imagePicker = ImagePicker();
  String? imageUrl;
  bool loading = false;

  List<SectionsIngredientModel> allSectionsIngredient = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
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
                            ? const CircularProgressIndicator()
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
                      ContainerName: 'اسم الوصفه',
                    ),
                    CustomTextFormField(
                      Label: '',
                      controller: ingredientsController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter product description';
                        }
                      },
                      lines: 10,
                      ContainerName: 'المقادير',
                    ),
                    CustomTextFormField(
                      Label: '',
                      controller: preparationController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter product description';
                        }
                      },
                      lines: 10,
                      ContainerName: 'التحضير',
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
                            addRecipes();
                          },
                          child: const Text(
                            'اضافه ',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addRecipes() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    setState(() {
      loading = true;
    });

    RecipesModel recipesModel = RecipesModel(
      imageUrl: imageUrl,
      recipeName: nameController.text,
      preparation: preparationController.text,
      ingredients: ingredientsController.text,
    );

    await MyDataBase.addRecipes(recipesModel);

    // // إرسال إشعار باستخدام FirebaseNotifications
    // await FirebaseNotifications().sendNotification(
    //   "وصفة جديدة!",
    //   "تم إضافة وصفة جديدة: ${nameController.text}",
    //   imageUrl ?? "",
    // );

    setState(() {
      loading = false;
    });

    DialogUtils.hideDialog(context);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم الاضافه بنجاح")),
    );
  }
}
