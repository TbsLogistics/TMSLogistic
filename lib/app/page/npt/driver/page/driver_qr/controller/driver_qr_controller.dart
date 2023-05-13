import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_qr/model/details_driver_model.dart';

class QRCodeController extends GetxController {
  var idPhieuvao = 0.obs;
  Rx<DetailsDriverModel> user = DetailsDriverModel().obs;
  @override
  void onInit() {
    var maPhieuvao = Get.arguments;
    idPhieuvao.value = maPhieuvao;
    getInfor();

    super.onInit();
  }

  //lấy thông tin user
  void getInfor() async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenNPT();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url = "${AppConstants.urlBaseNpt}/getdetailByUsername";

    try {
      response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = DetailsDriverModel.fromJson(response.data);

        user.value = data;
      }
    } on DioError catch (e) {
      print(e.response!.statusCode);
    }
  }
}
