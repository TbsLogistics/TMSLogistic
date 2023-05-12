import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself/model/day_off_letter_myself_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself/model/department_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself/model/user_hrm_model.dart';

class LetterMyselfController extends GetxController {
  List<dynamic> selectedDepartments = [];
  var selectedDepartmentsValue = "".obs;
  var selectedDepartmentsId = "".obs;

  List<DepartmentsModel> departments = [
    DepartmentsModel(id: 0, name: "Đơn mới"),
    DepartmentsModel(id: 1, name: "Chờ duyệt"),
    DepartmentsModel(id: 2, name: "Đã duyệt"),
    DepartmentsModel(id: 3, name: "Từ chối"),
  ];
  RxList<DayOffLettersSingleModel> listDayOff =
      <DayOffLettersSingleModel>[].obs;
  Rx<UserHrmModel> userInfo = UserHrmModel().obs;

  RxBool isLoadDayOff = false.obs;
  RxBool isLoadUser = false.obs;

  @override
  void onInit() {
    getDayOffLetterSingler(astatus: "", needAppr: 0);
    getInfo();

    super.onInit();
  }

  void getInfo() async {
    var tokens = await SharePerApi().getTokenHRM();
    var dio = Dio();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    const url = "${AppConstants.urlBaseHrm}/getEmpInfo";
    isLoadUser(false);
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        var data = UserHrmModel.fromJson(response.data["rData"]);

        userInfo.value = data;
      }
    } catch (e) {
      rethrow;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoadUser(true);
      });
    }
  }

  void showMultiSelect() async {
    await showDialog(
      context: Get.context!,
      builder: (ctx) {
        return MultiSelectDialog(
          height: 250,
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
                    // ignore: prefer_interpolation_to_compose_strings
                    selectedDepartmentsValue.value + element.name + ",";
                selectedDepartmentsId.value =
                    // ignore: prefer_interpolation_to_compose_strings
                    selectedDepartmentsId.value + element.id.toString() + ",";
              },
            );
            getDayOffLetterSingler(
                needAppr: 0, astatus: selectedDepartmentsId.value);
          },
        );
      },
    );
  }

  void getDayOffLetterSingler(
      {required int needAppr, required String astatus}) async {
    var dio = Dio();

    var tokens = await SharePerApi().getTokenHRM();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    isLoadDayOff(false);

    var url =
        "${AppConstants.urlBaseHrm}/day-off-letters?needAppr=$needAppr&astatus=$astatus";

    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data["rData"];

        listDayOff.value =
            data.map((e) => DayOffLettersSingleModel.fromJson(e)).toList();
      }
    } catch (e) {
      rethrow;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoadDayOff(true);
      });
    }
  }
}
