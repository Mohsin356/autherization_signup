import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:autherization/screens/login.dart';
import 'package:autherization/widgets/CommonButtons.dart';
import 'package:autherization/widgets/TextFields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:autherization/widgets/alert.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var email = TextEditingController();
  var nameController = TextEditingController();
  var pass = TextEditingController();
  var pass2 = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 40),
                child: const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white),
                  ),
                ),
              ),
              // buildNameField(),
              const SizedBox(
                height: 10,
              ),
              Column(
                  children: [
                    CustomTextField(
                        title: 'Name',
                        inputType: TextInputType.name,
                        visible: false,
                        controller: nameController,

                    ),

                    CustomTextField(
                      title: 'Email',
                      inputType: TextInputType.emailAddress,
                      visible: false,
                      controller: email,

                    ),

                    // buildEmailField(),
                    CustomTextField(
                      title: 'Phone Number',
                      inputType: TextInputType.phone,
                      visible: false,
                      controller: phoneController,

                    ),
                    CustomTextField(
                      title: 'Password',
                      visible: true,
                      controller: pass,

                    ),
                    CustomTextField(
                      title: 'Confirm Password',
                      visible: true,
                      controller: pass2,

                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonButton(buttonText: "Sign up",btnAlign: Alignment.center,func: ()
                        async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance.createUserWithEmailAndPassword(
                            email: email.text.trim(),
                            password: pass.text.trim(),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDial(alertTitle:'Successfully Registered',
                              alertTitleClr: Colors.green,
                              alertContext: 'You can Login Now',
                              functionality: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Welcome()),
                                );
                              },
                              btnClr: Colors.green,
                              btnTextClr: Colors.white,
                              btnText: 'Ok',);
                          },
                        );

                      },),

                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RichText(
                          text: TextSpan(text: 'Back to Login',
                              style: const TextStyle(color: Colors.white, fontSize: 18),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Welcome()),
                                  );
                                }
                          )
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
        ],
          ),
      ),
      ),
    );
  }
}
