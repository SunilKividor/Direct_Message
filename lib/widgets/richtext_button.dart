import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextButton extends StatelessWidget {
  const RichTextButton({
    super.key,
    required this.onTap,
    required this.firstText,
    required this.secondText,
  });

  final void Function() onTap;
  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: RichText(
        text: TextSpan(
            text: firstText,
            style: TextStyle(
              color: Colors.grey[400],
            ),
            children: [
              TextSpan(
                text: secondText,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 188, 217, 240),
                ),
                recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
            ]),
      ),
    );
  }
}
