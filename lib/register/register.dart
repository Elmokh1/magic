import 'package:magic_bakery/all_import.dart';
import  'package:magic_bakery/database/model/user_model.dart' as MyUser;

class RegisterScreen extends StatefulWidget {
  static const String routeName = "Register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create a  new account",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xff6D4404),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  ContainerName: "Full Name",
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Full Name ';
                    }
                  },
                  Label: "enter your name",
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  ContainerName: "E-Mail",
                  controller: emailController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Email ';
                    }
                    if (!ValidationUtils.isValidEmail(text)) {
                      return 'Please Enter a Valid Email';
                    }
                  },
                  Label: "enter your email",
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  isPassword: true,
                  ContainerName: "Password ",
                  controller: passwordController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Password ';
                    }
                  },
                  Label: "enter your password",
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  ContainerName: "Password Confirmation",
                  isPassword: true,
                  controller: passwordConfirmationController,
                  Label: "Password Confirmation",
                  // controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Password Confirmation ';
                    }
                    if (passwordController.text != text) {
                      return "password doesn't match";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CustomContainer(
                    ontap: () {
                      register();
                    },
                    color: Color(0xff65451F),
                    text: "Register ",
                    textColor: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("already have account ? "),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginPage.routeName);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  FirebaseAuth authService = FirebaseAuth.instance;

  void register() async {
    if (formkey.currentState?.validate() == false) {
      return;
    }

    DialogUtils.showLoadingDialog(context, 'Loading...');
    try {
      var result = await authService.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      var myUser = MyUser.User(
        name: nameController.text,
        email: emailController.text,
        id: result.user?.uid,
      );
      await MyDataBase.addUser(myUser);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
        context,
        "User Register Successfully",
        posActionName: "ok",
        posAction: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
        dismissible: false,
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'Something went wrong';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      DialogUtils.showMessage(context, errorMessage, posActionName: 'ok');
    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = '$e';
      DialogUtils.showMessage(context, errorMessage,
          posActionName: 'cancel', negActionName: 'Try Again', negAction: () {
        register();
      });
    }
  }
}
