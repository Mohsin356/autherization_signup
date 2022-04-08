import 'package:autherization/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:autherization/screens/login.dart';
import 'package:autherization/widgets/CommonButtons.dart';
import 'package:autherization/widgets/TextFields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:autherization/widgets/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autherization/utils/assets.dart';

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
      backgroundColor: UiColors.appBg,
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
                        color: UiColors.textColor),
                  ),
                ),
              ),
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
                      validTitle: 'nameText',
                    ),

                    CustomTextField(
                      title: 'Email',
                      inputType: TextInputType.emailAddress,
                      visible: false,
                      controller: email,
                      validTitle: "emailVal",
                    ),
                    CustomTextField(
                      title: 'Phone Number',
                      inputType: TextInputType.phone,
                      visible: false,
                      controller: phoneController,
                      validTitle: "phNo",
                    ),
                    CustomTextField(
                      title: 'Password',
                      visible: true,
                      controller: password1,
                      validTitle: "pass",
                    ),
                    CustomTextField(
                      title: 'Confirm Password',
                      visible: true,
                      controller: password2,
                      validTitle: "pass2",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                      buttonText: "Sign up",
                      btnAlign: Alignment.center,
                      func: () {
                        signUp(email.text.trim(), password1.text.trim());
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                       child:
                           GestureDetector(
                             onTap : () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) => const Welcome()),);
                             },
                             child: const Text('Back to Login',style: TextStyle(color: UiColors.textColor, fontSize: 18,),),
                           ),
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
          .then((value) {
          postDetailsToFirestore();
          alertDialogue();});
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
  void alertDialogue(){
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
