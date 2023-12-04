import 'package:magic_bakery/all_import.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // locale: const Locale('en'), // تحديد اللغة إلى العربية
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        SplashPage2.routeName: (context) => SplashPage2(),
        LoginPage.routeName: (context) => LoginPage(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName :(context) => HomeScreen(),
      },
      initialRoute:HomeScreen.routeName,

    );
  }
}


