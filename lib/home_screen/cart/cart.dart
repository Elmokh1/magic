import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/check_out/check_out.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';
import 'package:magic_bakery/home_screen/cart/cart_item_widget.dart';
import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/database/model/Order_Model.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var auth = FirebaseAuth.instance;
  User? user;
  List<PendingOrderModel>? pendingProduct;
  double total = 0.0; // To store the total amount

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  void calculateTotalAmount() {
    if (pendingProduct != null) {
      total = pendingProduct!.fold(
          0.0, (sum, item) => sum + (item.price ?? 0.0) * (item.quantity ?? 1));
    }
  }

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
              pendingProduct = snapshot.data?.docs
                  .map((doc) => doc.data())
                  .toList();
              if (pendingProduct?.isEmpty == true) {
                return Center(
                  child: Text(
                    "لا يوجد منتجات ",
                    style: GoogleFonts.abel(
                      fontSize: 30,
                    ),
                  ),
                );
              }

              // Calculate total amount
              calculateTotalAmount();

              return Directionality(
                textDirection: TextDirection.rtl,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: pendingProduct?.length ?? 0,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final product = pendingProduct![index];
                      return CartItemWidget(
                        pendingOrderModel: product,
                        onQuantityChanged: () {
                          setState(() {
                            calculateTotalAmount();
                          });
                        },
                      );
                    },
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
      totalPrice: total,
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
