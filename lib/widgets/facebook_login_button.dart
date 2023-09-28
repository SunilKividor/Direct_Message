import 'package:flutter/material.dart';

class FaceBookLoginButton extends StatefulWidget {
  const FaceBookLoginButton({super.key,required this.onTap});

  final void Function() onTap;

  @override
  State<FaceBookLoginButton> createState() => _FaceBookLoginButtonState();
}

class _FaceBookLoginButtonState extends State<FaceBookLoginButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: const Color.fromARGB(213, 47, 149, 232),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/facebook.png',height: 30,),
              const SizedBox(
                width: 4,
              ),
              const Text(
                'Continue with facbook',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
