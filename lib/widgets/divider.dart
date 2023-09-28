import 'package:flutter/material.dart';

class Divide extends StatelessWidget {
  const Divide({super.key});

  @override
  Widget build(BuildContext context) {
    const divide =  Expanded(child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Divider(
          color: Colors.grey,
        ),
    ));
    return const Row(
     children: [
     divide,
      Text('OR',
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 16
      ),),
      divide,
     ],
    );
  }
}