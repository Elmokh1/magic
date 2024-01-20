import 'package:fluttertoast/fluttertoast.dart';
import 'package:magic_bakery/database/model/add_product.dart';
import 'package:magic_bakery/database/model/pending_order_model.dart';

import '../../../../all_import.dart';

class ProductDetails extends StatefulWidget {
  AddProductModel addProductModel;

  ProductDetails({required this.addProductModel});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 120),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) => RotationTransition(
                                  turns: _animation,
                                  child: CircleAvatar(
                                    radius: 109,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: 109,
                                      backgroundColor: Colors.grey.shade300,
                                      child: CircleAvatar(
                                        radius: 100,
                                        backgroundImage: NetworkImage(
                                            "${widget.addProductModel.imageUrl}"),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "اسم المنتج : ${widget.addProductModel.productName}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "سعر المنتج : EG  ${widget.addProductModel.price}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "التفاصيل : \n${widget.addProductModel.des}"
                                  .trim(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Order();
            },
            child: Container(
              width: 240,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xff65451F),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  "اطلب الان ",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void Order() {
    PendingOrderModel pendingProduct = PendingOrderModel(
      productName: widget.addProductModel.productName,
      price: widget.addProductModel.price,
      imageUrl: widget.addProductModel.imageUrl,
    );
    MyDataBase.addPendingOrder(user?.uid ??"INsWswNmAKYr4RacDJyBjUJ939I3", pendingProduct);
    Fluttertoast.showToast(
        msg: "Product Added Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

  }
}
