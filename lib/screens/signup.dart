import 'package:autherization/models/userModel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:autherization/screens/login.dart';
import 'package:autherization/widgets/CommonButtons.dart';
import 'package:autherization/widgets/TextFields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:autherization/widgets/alert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var email = TextEditingController();
  var nameController = TextEditingController();
  var password1 = TextEditingController();
  var password2 = TextEditingController();
  var phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        title: 'Name',
                        inputType: TextInputType.name,
                        visible: false,
                        controller: nameController,
                        validator: (nameText) {
                          if (nameText!.isEmpty) {
                            return "Enter name";
                          } else if (!RegExp(r"^[\p{L} ,.'-]*$",
                                  caseSensitive: false,
                                  unicode: true,
                                  dotAll: true)
                              .hasMatch(nameText)) {
                            return "Enter valid Name";
                          }
                          return null;
                        }),

                    CustomTextField(
                      title: 'Email',
                      inputType: TextInputType.emailAddress,
                      visible: false,
                      controller: email,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Fill out this field";
                        } else if (!RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)'
                                r'|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
                                r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(val)) {
                          return 'Please enter correct email';
                        }
                        return null;
                      },
                    ),

                    // buildEmailField(),
                    CustomTextField(
                      title: 'Phone Number',
                      inputType: TextInputType.phone,
                      visible: false,
                      controller: phoneController,
                      validator: (phNo) {
                        if (phNo!.isEmpty) {
                          return "Phone number can not be left";
                        } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                            .hasMatch(phNo)) {
                          return 'Incorrect phone number';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      title: 'Password',
                      visible: true,
                      controller: password1,
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return "Password can not be empty";
                        } else if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(pass)) {
                          return 'Must contain minimum 8 characters, at least one letter\n and one number';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      title: 'Confirm Password',
                      visible: true,
                      controller: password2,
                      validator: (pass2) {
                        if (pass2!.isEmpty) {
                          return "Password can not be empty";
                        } else if (password1.text != pass2) {
                          return "Passwords don't match";
                        } else if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(pass2)) {
                          return 'Must contain minimum 8 characters, at least one letter\n and one number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                      buttonText: "Sign up",
                      btnAlign: Alignment.center,
                      func: () {
                        signUp(email.text.trim(), password1.text.trim());
                        alertDialouge();
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RichText(
                          text: TextSpan(
                              text: 'Back to Login',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Welcome()),
                                  );
                                })),
                    ),
                    const SizedBox(
                      height: 10,
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => postDetailsToFirestore())
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  void postDetailsToFirestore() async {
    //calling fireStore
    //calling user model
    //sending values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel usermodel = UserModel();

    usermodel.userEmail = user!.email;
    usermodel.uid = user.uid;
    usermodel.userName = nameController.text.trim();
    usermodel.userPhone = phoneController.text.trim();

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(usermodel.toMap());
  }
  void alertDialouge(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDial(
          alertTitle: 'Successfully Registered',
          alertTitleClr: Colors.green,
          alertContext: 'You can Login Now',
          functionality: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Welcome()),
            );
          },
          btnClr: Colors.green,
          btnTextClr: Colors.white,
          btnText: 'Ok',
        );
      },
    );
  }
}
