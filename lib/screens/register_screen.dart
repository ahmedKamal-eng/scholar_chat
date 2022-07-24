import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  static String id = 'registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey=GlobalKey();
  bool isLoad=false;

  @override
  Widget build(BuildContext context) {
    String? email;
    String? pass;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ModalProgressHUD(
          inAsyncCall: isLoad,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),
                  Hero(
                      tag: 'i',
                      child: Image.asset('assets/images/scholar.png')),
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                        fontSize: 28, color: Colors.white, fontFamily: 'Pacifico'),
                  ),
                  Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    onChange: (s) {
                      email = s;
                    },
                    labelText: 'email',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    onChange: (s) {
                      pass = s;
                    },
                    labelText: 'password',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "REGISTER",
                    onTap: () async {
                      isLoad=true;
                      setState((){});
                      if(formKey.currentState!.validate()){
                      try {
                        await register(email, pass);
                        // showSnackBar(context,'success', Colors.green.shade900);
                        Navigator.pushNamed(context, ChatPage.id,arguments: email);
                      }on FirebaseAuthException catch (e) {
                        if(e.code == 'weak-password')
                          {
                            showSnackBar(context, 'weak-password', Colors.red.shade900);
                          }
                          else if(e.code == 'email-already-in-use')
                          {
                            showSnackBar(context, 'email-already-in-use',Colors.red.shade900);
                          }

                      }
                      }else{

                        showSnackBar(context, 'error', Colors.red);
                      }
                      setState((){});
                      isLoad=false;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'already have an account?',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Login')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String txt, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(txt),
          backgroundColor: color,
        ));
  }

  Future<void> register(String? email, String? pass) async {
     final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email!, password: pass!);
    print(credential.user!.displayName);
  }
}
