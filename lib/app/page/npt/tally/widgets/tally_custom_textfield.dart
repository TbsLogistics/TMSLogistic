import 'package:flutter/material.dart';

class TallyCustomFormFiels extends StatelessWidget {
  const TallyCustomFormFiels({
    super.key,
    required this.controller,
    required this.hintText,
    this.iconRight,
    this.validator,
    required this.color,
    this.keyboardType,
    this.onPressedIcon,
    this.onChanged,
    required this.title,
    this.titleRight,
    this.onFieldSubmitted,
    this.textInputAction,
    this.focusNode,
  });

  final TextEditingController controller;
  final String? hintText;
  final IconData? iconRight;
  final String Function(String?)? validator;
  final Color color;
  final TextInputType? keyboardType;
  final VoidCallback? onPressedIcon;
  final Function(String)? onChanged;
  final String title;
  final Widget? titleRight;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: titleRight,
            ),
          ],
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
          height: 50,
          // width: size.width * 0.8,
          margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: TextFormField(
            focusNode: focusNode,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            textCapitalization: TextCapitalization.characters,
            validator: validator,
            controller: controller,
            style: const TextStyle(
              color: Colors.orangeAccent,
            ),
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 15, left: 20),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Theme.of(context).primaryColorLight,
              ),
              suffixIcon: IconButton(
                onPressed: onPressedIcon,
                icon: Icon(
                  iconRight,
                  size: 26,
                  color: Colors.orangeAccent,
                ),
              ),
              focusColor: Colors.orangeAccent,
              fillColor: Colors.orangeAccent,
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        )
      ],
    );
  }
}
