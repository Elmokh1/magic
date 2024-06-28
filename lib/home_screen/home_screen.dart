import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/home_screen/cart/cart.dart';
import 'package:magic_bakery/home_screen/favourite/favourite.dart';
import 'package:magic_bakery/home_screen/favourite/favourite_page.dart';
import 'package:magic_bakery/home_screen/recipes_view/recipes_view.dart';
import 'package:magic_bakery/home_screen/sections/sections.dart';

import 'ai_chat_bot/chat_page.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff65451F),
        unselectedItemColor: Color(0xffE5E5E5),
        elevation: 0,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outlined,
                size: 30,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.restaurant_rounded,
                size: 30,
              ),
              label: ''),
        ],
      ),
    );
  }

  var tabs = [
    Sections(),
    FavouritePage(),
    Cart(),
    RecipesView(),
  ];
}
