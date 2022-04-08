import 'package:flutter/material.dart';
import 'package:autherization/utils/assets.dart';

class CustomTextField extends StatelessWidget {

  const CustomTextField(
      {Key? key,
        required this.title,
        this.inputType,
        required this.controller,required this.visible,
        this.validTitle,


      })
      : super(key: key);
  final String title;
  final TextInputType? inputType;
  final TextEditingController controller;
  final bool visible;
  final String? validTitle;




  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: controller,
                keyboardType: inputType,
                obscureText: visible,
                validator: (validTitle){
                  switch (this.validTitle) {
                    case 'nameText':
                      {
                        if (validTitle!.isEmpty) {
                          return "Enter name";
                        } else if (!RegExp(r"^[\p{L} ,.'-]*$",
                            caseSensitive: false,
                            unicode: true,
                            dotAll: true)
                            .hasMatch(validTitle)) {
                          return "Enter valid Name";
                        }
                        return null;
                      }
                      // break;
                    case 'emailVal':
                      {
                        if (validTitle!.isEmpty) {
                          return "Fill out this field";
                        } else if (!RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)'
                            r'|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
                            r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(validTitle)) {
                          return 'Please enter correct email';
                        }
                        return null;
                      }

                    case "phNo": {
                      if (validTitle!.isEmpty) {
                        return "Phone number can not be left";
                      } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                          .hasMatch(validTitle)) {
                        return 'Incorrect phone number';
                      }
                      return null;
                    }

                    case "pass":{
                      if (validTitle!.isEmpty) {
                        return "Password can not be empty";
                      } else if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(validTitle)) {
                        return 'Must contain minimum 8 characters, at least one letter\n and one number';
                      }
                      return null;
                    }

                    case "pass2":
                      {
                        if (validTitle!.isEmpty) {
                          return "Password can not be empty";
                        }
                        else if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(validTitle)) {
                          return 'Must contain minimum 8 characters, at least one letter\n and one number';
                        }
                        return null;
                      }

                  }
                  return null;
                },
                style: const TextStyle(color: UiColors.textColor),
                cursorColor: UiColors.cursorClr,
                decoration: InputDecoration(
                  labelText: title,
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color:UiColors.textBorderClr,)
                  ),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color:UiColors.textBorderClr,)
                  ),
                  labelStyle: const TextStyle(color: UiColors.textColor,
                    fontSize: 18,),
                ),
              )),
        ],
      ),
    );
  }
}


