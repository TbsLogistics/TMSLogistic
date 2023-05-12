// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/tms/start_detail_tms/model/list_data_for_place_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/surcharges/model/list_sub_fee_curred_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/surcharges/model/list_subfee_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/surcharges/model/sur_changes_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/surcharges/model/sur_fee_post_model.dart';

class SurChangesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var listSurchanges = <SurChangesModel>[].obs;

  var listSurRegisted = <ListSubFeeIncurredModel>[].obs;
  var listSurRegister = <SurFeeModel>[].obs;
  var listSur = <SurChangesModel>[].obs;

  var itemList = <String>[].obs;
  var selectedValue = 0.obs;
  var subFee = "".obs;
  var priceText = "".obs;
  var ghichu = "".obs;

  var maChuyen = "".obs;

  var isLoadListSur = false.obs;

  Rx<ListDataForPlaceModel> listDataForPlace = ListDataForPlaceModel().obs;
  var idPlaced = 0.obs;

  final formKey = GlobalKey<FormState>();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Danh sách thêm'),
    const Tab(text: 'Danh sách đã thêm'),
  ];
  late TabController tabController;

  @override
  void onInit() {
    isLoadListSur(false);
    var dataForPlace = Get.arguments[0] as ListDataForPlaceModel;
    var idChuyen = Get.arguments[1];
    var maPlace = Get.arguments[2];
    print([maPlace, idChuyen]);
    maChuyen.value = idChuyen;
    listDataForPlace.value = dataForPlace;
    idPlaced.value = maPlace;
    listSubFeeIncurred();
    tabController = TabController(vsync: this, length: myTabs.length);
    formKey;
    Future.delayed(const Duration(seconds: 1), () {
      isLoadListSur(true);
    });
    super.onInit();
  }

  addItem(String item) {
    itemList.add(item);
  }

  addSurTimes({
    required int price,
    required int sfId,
    required String sfName,
    required String note,
  }) {
    listSur.add(
      SurChangesModel(
        placeId: idPlaced.value,
        sfId: sfId,
        sfName: sfName,
        finalPrice: price,
        note: note,
      ),
    );
  }

  addSurFee({
    required int price,
    required int sfId,
    required String note,
  }) {
    listSurRegister.add(
      SurFeeModel(
        placeId: idPlaced.value,
        sfId: sfId,
        finalPrice: price,
        note: note,
      ),
    );
    print("listSurRegister : $listSurRegister");
  }

  void postData(List<SurFeeModel> listSurRegister) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();

    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/CreateSFeeByTCommand?maChuyen=${maChuyen.value}";
    print("listSurRegister : ${listSurRegister[0].sfId}");
    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonEncode(listSurRegister),
      );

      if (response.statusCode == 200) {
        // Handle success
        var data = response.data;
        String message = data["message"];

        Get.back();
        getSnack(message: message.trim());

        listSurRegisted.refresh();
      } else {
        // Handle error
      }
    } on DioError catch (e) {
      // Handle exception

      if (e.response!.statusCode == 400) {
        getSnack(message: e.response!.data["message"]);
      }
    }
  }

  void listSubFeeIncurred() async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/GetListSubfeeIncurred?maChuyen=${maChuyen.value}&placeId=${idPlaced.value}";

    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        List data = response.data;
        listSurRegisted.value =
            data.map((e) => ListSubFeeIncurredModel.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: e.response!.data["message"]);
      }
    }
  }

  Future<List<ListSubFeeModel>> getSubFee(query) async {
    var tokens = await SharePerApi().getTokenTMS();
    Response response;
    var dio = Dio();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/GetListSubFeeSelect?placeId=${idPlaced.value}";

    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: {"query": query},
      );
      if (response.statusCode == 200) {
        var data = response.data;
        if (data != null) {
          return ListSubFeeModel.fromJsonList(data);
        }
        return [];
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  void getSnack({required String message}) {
    Get.snackbar(
      "",
      "",
      backgroundColor: Colors.white,
      titleText: const Text(
        "Thông báo",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }
}
