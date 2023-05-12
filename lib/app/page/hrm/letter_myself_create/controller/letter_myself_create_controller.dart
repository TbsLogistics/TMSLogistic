import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LetterMyselfCreateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isload = false.obs;

  late TabController tabController;
  TextEditingController reasonController = TextEditingController();
  RxBool isHide = false.obs;
  @override
  void onInit() {
    // await refreshSearch();
    tabController = TabController(vsync: this, length: tabCreate.length);
    super.onInit();
  }

  final List<Tab> tabCreate = <Tab>[
    const Tab(text: 'Tạo'),
    const Tab(text: 'Duyệt'),
  ];
}
