import 'package:flutter/material.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';

class CustomListTitle extends StatefulWidget {
  const CustomListTitle({
    super.key,
    // ignore: non_constant_identifier_names
    required this.Stt,
    required this.nameDriver,
    required this.numberPhone,
    required this.customer,
    required this.status,
  });
  // ignore: non_constant_identifier_names
  final String Stt;
  final String nameDriver;
  final String numberPhone;
  final String customer;
  final bool status;

  @override
  State<CustomListTitle> createState() => _CustomListTitleState();
}

class _CustomListTitleState extends State<CustomListTitle> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      shadowColor: Colors.black,
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: CustomColor.backgroundAppbar)
          //set border radius more than 50% of height and width to make circle
          ),
      child: Container(
        width: size.width,
        height: 65,
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 45,
                    child: Center(
                      child: Text(widget.Stt),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.nameDriver,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.numberPhone,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  widget.customer,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: widget.status == false
                    ? const Icon(
                        Icons.adjust_sharp,
                        color: Colors.redAccent,
                      )
                    : const Icon(
                        Icons.adjust_sharp,
                        color: Colors.green,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
