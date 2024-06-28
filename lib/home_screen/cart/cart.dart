import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/check_out/check_out.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/home_screen/cart/cart_item_widget.dart';

import '../../all_import.dart';
import '../../database/model/Order_Model.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var auth = FirebaseAuth.instance;
  User? user;
  List<PendingOrderModel>? pendingProduct;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  double total = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تسوق"),
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
              double totalAmount = 0;
              for (var product in pendingProductList!) {
                totalAmount +=
                    (product.totalPrice ?? 0) * (product.quantity ?? 1);
                total = totalAmount;
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
                        print(totalAmount);
                        print(total);
                        total = totalAmount;
                        final product = pendingProductList![index];
                        pendingProduct = pendingProductList;
                        return CartItemWidget(pendingOrderModel: product);
                      },
                    ),
                  ),
                ),
              );
            },
            stream: MyDataBase.getPendingOrdersRealTimeUpdate(user?.uid ?? ""),
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
                      color: const Color(0xff65451F),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "$total",
                    style: GoogleFonts.inter(
                      color: const Color(0xff65451F),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print(pendingProduct?[0].quantity);
              setState(() {
                Order();
              });
            },
            child: Container(
              height: 48,
              width: 342,
              decoration: BoxDecoration(
                color: const Color(0xff65451F),
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
          ),
        ],
      ),
    );
  }

  Future<void> Order() async {
    OrderModel order = OrderModel(
      customerName: "",
      cartItems: pendingProduct,
      dateTime: DateTime.now(),
      totalPrice: 0.0,
      isDelivery: false,
      state: true,
    );
    await MyDataBase.addOrder(user!.uid, order);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckOut(
            pendingProductList: pendingProduct,
            total: total,
            orderModel: order,
          ),
        ));
  }
}
