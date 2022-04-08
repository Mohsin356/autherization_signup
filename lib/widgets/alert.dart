import 'package:flutter/material.dart';
class AlertDial extends StatelessWidget {
  const AlertDial({Key? key,required this.alertTitle,required this.alertTitleClr,
    this.alertContext, required this.functionality,required this.btnText,required this.btnClr,
    required this.btnTextClr}) : super(key: key);
  final String alertTitle;
  final Color alertTitleClr;
  final String? alertContext;
  final VoidCallback functionality;
  final String btnText;
  final Color btnClr;
  final Color btnTextClr;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(alertTitle,style: TextStyle(color: alertTitleClr),),
      content: Text(alertContext!),
      actions: [
        Center(
          child:  ElevatedButton(onPressed: functionality, child: Text(btnText),
            style: ElevatedButton.styleFrom(
              primary: btnClr,onPrimary: btnTextClr,),
          ),
        ),

      ],
    );
  }
}
