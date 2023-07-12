// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
// import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/tms/wait/model/tms_order_model.dart';

class TmsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  int currentIndex = 0;

  final inactiveColor = Colors.grey;
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
  List listLat = [];
  List listLong = [];
  int visit = 0;

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Lệnh chờ'),
    const Tab(text: 'Lệnh thực hiện'),
    const Tab(text: 'Lệnh hoàn thành'),
  ];
  late TabController controller;

  @override
  void onInit() {
    controller = TabController(vsync: this, length: myTabs.length);
    // diaLogMessage(
    //   size: Get.size,
    // );
    getCurrentLocation();

    super.onInit();
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

    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";

    locationMessage.value = "$lat,$long";
  }

  Future<List<TmsOrdersModel>> getData(
      {required String id, required String status}) async {
    var token = await SharePerApi().getTokenTMS();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/GetDataTransport?driver=$id&isCompleted=$status";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    response = await dio.get(
      url,
      options: Options(
        headers: headers,
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;

      return data.map((e) => TmsOrdersModel.fromJson(e)).toList();
    }
    return response.data;
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

  void timerRealTime() {
    timer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) {
        getCurrentLocation();
        // count.value = count.value + 1;
        count.value++;
        var count1 = locationMessage.value.indexOf(",");
        if (count1 != -1 && locationMessage.value != "") {
          var lat = locationMessage.value.substring(0, count1 - 1);
          var long = locationMessage.value
              .substring(count1 + 1, locationMessage.value.length);
          listLat.add(lat);
          listLong.add(long);
        }

        if (listLat.length >= 2) {
          for (int i = 1; i < listLat.length; i++) {
            double distance = Geolocator.distanceBetween(
              double.parse(listLat[listLat.length - 2]),
              double.parse(listLong[listLat.length - 2]),
              double.parse(listLat[listLong.length - 1]),
              double.parse(listLong[listLong.length - 1]),
            );

            // distances.value = Geolocator.distanceBetween(
            //   double.parse(listLat[i - 1]),
            //   double.parse(listLat[i]),
            //   double.parse(listLong[i - 1]),
            //   double.parse(listLong[i]),
            // );
            distances.value = distance;
            print([distances.value.round().toInt(), distance]);

            if (distances.value.round().toInt() < 100) {
              // getDialogMessage("Bạn dừng ở vị trí quá lâu !");
              print("ERROR");
            } else {
              print("object");
            }
          }
        }

        print([locationMessage.value]);

        // print([count, locationMessage.value.substring(0, count1)]);
      },
    );
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

  void cancelTimer() {
    timer!.cancel();
    // timer = null;
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }
}
