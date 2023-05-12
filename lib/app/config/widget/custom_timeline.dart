import 'package:flutter/material.dart';

class CustomTimeLines extends StatelessWidget {
  const CustomTimeLines({
    Key? key,
    required this.contentLeft,
    required this.contentRight,
    required this.image,
    required this.height,
    required this.colorLine,
  }) : super(key: key);

  final Widget contentLeft;
  final Widget contentRight;
  final ImageProvider<Object> image;
  final double height;
  final Color colorLine;
  // final double width;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: height,
          width: size.width,
          child: Row(
            children: [
              Expanded(
                child: Container(child: contentLeft),
              ),
              Container(
                width: 1,
                color: colorLine,
              ),
              Expanded(
                child: Container(child: contentRight),
              ),
            ],
          ),
        ),
        Positioned(
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
