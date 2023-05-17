import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_driver_of_customer/model/list_tracking_model.dart';

class CustomerListTickerRegistedController extends GetxController {
  var dio = Dio();
  late Response response;

  RxList<ListTrackingModel> listTickerRegisted = <ListTrackingModel>[].obs;

  @override
  void onInit() {
    getListRegistedCustomer();
    super.onInit();
  }

  //Danh sách phiếu vào của khách hàng
  void getListRegistedCustomer() async {
    var tokens = await SharePerApi().getTokenNPT();

    const url = "${AppConstants.urlBaseNpt}/danhSachPhieuVaoDaHoanThanh";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        List<dynamic> data = response.data;
        listTickerRegisted.value =
            data.map((e) => ListTrackingModel.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      print(e.response!.statusMessage);
    }
  }
}
