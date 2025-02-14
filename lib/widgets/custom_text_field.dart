import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: passwordVisible,
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
        prefixIcon: Icon(widget.icon, color: Colors.grey),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  passwordVisible ? Iconsax.eye_slash : Iconsax.eye,
                  color: Colors.black54,
                ),
                onPressed: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        labelText: widget.labelText,
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
