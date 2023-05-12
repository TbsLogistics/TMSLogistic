import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself/model/user_hrm_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_details/model/letter_myself_detail_model.dart';

class LetterManagerDetailsSeeController extends GetxController {
  var dio = Dio();

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

  Future<UserHrmModel> getInfoClient({required String empId}) async {
    var tokens = await SharePerApi().getTokenHRM();

    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    var url = "${AppConstants.urlBaseHrm}/getEmpInfo?empId=$empId";
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
}
