import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/model/tms_orders_model.dart';
import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class TmsFinishedController extends GetxController {
  var dio = Dio();
  late Response response;

  RxList<TmsOrdersModel> listOrder = <TmsOrdersModel>[].obs;

  RxBool isLoad = true.obs;

  @override
  void onInit() {
    getData();

    super.onInit();
  }

  void getData() async {
    var token = await SharePerApi().getTokenTMS();
    var idTX = await SharePerApi().getIdTX();
    var status = true;
    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/GetDataTransport?driver=$idTX&isCompleted=$status";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    isLoad(false);
    response = await dio.get(
      url,
      options: Options(
        headers: headers,
      ),
    );
    try {
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        // print("data $data");
        listOrder.value = data.map((e) => TmsOrdersModel.fromJson(e)).toList();
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoad(true);
    }
  }
}
