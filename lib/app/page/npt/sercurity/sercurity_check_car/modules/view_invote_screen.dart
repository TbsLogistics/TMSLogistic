import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewInvoteScreen extends StatefulWidget {
  const ViewInvoteScreen({super.key});

  @override
  State<ViewInvoteScreen> createState() => _ViewInvoteScreenState();
}

class _ViewInvoteScreenState extends State<ViewInvoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(),
    );
  }
}
