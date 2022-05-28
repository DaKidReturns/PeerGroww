import 'package:flutter/material.dart';

class FormFieldsDecoration {
  static textFieldDecoration({required String hintText}) {
    return InputDecoration(
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
        ));
  }

  static loginTextFieldDecoration({required String hintedText}) {
    return InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
  }
}
