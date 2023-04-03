import 'package:flutter/material.dart';

class ButtonStatus extends StatelessWidget {
  const ButtonStatus({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orangeAccent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: size.width * 0.25,
      width: size.width * 0.3,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.orangeAccent,
          ),
        ),
      ),
    );
  }
}
