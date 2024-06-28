import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/home_screen/favourite/favourite.dart';

import '../../all_import.dart';
import '../../database/model/favorite_product.dart';

class FavouritePage extends StatefulWidget {
  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Favourite Products",
          style: GoogleFonts.mogra(
            color: Color(0xff65451F),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot<FavouriteProductModel>>(
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var favouriteList =
                  snapshot.data?.docs.map((doc) => doc.data()).toList();
              if (favouriteList?.isEmpty == true) {
                return Center(
                  child: Text(
                    " ",
                    style: GoogleFonts.abel(
                      fontSize: 30,
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: favouriteList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final favourite = favouriteList![index];
                    return Column(
                      children: [
                        FavouriteView(favouriteProductModel: favourite),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    );
                  },
                ),
              );
            },
            stream: MyDataBase.getFavouriteProductsRealTimeUpdate(
                user?.uid ?? "INsWswNmAKYr4RacDJyBjUJ939I3"),
          ),
        ],
      ),
    );
  }
}
