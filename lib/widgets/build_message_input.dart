
import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key,required this.controller,required this.sendMessage});

  final TextEditingController controller;
  final void Function() sendMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12,right: 12,top: 6,bottom: 1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
        decoration: BoxDecoration(
          color: const Color.fromARGB(52, 158, 158, 158),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                  
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Message...',
                  hintStyle: TextStyle(
                    fontSize: 18
                  ),
                border: InputBorder.none
                ),
              ),
            )) ,
            TextButton(onPressed: sendMessage, child: const Text('Send',style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 83, 46, 204)
            ),))
          
          ],
        ),
      ),
    );
  }
}