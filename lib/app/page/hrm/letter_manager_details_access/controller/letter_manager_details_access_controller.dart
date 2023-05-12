import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager/model/letter_manager_approve_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself/model/user_hrm_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_details/model/letter_myself_detail_model.dart';

class LetterManagerDetailsAccessController extends GetxController {
  var dio = Dio();

  TextEditingController reasonManagerController = TextEditingController();

  Future<LetterMyselfDetailsModel> detailSingle({required int regID}) async {
    var tokens = await SharePerApi().getTokenHRM();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    // ignore: unnecessary_brace_in_string_interps
    var url = "${AppConstants.urlBaseHrm}/day-off-letter?regid=${regID}";

    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var data = LetterMyselfDetailsModel.fromJson(response.data);
        return data;
      }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserHrmModel> getInfo() async {
    var tokens = await SharePerApi().getTokenHRM();

    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    const url = "${AppConstants.urlBaseHrm}/getEmpInfo";
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        var data = UserHrmModel.fromJson(response.data["rData"]);

        return data;
      }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postApprove({
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
        if (data["rCode"] == 0) {
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
        } else if (data["rCode"] == 1) {
          Get.toNamed(Routes.MANAGER_LEAVE_FORM_SCREEN);
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
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
