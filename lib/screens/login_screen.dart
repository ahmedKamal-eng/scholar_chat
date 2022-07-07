import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b475e),
      body: Column(
        children: [
          Image.asset('assets/images/scholar.png'),
          Text(
            'Scholar Chat',
            style: TextStyle(
                fontSize: 28, color: Colors.white, fontFamily: 'Pacifico'),
          ),
          Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          CustomTextField(
            labelText: 'email',
          ),
          CustomTextField(
            labelText: 'password',
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text('LOGIN'),
          ),
        ],
      ),
    );
  }
}
