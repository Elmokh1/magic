import '../all_import.dart';

class Visa extends StatefulWidget {
  @override
  State<Visa> createState() => _VisaState();
}

class _VisaState extends State<Visa> {
  var formkey = GlobalKey<FormState>();
  var visaNumerController = TextEditingController();
  var dateController = TextEditingController();
  var cvvController = TextEditingController();
  var nameController = TextEditingController();
  var addressConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
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
                        child: Image.asset("assets/images/visa.png"),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomTextFormField(
                          Label: "",
                          controller: visaNumerController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter full num ';
                            }
                          },
                          ContainerName: "رقم البطاقه"),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex:2,
                          child: CustomTextFormField(
                              Label: "",
                              controller: nameController,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return 'Please Enter full name ';
                                }
                              },
                              ContainerName: "cvv"),
                        ),
                        Expanded(
                          flex:2,

                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTextFormField(
                                Label: "",
                                controller: addressConfirmationController,
                                validator: (text) {
                                  if (text == null || text.trim().isEmpty) {
                                    return 'Please Enter full address ';
                                  }
                                },
                                ContainerName: "صلاحيه البطاقه"),
                          ),
                        ),
                      ],
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
                    SizedBox(height: 20,),

                    InkWell(
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
}
