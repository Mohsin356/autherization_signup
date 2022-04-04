import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  const CustomTextField(
      {Key? key,
        required this.title,
        this.inputType,
        required this.controller,required this.visible,
        this.validator
      })
      : super(key: key);
  final String title;
  final TextInputType? inputType;
  final TextEditingController controller;
  final bool visible;
  final String? Function(String?)? validator;


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
                validator: validator,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: title,
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color:Colors.white,)
                  ),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color:Colors.white,)
                  ),
                  labelStyle: const TextStyle(color: Colors.white,
                    fontSize: 18,),
                ),
              )),
        ],
      ),
    );
  }
}


