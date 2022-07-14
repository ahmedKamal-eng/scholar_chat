import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({Key? key,this.labelText,this.onChange}) : super(key: key);
   final String? labelText;
   Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty)
          {
            return 'field empty';
          }
      },
      onChanged: onChange,
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
