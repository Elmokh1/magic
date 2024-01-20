import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/home_screen/cart/cart_item_widget.dart';

import '../../all_import.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
        title: Text("تسوق"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot<PendingOrderModel>>(
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var pendingProductList =
                  snapshot.data?.docs.map((doc) => doc.data()).toList();
              if (pendingProductList?.isEmpty == true) {
                return Center(
                  child: Text(
                    "لا يوجد منتجات ",
                    style: GoogleFonts.abel(
                      fontSize: 30,
                    ),
                  ),
                );
              }

              return Directionality(
                textDirection: TextDirection.rtl,
                child: Expanded(
                  child: Container(
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: pendingProductList?.length ?? 0,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final product = pendingProductList![index];
                        return CartItemWidget(pendingOrderModel: product);
                      },
                    ),
                  ),
                ),
              );
            },
            stream: MyDataBase.getPendingOrdersRealTimeUpdate(
                user?.uid ?? "INsWswNmAKYr4RacDJyBjUJ939I3"),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(
                    "المبلغ الكلي",
                    style: GoogleFonts.inter(
                      color: Color(0xff65451F),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 48,
            width: 342,
            decoration: BoxDecoration(
              color: Color(0xff65451F),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                "تاكيد",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
