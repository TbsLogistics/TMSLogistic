// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_driver_of_customer/model/id_driver_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_driver_of_customer/model/list_tracking_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status_details/model/list_driver_by_customer_model.dart';

class CustomerListDriverOfCustomerController extends GetxController {
  var dio = Dio();
  late Response response;
  RxList<ListDriverByCustomerModel> listDriver =
      <ListDriverByCustomerModel>[].obs;

  RxBool isLoad = false.obs;

  @override
  void onInit() {
    getListCustomer();
    super.onInit();
  }

  void getListCustomer() async {
    var token = await SharePerApi().getTokenNPT();
    const url = "${AppConstants.urlBaseNpt}/getdriverbycustomer";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    isLoad(false);
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        List<dynamic> data = response.data;
        listDriver.value =
            data.map((e) => ListDriverByCustomerModel.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      print(e.response!.statusMessage);
    } finally {
      isLoad(true);
    }
  }

  void postInforDriver({required int? idTaixe}) async {
    Response response;
    const url = "${AppConstants.urlBaseNpt}/LayThongTinPhieuVaoBangMaTaiXe";
    var mataixe = idDriverModel(maTaixe: idTaixe);
    var jsonData = mataixe.toJson();
    try {
      response = await dio.post(
        url,
        data: jsonData,
      );
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var data = response.data;

        if (data["status_code"] == 204) {
          Get.defaultDialog(
            title: "Thông báo",
            titleStyle: const TextStyle(
              color: Colors.red,
            ),
            content: Text(
              "${data["detail"]}",
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 16,
              ),
            ),
            confirm: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orangeAccent,
              ),
              width: 120,
              height: 45,
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Xác nhận",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        } else {
          Get.toNamed(
            Routes.CUSTOMER_DETAILS_INFO_DRIVER,
            arguments: ListTrackingModel.fromJson(data),
          );
        }
      }
    } on DioError catch (e) {
      print([e.response!.statusCode, e.response!.statusMessage]);
    }
  }
}
