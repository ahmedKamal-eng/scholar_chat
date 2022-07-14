import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({ this.onTap,required this.text});
  String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(

        padding: EdgeInsets.all(10),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: Text('$text')),
      ),
    );
  }
}
