import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/model/list_driver_by_customer_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/model/status_driver_model.dart';

class StatusDriverController extends GetxController {
  var dio = Dio();
  Rx<StatusDriverModel> getStatusDriver = StatusDriverModel().obs;
  RxBool showForm = false.obs;

  RxBool isStatusDriver = false.obs;

  var selectedTaixe = "";

  @override
  void onInit() {
    getStatus();
    super.onInit();
  }

  void showFormStatus() {
    showForm.value = !showForm.value;
    update();
  }

  void getStatus() async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenNPT();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    isStatusDriver(false);

    const url = "${AppConstants.urlBaseNpt}/LayThongTinPhieuVaoHienTaiCuaTaiXe";
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var data = StatusDriverModel.fromJson(response.data);

        getStatusDriver.value = data;
      }
    } catch (e) {
      rethrow;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isStatusDriver(true);
      });
    }
  }

  Future<List<ListDriverByCustomerModel>> getData(query) async {
    Response response;
    var token = await SharePerApi().getTokenNPT();
    var idHK = await SharePerApi().getIdKHforTX();

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
              color: Color.fromARGB(15, 218, 8, 8),
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

  @override
  void onClose() {
    Get.deleteAll();
    super.onClose();
  }
}
