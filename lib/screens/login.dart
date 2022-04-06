import 'dart:math';

import 'package:autherization/screens/feed.dart';
import 'package:autherization/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:autherization/widgets/CommonButtons.dart';
import 'package:autherization/widgets/TextFields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.green,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60,),
              const Center(
                child: Text("ChatStore",textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 60,
                      color: Colors.white),),
              ),
              const SizedBox(height: 60,),
              Form(
                key: _formKey,
                child:Column(
                  children:[
                  CustomTextField(
                    title: 'Email',
                    inputType: TextInputType.emailAddress,
                    visible: false,
                    controller: emailController,
                    validator: (val){
                      if (val!.isEmpty){
                        return "Fill out this field";}

                      else if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)'
                      r'|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
                      r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(val
                      )) {
                        return 'Please enter correct email';
                      }
                      return null;

                    },


                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // buildEmailField(),
                  CustomTextField(
                    title: 'Password',
                    visible: true,
                    controller: passController,
                    validator: (pass){
                      if(pass!.isEmpty){
                        return "Password can not be empty";
                      }
                      else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(pass)) {
                        return 'Must contain minimum 8 characters, at least one letter\n and one number';
                      }
                      return null;

                    },
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.only(right:20),
                    alignment: Alignment.topRight,
                    child: RichText(
                      text:  TextSpan(text: "Forgot Password?",
                          style: const TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {}),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  CommonButton(buttonText: "Sign in",func: (){
                    signIn(emailController.text.trim(), passController.text.trim());
                  },btnAlign: Alignment.center,),

                  const SizedBox(height: 10,),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(text: ' Sign up',
                                style: const TextStyle(color: Colors.white, fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => const Signup()));
                                  }
                            )
                          ]
                      ),
                    ),
                  ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
void signIn(String loginEmail,String loginPass)async{
if(_formKey.currentState!.validate()){
  await _auth
      .signInWithEmailAndPassword(email: loginEmail, password: loginPass)
      .then((uid) =>{
        Fluttertoast.showToast(msg: "Login Successful"),
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Feed(),))
  }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
  });

}
}
}
