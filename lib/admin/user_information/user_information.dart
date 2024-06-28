import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_bakery/admin/user_information/user_information_item.dart';

import '../../all_import.dart';
import '../../database/model/user_model.dart';

class UserInformation extends StatelessWidget {

  String userId;

  UserInformation({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot<UserModel>>(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var userList = snapshot.data?.docs
              .map((doc) => doc.data())
              .toList();
          if (userList?.isEmpty == true) {
            return Center(
              child: Text(
                "!! فاضي ",
                style: GoogleFonts.abel(
                  fontSize: 30,
                ),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final user = userList;
              return UserInformationItem(user: user![index],);
            },
            itemCount: 1,
          );
        },
        stream: MyDataBase.getUserRealTimeUpdate(
            userId), // Replace 'yourUserId' with the actual user ID
      ),
    );
  }
}
