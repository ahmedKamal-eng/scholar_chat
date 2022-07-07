import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( ScholarChat());
}


class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
