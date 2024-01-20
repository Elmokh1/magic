import 'package:fluttertoast/fluttertoast.dart';
import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/database/model/secttions_model.dart';



class AddSections extends StatefulWidget {

  @override
  State<AddSections> createState() => _AddSectionsState();
}

class _AddSectionsState extends State<AddSections>  {
  TextEditingController sectionController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextFormField(
              Label: '',
              controller: sectionController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter section name';
                }
              }, ContainerName: 'اسم الفئه',
            ),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16)),
                  onPressed: () {
                    addSection();
                  },
                  child: const Text(
                    'Add ',
                    style: TextStyle(fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
  void addSection() async {

    if (formKey.currentState?.validate() == false) {
      return;
    }
    SectionsModel sections = SectionsModel(
      name: sectionController.text
    );


    await MyDataBase.addSections(
        sections);
    DialogUtils.hideDialog(context);
    Fluttertoast.showToast(
        msg: "Section Add Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
