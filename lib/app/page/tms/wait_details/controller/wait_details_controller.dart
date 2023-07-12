import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/tms/wait/model/tms_order_model.dart';

class AwaitDetailsController extends GetxController {
  Rx<TmsOrdersModel> detailOrder = TmsOrdersModel().obs;
  TextEditingController contNoController = TextEditingController();
  Timer? timer;
  //Google map
  var locationMessage = ''.obs;
  late String latitude;
  late String longitude;
  RxDouble distances = 0.0.obs;
  late LocationPermission permission;
  List listLat = [];
  List listLong = [];

  //ListPlaceZone
  List listPlace = [];
  RxList listTatolPlace = [].obs;
  RxList listGiveEmpty = [].obs;
  RxList listGive = [].obs;
  RxList listReceiveEmpty = [].obs;
  RxList listReceive = [].obs;

  RxList<String> items = ['Item 1', 'Hello 2', 'Win 3', 'Item 4'].obs;

  @override
  void onInit() {
    var orDerDriver = Get.arguments as TmsOrdersModel;
    detailOrder.value = orDerDriver;
    listPlaceZone();
    super.onInit();
  }

  void listPlaceZone() {
    for (var i = 0; i < detailOrder.value.getDataHandlingMobiles!.length; i++) {
      var items = detailOrder.value.getDataHandlingMobiles![i];
      listPlace.add({
        "giveEmpty": items.diemLayRong,
        "give": items.diemLayHang,
        "receive": items.diemTraHang,
        "receiveEmpty": items.diemTraRong
      });
    }
    for (var i = 0; i < listPlace.length; i++) {
      var items = listPlace[i];
      listReceiveEmpty.add(items["giveEmpty"]);
      listReceive.add(items["give"]);
      listGive.add(items["receive"]);
      listGiveEmpty.add(items["receiveEmpty"]);
    }
    // listTatolPlace = {
    //   "ReceiveEmpty": listReceiveEmpty,
    //   "Receive": listReceive,
    //   "Give": listGive,
    //   "GiveEmpty": listGiveEmpty,
    // };
    listReceive.value = listReceive.toSet().toList();
    listReceiveEmpty.value = listReceiveEmpty.toSet().toList();
    listGive.value = listGive.toSet().toList();
    listGiveEmpty.value = listGiveEmpty.toSet().toList();
    print([listReceive, listReceiveEmpty, listGive, listGiveEmpty]);
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
  }

  //Bắt đầu chuyến
  void postSetRuning({required int id}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/ChangeStatusHandling?id=$id&maChuyen=${detailOrder.value.maChuyen}";
    try {
      response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;

        Get.back(result: true);
        getSnack(message: data["message"]);

        detailOrder.value;
        timerRealTime();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: e.response!.data);
      }
    }
  }

  void timerRealTime() {
    timer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) {
        getCurrentLocation();
        // count.value = count.value + 1;
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
