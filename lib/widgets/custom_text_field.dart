import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({Key? key,this.labelText}) : super(key: key);
   final String? labelText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle:const TextStyle(color: Colors.white),
        border:const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder:const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
