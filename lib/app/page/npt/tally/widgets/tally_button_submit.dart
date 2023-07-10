import 'package:flutter/material.dart';

class TallyButtonFormSubmit extends StatelessWidget {
  const TallyButtonFormSubmit(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.width});
  final VoidCallback onPressed;
  final String text;
  final double width;

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
      height: 45,
      width: width,
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
