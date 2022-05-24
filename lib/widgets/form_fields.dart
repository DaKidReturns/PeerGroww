import 'package:flutter/material.dart';

class FormFields {
  static textField1({required String hintText}) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
