// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/start_detail_tms/model/list_data_for_place_model.dart';
import 'package:tbs_logistics_tms/app/surcharges/model/list_subfee_model.dart';
import 'package:tbs_logistics_tms/app/surcharges/model/sur_changes_model.dart';
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';

import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class SurChangesController extends GetxController {
  var listSurchanges = <SurChangesModel>[].obs;

  var itemList = <String>[].obs;
  var listSur = <SurChangesModel>[].obs;
  var selectedValue = 0.obs;
  var subFee = "".obs;
  var priceText = "".obs;
  var ghichu = "".obs;

  var maChuyen = "".obs;

  Rx<ListDataForPlaceModel> listDataForPlace = ListDataForPlaceModel().obs;
  var idPlaced = 0.obs;

  final formKey = GlobalKey<FormState>();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void onInit() {
    var dataForPlace = Get.arguments[0] as ListDataForPlaceModel;
    var idChuyen = Get.arguments[1];
    var maPlace = Get.arguments[2];
    maChuyen.value = idChuyen;
    listDataForPlace.value = dataForPlace;
    idPlaced.value = maPlace;
    formKey;
    super.onInit();
  }

  addItem(String item) {
    itemList.add(item);
  }

  addSurTimes({
    required int price,
    required int sfId,
    required String sfName,
    required String note,
  }) {
    listSur.add(
      SurChangesModel(
        idTcommand: 0,
        transportId: "",
        placeId: idPlaced.value,
        sfId: sfId,
        sfName: sfName,
        finalPrice: price,
        note: note,
      ),
    );
  }

  void postData(List<SurChangesModel> listSur) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url =
        "${AppConstants.urlBase}/api/Mobile/CreateSFeeByTCommand?maChuyen=${maChuyen.value}";
    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonEncode(listSur),
      );

      if (response.statusCode == 200) {
        // Handle success
        var data = response.data;

        Get.back();
        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: Text(
            "${data["message"]}",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
      } else {
        // Handle error
      }
    } on DioError catch (e) {
      // Handle exception

      if (e.response!.statusCode == 400) {
        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: Text(
            "${e.response!.data["message"]}",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
      }
    }
  }

  void listSubFeeIncurred() async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var url =
        "${AppConstants.urlBase}/api/Mobile/GetListSubfeeIncurred?handlingId=335";
  }

  Future<List<ListSubFeeModel>> getSubFee(query) async {
    var tokens = await SharePerApi().getToken();
    Response response;
    var dio = Dio();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url = "${AppConstants.urlBase}/api/Mobile/GetListSubFeeSelect";

    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: {"query": query},
      );
      if (response.statusCode == 200) {
        var data = response.data;
        if (data != null) {
          return ListSubFeeModel.fromJsonList(data);
        }
        return [];
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
