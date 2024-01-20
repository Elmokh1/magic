import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String Label;
  TextEditingController controller;
  MyValidator validator;
  bool isPassword;
  int lines;
  String ContainerName;
  CustomTextFormField({
    required this.Label,
    this.isPassword = false,
    required this.controller,
    required this.validator,
    required this.ContainerName,
    this.lines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(ContainerName,style: TextStyle(
              color:Color(0xff6D4404),
              fontSize: 18,
            ),),
          ),
          Container(
            // width: 342,
            // height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Color(0xffB6B6B6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextFormField(
                maxLines: lines,
                minLines: lines,
                obscureText: isPassword,
                validator: validator,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Label,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
