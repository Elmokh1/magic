import 'package:magic_bakery/database/model/Admin_Orders_Model.dart';

import '../all_import.dart';
import '../database/model/Order_Model.dart';
import '../database/model/pending_order_model.dart';

class Cash extends StatefulWidget {
  List<PendingOrderModel>? pendingProductList;
  double total;
  OrderModel orderModel;
  Cash({required this.pendingProductList,required this.total,required this.orderModel});

  @override
  State<Cash> createState() => _CashState();
}

class _CashState extends State<Cash> {
  var phoneNumberController = TextEditingController();
  var dateController = TextEditingController();
  var cvvController = TextEditingController();
  var nameController = TextEditingController();
  var addressConfirmationController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    print(user?.uid ?? "");
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                    topLeft: Radius.circular(60),
                  ),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset("assets/images/cash.png"),
                    ),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomTextFormField(
                          Label: "",
                          controller: nameController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter full name ';
                            }
                          },
                          ContainerName: "الاسم"),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomTextFormField(
                          Label: "",
                          controller: addressConfirmationController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter full address ';
                            }
                          },
                          ContainerName: "العنوان"),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomTextFormField(
                        keyboardType: TextInputType.phone,
                          Label: "",
                          controller:phoneNumberController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter phone  ';
                            }
                          },
                          ContainerName: "رقم الهاتف "),
                    ),
                    SizedBox(height: 20,),

                    InkWell(
                      onTap: (){
                        addOrder();
                      },
                      child: Container(
                        height: 48,
                        width: 200,
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
                    SizedBox(height: 30,),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  void addOrder() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    print(widget.pendingProductList);
    String customerName = nameController.text;
    String userId = user?.uid ?? '';

    AdminOrderModel orders = await AdminOrderModel(
      orderId: widget.orderModel.id,
      customerName: customerName,
      cartItems: widget.pendingProductList,
      dateTime: DateTime.now(),
      totalPrice: widget.total,
      isDelivery: false,
      uId: userId,
      accept: false,
      state: true,
      phone:phoneNumberController.text,
      customerAddress: addressConfirmationController.text,
    );
    await MyDataBase.deleteCartItems(userId);
    await MyDataBase.confirmOrder(userId, widget.orderModel.id ?? "", true, customerName, widget.total);
    await MyDataBase.addOrders(orders);
    // print(order.id);

    DialogUtils.hideDialog(context);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم الاضافه بنجاح")),
    );    }

}
