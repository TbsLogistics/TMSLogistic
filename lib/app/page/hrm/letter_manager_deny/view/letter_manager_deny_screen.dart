import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager_deny/controller/letter_manager_deny_controller.dart';

class LetterManagerDenyScreen extends GetView<LetterManagerDenyController> {
  const LetterManagerDenyScreen({super.key});
  final String routes = "/ACCESS_LEAVE_SCREEN";

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Không có quyền !",
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
