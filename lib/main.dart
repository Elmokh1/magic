import 'package:magic_bakery/admin/admin.dart';
import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/home_screen/survey/survey_2.dart';

import 'home_screen/setting/heart/heart.dart';
import 'home_screen/setting/heart/heart_read_history_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        SplashPage2.routeName: (context) => SplashPage2(),
        LoginPage.routeName: (context) => LoginPage(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        Admin.routeName: (context) => Admin(),
        SurveyPage2.routeName: (context) => SurveyPage2(),
        HeartPage.routeName: (context) => HeartPage(),
        HeartReadHistoryPage.routeName: (context) => HeartReadHistoryPage(),
      },
      initialRoute: user != null ? HomeScreen.routeName : SplashPage.routeName,
      // initialRoute: Admin.routeName,
    );
  }
}
