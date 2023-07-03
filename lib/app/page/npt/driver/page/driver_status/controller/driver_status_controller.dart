import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status/model/driver_list_ticker_model.dart';

class DriverStatusController extends GetxController {
  var dio = Dio();
  late Response response;

  RxList<DriverListTickerModel> listDriverFinishedScreen =
      <DriverListTickerModel>[].obs;
  RxBool isLoadList = true.obs;
  @override
  void onInit() {
    getListStatusUnfinish();

    super.onInit();
  }

  void getListStatusUnfinish() async {
    var dio = Dio();
    Response response;
    var token = await SharePerApi().getTokenNPT();

    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var url = "${AppConstants.urlBaseNpt}/invote/read";
    isLoadList(false);

    try {
      response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        List<dynamic> data = response.data["data"];

        listDriverFinishedScreen.value =
            data.map((e) => DriverListTickerModel.fromJson(e)).toList();
      }
    } catch (e) {
      rethrow;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoadList(true);
      });
    }
  }
}
