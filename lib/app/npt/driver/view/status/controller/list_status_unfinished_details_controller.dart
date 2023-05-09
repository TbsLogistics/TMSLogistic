import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/npt/customer/model/list_driver_by_customer_model.dart';
import 'package:tbs_logistics_tms/app/npt/driver/model/status_driver_model.dart';
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class ListStatusUnfinishedDetailsController extends GetxController {
  var dio = Dio();

  Rx<StatusDriverModel> getStatusDriver = StatusDriverModel().obs;

  RxBool isStatusDriver = true.obs;
  RxBool showForm = true.obs;

  @override
  void onInit() {
    var statusDriver = Get.arguments as StatusDriverModel;
    getStatusDriver.value = statusDriver;
    print(getStatusDriver.value);
    super.onInit();
  }

  void showFormStatus() {
    showForm.value = !showForm.value;
    update();
  }

  var selectedTaixe = "";

  Future<List<ListDriverByCustomerModel>> getData(query) async {
    Response response;
    var token = await SharePerApi().getTokenNPT();
    var idHK = await SharePerApi().getIdKHforTX();
    print(idHK);

    var url =
        '${AppConstants.urlBaseNpt}/listdriverbycustomerID?maKhachHang=$idHK';
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: {"query": query},
      );

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var customer = response.data;
        if (customer != null) {
          return ListDriverByCustomerModel.fromJsonList(customer);
        }
        return [];
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  void shareDriver({required int maTaiXe, required int maPhieuVao}) async {
    Response response;

    var url =
        "${AppConstants.urlBaseNpt}/share-entry-vote-in?maTaiXe=$maTaiXe&maPhieuVao=$maPhieuVao";
    try {
      response = await dio.post(url);
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        Get.back();
        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Color.fromARGB(199, 230, 16, 16),
            ),
          ),
          messageText: const Text(
            "Chia sẻ phiếu thành công !",
            style: TextStyle(
              color: Color.fromARGB(197, 8, 197, 43),
            ),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
