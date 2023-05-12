import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class LetterManagerDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> tabCreate = <Tab>[
    const Tab(text: 'Xem'),
    const Tab(text: 'Duyệt'),
  ];

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: tabCreate.length);
    super.onInit();
  }
}
