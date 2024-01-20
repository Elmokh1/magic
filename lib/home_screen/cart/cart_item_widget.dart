import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';

class CartItemWidget extends StatefulWidget {
  PendingOrderModel pendingOrderModel;

  CartItemWidget({required this.pendingOrderModel});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int quntaty = 1;
  double price = 0.0;
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    price = quntaty * (widget.pendingOrderModel.price ?? 0.0);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: 342,
          height: 140,
          decoration: BoxDecoration(
              border: Border.all(
            color: const Color(0xff65451F).withOpacity(.6),
          )),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 62,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image:
                          NetworkImage(widget.pendingOrderModel.imageUrl ?? ""),
                    )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 108,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xff65451F).withOpacity(.6),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: const Icon(Icons.add),
                          onTap: () {
                            setState(() {
                              quntaty++;
                              print(quntaty);
                            });
                          },
                        ),
                        Text("$quntaty"),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (quntaty > 1) {
                                quntaty--;
                              }
                              print(quntaty);
                            });
                          },
                          child: Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.pendingOrderModel.productName ?? "",
                    style: const TextStyle(color: Color(0xff65451F)),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const Text(" LE"),
                      Text(
                        " ${price}" ?? "",
                        style: const TextStyle(color: Color(0xff65451F)),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  deleteItem();
                },
                child: const Icon(
                  Icons.restore_from_trash_rounded,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteItem() {
    MyDataBase.deletePendingOrder(
        widget.pendingOrderModel.id ?? "", user?.uid ?? "INsWswNmAKYr4RacDJyBjUJ939I3");
  }
}
