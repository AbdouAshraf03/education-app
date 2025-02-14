import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.icon,
      required this.keyboardType,
      required this.labelText,
      required this.controller,
      this.isPassword = false});
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final IconData icon;
  bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      enableSuggestions: false,
      // textDirection: TextDirection.rtl,
      cursorColor: const Color.fromARGB(255, 28, 113, 194),
      style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 28, 113, 194),
            )),
        prefixIcon: Icon(icon, color: Colors.grey),
        floatingLabelAlignment: FloatingLabelAlignment.start,

        //focusColor: Color.fromARGB(255, 28, 113, 194),

        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey,
              textBaseline: TextBaseline.alphabetic,
            ),
      ),
    );
  }
}
