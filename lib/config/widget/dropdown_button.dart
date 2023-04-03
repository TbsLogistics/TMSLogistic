// ignore_for_file: file_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tbs_logistics_tms/config/core/data/color.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton(
      {super.key,
      required this.items,
      required this.text,
      required this.onChanged,
      required this.onSaved});
  final List<DropdownMenuItem<String>> items;
  final String text;
  final Function(String?) onChanged;
  final Function(String?) onSaved;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              Text(
                widget.text,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              width: 1,
              color: CustomColor.borderColor,
            ),
          ),
          height: 60,
          width: size.width - 10,
          margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: DropdownButtonFormField2(
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              focusColor: Colors.orangeAccent.withOpacity(0.4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
            ),
            isExpanded: true,
            hint: Text(
              'Chọn ${widget.text}',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
            items: widget.items,
            validator: (value) {
              if (value == null) {
                return 'Chọn ${widget.text}';
              }
              return null;
            },
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
          ),
        )
      ],
    );
  }
}
