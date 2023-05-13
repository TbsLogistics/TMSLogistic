// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/tms/pending_details/model/list_data_for_place_model.dart';

class CancelPendingController extends GetxController {
  var handlingId = 0.obs;
  RxString idList = "".obs;
  var firstIndex = 0.obs;
  var secondsIndex = 0.obs;

  RxList<ListDataForPlaceModel> listDataForReceiveEmpty =
      <ListDataForPlaceModel>[].obs;
  RxList<ListDataForPlaceModel> listDataForReceive =
      <ListDataForPlaceModel>[].obs;
  RxList<ListDataForPlaceModel> listDataForGive = <ListDataForPlaceModel>[].obs;
  RxList<ListDataForPlaceModel> listDataForGiveEmpty =
      <ListDataForPlaceModel>[].obs;

  TextEditingController cancelController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    formKey;
    var idHanlding = Get.arguments[0];
    var id = Get.arguments[1];
    var first = Get.arguments[2];
    var seconds = Get.arguments[3];
    var dataForm = Get.arguments[4];

    var forReceiveEmpty = dataForm[0];
    var forReceive = dataForm[1];
    var forGive = dataForm[2];
    var forGiveEmpty = dataForm[3];
    listDataForReceiveEmpty.value = forReceiveEmpty;
    listDataForReceive.value = forReceive;
    listDataForGive.value = forGive;
    listDataForGiveEmpty.value = forGiveEmpty;
    handlingId.value = idHanlding;
    idList.value = id;
    super.onInit();
  }

  void postCancel() async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/CancelHandling?handlingId=${handlingId.value}";
    try {
      response = await dio.post(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = response.data;

        Get.back(result: true);

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
        switch (idList.value) {
          case "lr":
            switch (listDataForReceiveEmpty[firstIndex.value]
                .getData![secondsIndex.value]
                .maTrangThai) {
              case 17:
                for (var i = 0;
                    i <
                        listDataForReceiveEmpty[firstIndex.value]
                            .getData!
                            .length;
                    i++) {
                  listDataForReceiveEmpty[firstIndex.value]
                      .getData![i]
                      .maTrangThai = 37;
                }
                break;

              default:
            }
            break;
          case "lh":
            switch (listDataForReceive[firstIndex.value]
                .getData![secondsIndex.value]
                .maTrangThai) {
              case 37:
                for (var i = 0;
                    i < listDataForReceive[firstIndex.value].getData!.length;
                    i++) {
                  listDataForReceive[firstIndex.value].getData![i].maTrangThai =
                      18;
                }
                break;
              case 40:
                for (var i = 0;
                    i < listDataForReceive[firstIndex.value].getData!.length;
                    i++) {
                  listDataForReceive[firstIndex.value].getData![i].maTrangThai =
                      18;
                }
                break;

              default:
            }
            break;
          case "th":
            switch (listDataForGive[firstIndex.value]
                .getData![secondsIndex.value]
                .maTrangThai) {
              case 18:
                for (var i = 0;
                    i < listDataForGive[firstIndex.value].getData!.length;
                    i++) {
                  listDataForGive[firstIndex.value].getData![i].maTrangThai =
                      36;
                }
                break;
              default:
            }
            break;
          case "tr":
            switch (listDataForGiveEmpty[firstIndex.value]
                .getData![secondsIndex.value]
                .maTrangThai) {
              case 18:
                listDataForGiveEmpty[firstIndex.value]
                    .getData![secondsIndex.value]
                    .maTrangThai = 36;
                break;
              default:
            }
            break;
        }
      }
    } on DioError catch (e) {
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
}
