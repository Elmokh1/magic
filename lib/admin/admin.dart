import 'package:magic_bakery/admin/product/add_product.dart';
import 'package:magic_bakery/admin/sections%20/add_sections.dart';
import 'package:magic_bakery/all_import.dart';

class Admin extends StatefulWidget {
  static const String routeName = "Admin";

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "! مرحبا بك ",
          style: GoogleFonts.inter(
            fontSize: 20,
            color: Color(0xff65451F),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // SizedBox(height: 30,),
            InkWell(
              onTap: () {
                showAddSectionSheet();
              },
              child: Container(
                width: 342,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xffF4DFBA),
                ),
                child: Center(
                  child: Text(
                    "اضافه فئه ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 30,),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProduct(),
                  ),
                );
              },
              child: Container(
                width: 342,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xffF4DFBA),
                ),
                child: Center(
                  child: Text(
                    "اضافه منتج ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 30,),

            InkWell(
              onTap: () {
                showAddSectionSheet();
              },
              child: Container(
                width: 342,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xffF4DFBA),
                ),
                child: Center(
                  child: Text(
                    "تعديل منتج ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 20,),

            InkWell(
              onTap: () {
                showAddSectionSheet();
              },
              child: Container(
                width: 342,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xffF4DFBA),
                ),
                child: Center(
                  child: Text(
                    "الطلبات ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAddSectionSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: AddSections(),
          ),
        );
      },
    );
  }
// void showAddProductSheet() {
//   showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     builder: (context) {
//       return SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: AddProduct(),
//         ),
//       );
//     },
//   );
// }
}
