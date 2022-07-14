import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey=GlobalKey();

  String? email;

  String? pass;

  bool isLoad= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoad,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 150,
                  ),
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
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    onChange: (s){
                      email=s;
                    },
                    labelText: 'email',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    onChange: (s){
                     pass=s;
                    },
                    labelText: 'password',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onTap: ()async{
                      setState((){
                         isLoad=true;
                      });
                      if(formKey.currentState!.validate()) {
                      try{
                        var auth = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: email!, password: pass!);
                        print(auth.user!.email);
                      }on FirebaseAuthException catch(e){
                        if(e.code == 'user-not-found'){
                          showSnackBar(context, 'user-not-found', Colors.red);
                        }else if(e.code =='wrong-password')
                          {
                            showSnackBar(context, 'wrong-password', Colors.red);

                          }
                      }
                      }else{
                        showSnackBar(context, 'error', Colors.red.shade900);
                      }
                      setState((){
                        isLoad =false;
                      });
                    },
                    text: "LOGIN",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have an account',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: Text('Register')),
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
}
void showSnackBar(BuildContext context, String txt, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(txt),
        backgroundColor: color,
      ));}