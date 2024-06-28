import 'package:flutter/material.dart';
import 'package:magic_bakery/admin/user_information/user_order_history_for_admin.dart';
import 'package:magic_bakery/database/model/user_model.dart';

class UserInformationItem extends StatelessWidget {
  final UserModel user;

  UserInformationItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: Colors.green,
            child: ClipOval(
              child: user.isPhoto == false
                  ? Icon(
                Icons.person,
                size: 40,
              )
                  : Image.network(
                "${user.photo}",
                fit: BoxFit.cover,
                width: 160,
                height: 160,
              ),
            ),
          ),
          SizedBox(height: 24),
          ListTile(
            leading: Icon(Icons.person, color: Colors.grey[700]),
            title: Text(
              "Name:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            subtitle: Text(
              "${user.name}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone, color: Colors.grey[700]),
            title: Text(
              "Phone:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            subtitle: Text(
              "${user.phone}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.email, color: Colors.grey[700]),
            title: Text(
              "Email:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            subtitle: Text(
              "${user.email}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.grey[700]),
            title: Text(
              "Address:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            subtitle: Text(
              "${user.address}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserOrderHistoryForAdmin(userId:user.id??""),));
            },
            child: Text(
              "الطلبات السابقة",
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
