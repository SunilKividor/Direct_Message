import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({super.key,required this.onTap,required this.text,});

  final void Function() onTap;
  final String text;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text( text,style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),),
        ),
      ),
    );
  }
}
