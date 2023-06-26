// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager/model/day_off_letter_manager_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager/model/letter_manager_approve_all_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager/model/letter_manager_approve_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself/model/department_model.dart';
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';

class LetterManagerController extends GetxController {
  late Response response;
  var dio = Dio();

  List<dynamic> selectedDepartments = [];
  var selectedDepartmentsValue = "".obs;
  var selectedDepartmentsId = "".obs;
  RxList<int> listRegid = <int>[].obs;
  List<DepartmentsModel> departments = [
    DepartmentsModel(id: 1, name: "Chờ duyệt"),
    DepartmentsModel(id: 2, name: "Đã duyệt"),
    DepartmentsModel(id: 3, name: "Từ chối"),
  ];

  RxList<DayOffLettersManagerModel> listDayOffManager =
      <DayOffLettersManagerModel>[].obs;
  RxBool isLoadDayOffManganer = true.obs;

  @override
  void onInit() {
    getDayOffLetterManager(needAppr: 1, astatus: "");

    super.onInit();
  }

  void getDayOffLetterManager(
      {required int needAppr, required String astatus}) async {
    // var tokens = AppConstants.tokens;
    var tokens = await SharePerApi().getTokenHRM();

    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    isLoadDayOffManganer(false);
    var url =
        "${AppConstants.urlBaseHrm}/day-off-letters?needAppr=$needAppr&astatus=$astatus";

    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data["rData"];
        listRegid.value = [];
        listDayOffManager.value =
            data.map((e) => DayOffLettersManagerModel.fromJson(e)).toList();
        for (var i = 0; i < listDayOffManager.length; i++) {
          var items = listDayOffManager[i].regID;
          if (listDayOffManager[i].aStatus == 1) {
            listRegid.add(items!);
          }
        }
      }
    } on DioError catch (e) {
      // print([e.response!.statusCode, e.response!.statusMessage]);
      if (e.response!.statusCode == 400) {
        getSnack(messageText: "Lỗi mạng ! Vui lòng thử lại trong giây lát !");
      } else if (e.response!.statusCode == 500) {
        getSnack(messageText: "Lỗi mạng ! Vui lòng thử lại trong giây lát !");
      }
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoadDayOffManganer(true);
      });
    }
  }

  void showMultiSelect() async {
    await showDialog(
      context: Get.context!,
      builder: (ctx) {
        return MultiSelectDialog(
          height: 200,
          listType: MultiSelectListType.LIST,
          initialValue: selectedDepartments,
          items: departments
              .map((player) =>
                  MultiSelectItem<DepartmentsModel>(player, player.name!))
              .toList(),
          title: const Text("Chọn loại đơn"),
          selectedColor: Colors.blue,
          searchable: true,
          onConfirm: (results) {
            selectedDepartments = results;
            selectedDepartmentsValue.value = "";
            // ignore: avoid_function_literals_in_foreach_calls
            selectedDepartments.forEach(
              (element) {
                selectedDepartmentsValue.value =
                    selectedDepartmentsValue.value + element.name + ",";
                selectedDepartmentsId.value =
                    selectedDepartmentsId.value + element.id.toString() + ",";
              },
            );
            getDayOffLetterManager(
                needAppr: 1, astatus: selectedDepartmentsId.value);
          },
        );
      },
    );
  }

  void postApprove({
    required int regID,
    required String comment,
    required int state,
  }) async {
    Response response;
    var tokens = await SharePerApi().getTokenHRM();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    var approve = LetterManagerApproveModel(
      regid: regID,
      comment: comment,
      state: state,
    );
    var jsonData = approve.toJson();
    const url = "${AppConstants.urlBaseHrm}/approve";
    try {
      response = await dio.post(url,
          options: Options(headers: headers), data: jsonData);
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var data = response.data;
        // Get.to(() => const LetterManagerDenyScreen());
        getDayOffLetterManager(astatus: "", needAppr: 1);

        Get.snackbar(
          "Thông báo",
          "${data["rMsg"]} !",
          titleText: const Text(
            "Thông báo",
            style: TextStyle(color: Colors.red),
          ),
          messageText: Text(
            "${data["rMsg"]} !",
            style: const TextStyle(color: Colors.green),
          ),
        );
        update();
      }
    } catch (e) {
      rethrow;
    }
  }

  void postApproveAll({
    required List<int> regID,
    required String comment,
    required int state,
  }) async {
    Response response;
    var tokens = await SharePerApi().getTokenHRM();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    var approve = LetterManagerApproveAllModel(
      regid: regID,
      comment: comment,
      state: state,
    );
    var jsonData = approve.toJson();
    const url = "${AppConstants.urlBaseHrm}/approve";
    try {
      response = await dio.post(url,
          options: Options(headers: headers), data: jsonData);
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var data = response.data;
        // Get.to(() => const LetterManagerDenyScreen());
        getDayOffLetterManager(astatus: "", needAppr: 1);

        Get.snackbar(
          "Thông báo",
          "${data["rMsg"]} !",
          titleText: const Text(
            "Thông báo",
            style: TextStyle(color: Colors.red),
          ),
          messageText: Text(
            "${data["rMsg"]} !",
            style: const TextStyle(color: Colors.green),
          ),
        );
        update();
      }
    } catch (e) {
      rethrow;
    }
  }

  void getSnack({required String messageText}) {
    Get.snackbar(
      "",
      "",
      titleText: const Text(
        "Thông báo",
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        messageText,
        style: const TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }
}
