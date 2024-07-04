import 'package:magic_bakery/all_import.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';

class CartItemWidget extends StatefulWidget {
  final PendingOrderModel pendingOrderModel;
  final VoidCallback onQuantityChanged;

  CartItemWidget({
    required this.pendingOrderModel,
    required this.onQuantityChanged,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int quantity = 1;
  double totalPrice = 0.0;
  final auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    quantity = widget.pendingOrderModel.quantity ?? 1;
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    totalPrice = quantity * (widget.pendingOrderModel.price ?? 0.0);
  }

  @override
  Widget build(BuildContext context) {
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
            ),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 62,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.pendingOrderModel.imageUrl ?? ""),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                              quantity++;
                              widget.pendingOrderModel.quantity = quantity;
                              calculateTotalPrice();
                              editPendingProduct();
                            });
                            widget.onQuantityChanged(); // Notify parent
                          },
                        ),
                        Text("$quantity"),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity--;
                                widget.pendingOrderModel.quantity = quantity;
                                calculateTotalPrice();
                                editPendingProduct();
                              }
                            });
                            widget.onQuantityChanged(); // Notify parent
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
                  const SizedBox(height: 20),
                  Text(
                    widget.pendingOrderModel.productName ?? "",
                    style: const TextStyle(color: Color(0xff65451F)),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const Text(" LE"),
                      Text(
                        " ${widget.pendingOrderModel.totalPrice ?? ''}",
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
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  void editPendingProduct() {
    double newPrice = quantity * (widget.pendingOrderModel.price ?? 0.0);
    MyDataBase.editPendingOrder(
        user?.uid ?? "",
        widget.pendingOrderModel.id ?? "",
        quantity,
        newPrice
    );
  }

  void deleteItem() {
    MyDataBase.deletePendingOrder(widget.pendingOrderModel.id ?? "", user?.uid ?? "");
  }
}
