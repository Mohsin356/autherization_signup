import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({Key? key,required this.buttonText,
    required this.func, required this.btnAlign}) : super(key: key);
  final String buttonText;
  final VoidCallback func;
  final Alignment btnAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: btnAlign,
      child: ElevatedButton(onPressed: func,
        child:  Text(buttonText, style: const TextStyle(fontSize: 18,),),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,onPrimary: Colors.green),
      ),
    );
  }
}
