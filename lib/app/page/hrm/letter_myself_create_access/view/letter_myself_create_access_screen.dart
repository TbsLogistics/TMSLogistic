// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_create_access/controller/letter_myself_create_access_controller.dart';

// ignore: must_be_immutable
class LetterMyselfCreateAccessScreen
    extends GetView<LetterMyselfCreateAccessController> {
  LetterMyselfCreateAccessScreen({super.key});

  @override
  var controller = Get.put(LetterMyselfCreateAccessController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Không có dữ liệu !",
            style: TextStyle(
              color: Colors.green,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
