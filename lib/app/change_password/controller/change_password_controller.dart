import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassController extends GetxController {
  TextEditingController username = TextEditingController(text: "");
  TextEditingController passwordNew = TextEditingController(text: "");
  TextEditingController passwordOld = TextEditingController(text: "");
  TextEditingController rePasswordNew = TextEditingController(text: "");
}
