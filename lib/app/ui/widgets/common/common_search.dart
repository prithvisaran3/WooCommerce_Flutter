import 'package:flutter/material.dart';

class CommonSearch extends StatelessWidget {
  const CommonSearch({Key? key, required this.controller, this.validator})
      : super(key: key);
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: Icon(Icons.search, color: Colors.black54),
        hintStyle: TextStyle(color: Colors.grey.shade400),
        border:
        OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      ),
    );
  }
}
