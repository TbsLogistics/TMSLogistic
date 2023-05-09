// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/model/tms_orders_model.dart';
import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class TmsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var dio = Dio();
  late Response response;

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Lệnh chờ'),
    const Tab(text: 'Lệnh thực hiện'),
    const Tab(text: 'Lệnh hoàn thành'),
  ];
  late TabController controller;

  @override
  void onInit() {
    controller = TabController(vsync: this, length: myTabs.length);

    super.onInit();
  }

  Future<List<TmsOrdersModel>> getData(
      {required String id, required String status}) async {
    var token = await SharePerApi().getTokenTMS();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/GetDataTransport?driver=$id&isCompleted=$status";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    response = await dio.get(
      url,
      options: Options(
        headers: headers,
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;

      return data.map((e) => TmsOrdersModel.fromJson(e)).toList();
    }
    return response.data;
  }
}
