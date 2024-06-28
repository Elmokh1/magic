import 'package:flutter_glow/flutter_glow.dart';
import 'package:magic_bakery/check_out/cash.dart';
import 'package:magic_bakery/check_out/visa.dart';

import '../all_import.dart';
import '../database/model/Order_Model.dart';
import '../database/model/pending_order_model.dart';

class CheckOut extends StatefulWidget {
  @override
  State<CheckOut> createState() => _CheckOutState();
  List<PendingOrderModel>? pendingProductList;
  double total;
  OrderModel orderModel;
  CheckOut({required this.pendingProductList,required this.total,required this.orderModel});

}

class _CheckOutState extends State<CheckOut> {
  bool radioSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Text(
              "الدفع",
              style: GoogleFonts.poppins(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 48,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "فيزا",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GlowRadio<bool>(
                          value: true,
                          groupValue: radioSelected,
                          checkColor: Colors.white,
                          color: Colors.blueAccent,
                          onChange: (value) {
                            setState(() {
                              radioSelected = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                Container(
                  height: 48,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "كاش",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GlowRadio<bool>(
                          value: false,
                          groupValue: radioSelected,
                          checkColor: Colors.white,
                          color: Colors.blueAccent,
                          onChange: (value) {
                            setState(() {
                              radioSelected = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            radioSelected == false ? Container(
            child: Cash(pendingProductList: widget.pendingProductList,total:widget.total,orderModel: widget.orderModel,),
            ) : Container(
              child: Visa(),
            ),
          ],
        ),
      ),
    );
  }

}
