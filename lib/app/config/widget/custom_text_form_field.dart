import 'package:flutter/material.dart';

class CustomFormFiels extends StatelessWidget {
  const CustomFormFiels({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.validator,
    required this.color,
    required this.keyboardType,
  });
  final String title;
  final TextEditingController controller;
  final String? hintText;
  final IconData icon;
  final String Function(String?)? validator;
  final Color color;
  final TextInputType keyboardType;
  // final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 20,
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              // color: Color(0xFFF3BD60),
              color: Theme.of(context).primaryColorLight,
            ),
            // color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.only(top: 10, left: 10),
          height: 60,
          width: size.width - 10,
          margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: TextFormField(
            keyboardType: keyboardType,
            textCapitalization: TextCapitalization.characters,
            validator: validator,
            controller: controller,
            style: const TextStyle(
              color: Colors.orangeAccent,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Theme.of(context).primaryColorLight,
              ),
              border: InputBorder.none,
              icon: Icon(
                icon,
                size: 26,
              ),
              isDense: true,
            ),
          ),
        )
      ],
    );
  }
}
