import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  const TextCustom({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, color: Colors.black),
    );
  }
}

class TextCustomComment extends StatelessWidget {
  const TextCustomComment({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, color: Colors.orangeAccent),
    );
  }
}
