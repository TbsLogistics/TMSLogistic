// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_ticker_registed/model/list_registed_of_customer_model.dart';

class CustomerListTickerRegistedController extends GetxController {
  var dio = Dio();
  late Response response;

  RxList<ListRegisterDriverOfCustomerModel> listTickerRegisted =
      <ListRegisterDriverOfCustomerModel>[].obs;

  RxBool isLoad = false.obs;

  @override
  void onInit() {
    getListRegistedCustomer();
    super.onInit();
  }

  //Danh sách phiếu vào của khách hàng
  void getListRegistedCustomer() async {
    var tokens = await SharePerApi().getTokenNPT();

    const url = "${AppConstants.urlBaseNpt}/list-register-driver-in-customer";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    isLoad(false);
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        // var data = response.data;

        List<dynamic> data = response.data["data"];
        listTickerRegisted.value = data
            .map((e) => ListRegisterDriverOfCustomerModel.fromJson(e))
            .toList();
      }
    } on DioError catch (e) {
      print(e.response!.statusMessage);
    } finally {
      isLoad(true);
    }
  }
}
