import 'package:magic_bakery/all_import.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "Login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController(text: "");

  var passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "LogIn to your account",
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xff6D4404),
                ),
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
              Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "forget password?",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xff9B9B9B),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: CustomContainer(
                  ontap: () {
                    Login();
                  },
                  color: Color(0xff65451F),
                  text: "Login",
                  textColor: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don`t have account ? "),
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                  }, child: Text("register",style: TextStyle(
                    color: Colors.blue,
                  ),))
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  FirebaseAuth authService = FirebaseAuth.instance;

  void Login() async {
    // async - await
    if (formKey.currentState?.validate() == false) {
      return;
    }
    DialogUtils.showLoadingDialog(context, 'Loading...');
    try {
      var result = await authService.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      var user = await MyDataBase.readUser(result.user?.uid ?? "");
      if (user == null) {
        DialogUtils.showMessage(context, "Error to ind user in db",
            posActionName: 'ok');
        return;
      }
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
        context,
        "User Logged in  Successfully",
        posActionName: "ok",
        posAction: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
        dismissible: false,
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'wrong email or password';
      DialogUtils.showMessage(context, errorMessage, posActionName: 'ok');
    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = '$e';
      DialogUtils.showMessage(context, errorMessage,
          posActionName: 'cancel', negActionName: 'Try Again', negAction: () {
        Login();
      });
    }
  }
}
