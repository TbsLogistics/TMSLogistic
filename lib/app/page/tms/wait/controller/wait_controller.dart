import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/tms/wait/model/tms_order_model.dart';

class AwaitController extends GetxController {
  var dio = Dio();
  late Response response;

  //Google map
  var locationMessage = ''.obs;
  late String latitude;
  late String longitude;
  RxDouble distances = 0.0.obs;
  late LocationPermission permission;
  Timer? timer;
  RxInt count = 0.obs;

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
    var status = false;
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
        listOrder.value = data.map((e) => TmsOrdersModel.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: "${e.response!.data["message"]}");
        // return [];
      }
    } finally {
      isLoad(true);
    }
  }

  void getDialogMessage(String messageText) {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "Thông báo",
      titleStyle: const TextStyle(
          color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
      content: SizedBox(
        height: 60,
        width: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    messageText,
                    style: const TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      confirm: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "Xác nhận",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return getSnack(message: 'Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return getSnack(message: 'Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return getSnack(
            message:
                'Location permissions are permanently denied, we cannot request permissions.');
      }
    }
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    var lat = position.latitude;
    var long = position.longitude;
    var latLate = position.latitude;
    var longLate = position.longitude;
    double distance = Geolocator.distanceBetween(
      lat,
      long,
      latLate,
      longLate,
    );

    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";
    distances.value = distance;
    locationMessage.value = "$lat,$long";
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
