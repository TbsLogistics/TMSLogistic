import 'package:flutter/material.dart';

class ButtonFormSubmit extends StatelessWidget {
  const ButtonFormSubmit(
      {super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.width * 0.025),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.8),
        border:
            Border.all(width: 1, color: Colors.orangeAccent.withOpacity(0.4)),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      width: size.width - 10,
      height: 60,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
