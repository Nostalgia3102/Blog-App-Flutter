import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText=false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
       decoration: InputDecoration(
         contentPadding: const EdgeInsets.all(27),
         hintText: hintText,
       ),
        controller: controller,
        validator: (value){
         if(value!.isEmpty){
           return "$hintText is missing";
         }
         return null;
        },
        obscureText: isObscureText,
      ),
    );
  }
}
