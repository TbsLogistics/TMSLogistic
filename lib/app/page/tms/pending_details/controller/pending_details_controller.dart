// ignore_for_file: depend_on_referenced_packages, unused_local_variable, unrelated_type_equality_checks, duplicate_ignore

import 'dart:async';
import 'dart:io';
import "package:collection/collection.dart";
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/tms/finished_details/model/list_place_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/pending_details/model/geoLocationModel.dart';
import 'package:tbs_logistics_tms/app/page/tms/pending_details/model/list_data_for_place_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/surcharges/model/status_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/wait/model/tms_order_model.dart';

class PendingDetailController extends GetxController {
  Rx<TmsOrdersModel> listOrder = TmsOrdersModel().obs;

  //Google map
  var locationMessage = ''.obs;
  late String latitude;
  late String longitude;
  late LocationPermission permission;
  Timer? timer;

  RxDouble distances = 0.0.obs;
  List listLat = [];
  List listLong = [];

  //status

  RxList<StatusModel> checkStatus = <StatusModel>[].obs;
  final storage = GetStorage();

  RxList<bool> isPlacedReceiveEmpty =
      List<bool>.generate(0, (index) => false).obs;
  RxList<bool> isPlacedReceive = List<bool>.generate(0, (index) => false).obs;
  RxList<bool> isPlacedGive = List<bool>.generate(0, (index) => false).obs;
  RxList<bool> isPlacedGiveEmpty = List<bool>.generate(0, (index) => false).obs;

  //ContNo controller

  var contController = TextEditingController();
  TextEditingController cancelController = TextEditingController();

  //Danh sách địa điểm
  RxList<String> idPlaceReceiveEmpty = <String>[].obs;
  RxList<String> idPlaceReceive = <String>[].obs;
  RxList<String> idPlaceGive = <String>[].obs;
  RxList<String> idPlaceGiveEmpty = <String>[].obs;
  //+Danh sách status
  RxList<int> idStatusGive = <int>[].obs;
  RxList<int> idStatusGiveEmpty = <int>[].obs;

  //Danh sách getdataMobiles
  RxList<GetDataHandlingMobiles> getDataReceiveEmpty =
      <GetDataHandlingMobiles>[].obs;
  RxList<GetDataHandlingMobiles> getDataReceive =
      <GetDataHandlingMobiles>[].obs;
  RxList<GetDataHandlingMobiles> getDataGive = <GetDataHandlingMobiles>[].obs;
  RxList<GetDataHandlingMobiles> getDataGiveEmpty =
      <GetDataHandlingMobiles>[].obs;

  //Danh sách lọc địa điểm trùng nhau
  RxList<String> idSameReceiveEmpty = <String>[].obs;
  RxList<String> idSameReceive = <String>[].obs;
  RxList<String> idSameGive = <String>[].obs;
  RxList<String> idSameGiveEmpty = <String>[].obs;
  //++Danh sách trạng thái trùng nhau
  RxList<int> idSameStatusGive = <int>[].obs;
  RxList<int> idSameStatusGiveEmpty = <int>[].obs;

  //Danh sách vận đơn đi theo địa điểm
  RxList<GetDataHandlingMobiles> listReceiveEmpty =
      <GetDataHandlingMobiles>[].obs;
  RxList<GetDataHandlingMobiles> listReceive = <GetDataHandlingMobiles>[].obs;
  RxList<GetDataHandlingMobiles> listGive = <GetDataHandlingMobiles>[].obs;
  RxList<GetDataHandlingMobiles> listGiveEmpty = <GetDataHandlingMobiles>[].obs;

  //Danh sách vận đơn theo địa điểm
  RxList<ListDataForPlaceModel> listDataForGive = <ListDataForPlaceModel>[].obs;
  RxList<ListDataForPlaceModel> listDataForReceive =
      <ListDataForPlaceModel>[].obs;
  RxList<ListDataForPlaceModel> listDataForGiveEmpty =
      <ListDataForPlaceModel>[].obs;
  RxList<ListDataForPlaceModel> listDataForReceiveEmpty =
      <ListDataForPlaceModel>[].obs;

  //Danh sach final
  RxList<ListDataForPlaceModel> newListDataForReceive =
      <ListDataForPlaceModel>[].obs;
  RxList<ListDataForPlaceModel> newListDataForReceiveEmpty =
      <ListDataForPlaceModel>[].obs;
  RxList<ListDataForPlaceModel> newListDataForGive =
      <ListDataForPlaceModel>[].obs;
  RxList<ListDataForPlaceModel> newListDataForGiveEmpty =
      <ListDataForPlaceModel>[].obs;

  RxList dataForm = [].obs;

  Rx<ListPlaceModel> placeModel = ListPlaceModel().obs;
  RxList<String> listPlace = <String>[].obs;

  var isLoad = false.obs;
  var isLoadStatus = true.obs;
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    isLoad(false);
    formKey;
    var orDerDriver = Get.arguments as TmsOrdersModel;
    listOrder.value = orDerDriver;
    var length = listOrder.value.getDataHandlingMobiles!.length;

    // idSameReceiveEmpty
    for (int i = 0; i < length; i++) {
      if (listOrder.value.getDataHandlingMobiles![i].diemLayRong != null &&
          listOrder.value.getDataHandlingMobiles![i].diemLayRong != "") {
        String idPlaceReceiveEmpted =
            listOrder.value.getDataHandlingMobiles![i].diemLayRong!;
        idPlaceReceiveEmpty.add(idPlaceReceiveEmpted);
      }
    }
    // idSameReceive
    for (int i = 0; i < length; i++) {
      if (listOrder.value.getDataHandlingMobiles![i].diemLayHang != null &&
          listOrder.value.getDataHandlingMobiles![i].diemLayHang != "") {
        String idPlaceReceived =
            listOrder.value.getDataHandlingMobiles![i].diemLayHang!;
        idPlaceReceive.add(idPlaceReceived);
      }
    }
    // idSameGive
    for (int i = 0; i < length; i++) {
      if (listOrder.value.getDataHandlingMobiles![i].diemTraHang != null &&
          listOrder.value.getDataHandlingMobiles![i].diemTraHang != "") {
        String idPlaceGived =
            listOrder.value.getDataHandlingMobiles![i].diemTraHang!;
        idPlaceGive.add(idPlaceGived);
      }
    }
    // idSameGiveEmpty
    for (int i = 0; i < length; i++) {
      if (listOrder.value.getDataHandlingMobiles![i].diemTraRong != null &&
          listOrder.value.getDataHandlingMobiles![i].diemTraRong != "") {
        String idPlaceGiveEmpted =
            listOrder.value.getDataHandlingMobiles![i].diemTraRong!;
        idPlaceGiveEmpty.add(idPlaceGiveEmpted);
      }
    }
    idSameReceiveEmpty.value = idPlaceReceiveEmpty.toSet().toList();
    idSameReceive.value = idPlaceReceive.toSet().toList();
    idSameGive.value = idPlaceGive.toSet().toList();
    idSameGiveEmpty.value = idPlaceGiveEmpty.toSet().toList();

    placeModel.value = ListPlaceModel(
      placeReceiveEmpty: idSameReceiveEmpty,
      placeReceive: idSameReceive,
      placeGive: idSameGive,
      placeGiveEmpty: idSameGiveEmpty,
    );

    //Vòng for lọc vận đơn theo địa điểm
    //++ Danh sách trả rỗng
    for (var i = 0; i < placeModel.value.placeReceiveEmpty!.length; i++) {
      var place = placeModel.value.placeReceiveEmpty![i];
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeReceiveEmpty![i] ==
            listOrder.value.getDataHandlingMobiles![j].diemLayRong) {
          var items = listOrder.value.getDataHandlingMobiles![j];

          listReceiveEmpty.add(items);
          listDataForReceiveEmpty.add(
            ListDataForPlaceModel(place: place, getData: [items]),
          );
        }
      }
    }
    //Lọc địa điểm
    var groupedReceiveEmpty =
        listDataForReceiveEmpty.groupListsBy((element) => element.place);
    // Lọc khóa
    var keysReceiveEmpty = groupedReceiveEmpty.keys.toList();
    //Chạy vòng for theo list keysReceiveEmpty
    for (String? place in keysReceiveEmpty) {
      //Gộp getDataMobiles theo Place
      var dataReceiveEmpty =
          groupedReceiveEmpty[place]?.map((e) => e.getData).toList();
      //Bỏ dấu [] của các phần tử
      var combineReceiveEmpty =
          dataReceiveEmpty?.expand((element) => element!).toList();
      //Thêm dữ liệu vào danh sách final
      newListDataForReceiveEmpty.add(ListDataForPlaceModel(
          place: place, getData: combineReceiveEmpty ?? []));
    }

    //++ Danh sách lấy hàng-----------------------------------------------------------------------------
    for (var i = 0; i < placeModel.value.placeReceive!.length; i++) {
      var place = placeModel.value.placeReceive![i];
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeReceive![i] ==
            listOrder.value.getDataHandlingMobiles![j].diemLayHang) {
          var items = listOrder.value.getDataHandlingMobiles![j];

          listReceive.add(items);
          listDataForReceive.add(
            ListDataForPlaceModel(place: place, getData: [items]),
          );
        }
      }
    }
    //Lọc địa điểm

    var groupedReceive =
        listDataForReceive.groupListsBy((element) => element.place);
    // Lọc khóa
    var keysReceive = groupedReceive.keys.toList();
    //Chạy vòng for theo list keysReceive
    for (String? place in keysReceive) {
      //Gộp getDataMobiles theo Place
      var dataReceive = groupedReceive[place]?.map((e) => e.getData).toList();
      //Bỏ dấu [] của các phần tử
      var combineReceive = dataReceive?.expand((element) => element!).toList();
      //Thêm dữ liệu vào danh sách final
      newListDataForReceive.add(
          ListDataForPlaceModel(place: place, getData: combineReceive ?? []));
    }

    //++ Danh sách trả hàng --------------------------------------------------------------------
    for (var i = 0; i < placeModel.value.placeGive!.length; i++) {
      var place = placeModel.value.placeGive![i];
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeGive![i] ==
            listOrder.value.getDataHandlingMobiles![j].diemTraHang) {
          var items = listOrder.value.getDataHandlingMobiles![j];

          listGive.add(items);
          listDataForGive.add(
            ListDataForPlaceModel(place: place, getData: [items]),
          );
        }
      }
    }
    var groupedGive = listDataForGive.groupListsBy((element) => element.place);
    var keysGive = groupedGive.keys.toList();
    for (String? place in keysGive) {
      var dataGive = groupedGive[place]?.map((e) => e.getData).toList();
      var combineGive = dataGive?.expand((element) => element!).toList();
      newListDataForGive
          .add(ListDataForPlaceModel(place: place, getData: combineGive ?? []));
    }
    for (var i = 0; i < newListDataForGive.length; i++) {
      for (var j = 0; j < newListDataForGive[i].getData!.length; j++) {
        // ignore: unrelated_type_equality_checks
        if (newListDataForGive[i].getData![j].maTrangThai != "" &&
            newListDataForGive[i].getData![j].maTrangThai != null) {
          int items = newListDataForGive[i].getData![j].maTrangThai!;
          idStatusGive.add(items);
        }
      }
    }

    //++ Danh sách trả rỗng ---------------------------------------------------------------
    for (var i = 0; i < placeModel.value.placeGiveEmpty!.length; i++) {
      var place = placeModel.value.placeGiveEmpty![i];
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeGiveEmpty![i] ==
            listOrder.value.getDataHandlingMobiles![j].diemTraRong) {
          var items = listOrder.value.getDataHandlingMobiles![j];
          listGiveEmpty.add(items);
          listDataForGiveEmpty.add(
            ListDataForPlaceModel(place: place, getData: [items]),
          );
        }
      }
    }
    var groupedGiveEmpty =
        listDataForGiveEmpty.groupListsBy((element) => element.place);
    var keysGiveEmpty = groupedGiveEmpty.keys.toList();
    for (String? place in keysGiveEmpty) {
      var dataGiveEmpty =
          groupedGiveEmpty[place]?.map((e) => e.getData).toList();
      var combineGiveEmpty =
          dataGiveEmpty?.expand((element) => element!).toList();
      newListDataForGiveEmpty.add(
          ListDataForPlaceModel(place: place, getData: combineGiveEmpty ?? []));
    }
    for (var i = 0; i < newListDataForGiveEmpty.length; i++) {
      for (var j = 0; j < newListDataForGiveEmpty[i].getData!.length; j++) {
        // ignore: unrelated_type_equality_checks
        if (newListDataForGiveEmpty[i].getData![j].maTrangThai != "" &&
            newListDataForGiveEmpty[i].getData![j].maTrangThai != null) {
          int items = newListDataForGiveEmpty[i].getData![j].maTrangThai!;
          idStatusGiveEmpty.add(items);
        }
      }
    }

// List Bool nút "Đã đến" --------------------------------------------------------------------------------------
    isPlacedReceiveEmpty.value =
        List<bool>.generate(listDataForReceiveEmpty.length, (index) => false);
    isPlacedReceive.value =
        List<bool>.generate(listDataForReceive.length, (index) => false);
    isPlacedGive.value =
        List<bool>.generate(listDataForGive.length, (index) => false);
    isPlacedGiveEmpty.value =
        List<bool>.generate(listDataForGiveEmpty.length, (index) => false);

// Đọc bool từ danh sách đã xử lý theo mã được lưu tại GetS

    for (var i = 0; i < isPlacedReceiveEmpty.length; i++) {
      if (storage.hasData('ReceiveEmpty$i${listOrder.value.maChuyen}')) {
        isPlacedReceiveEmpty =
            (storage.read('ReceiveEmpty$i${listOrder.value.maChuyen}')
                    as List<dynamic>)
                .map((value) => value as bool)
                .toList()
                .obs;
      }
    }
    for (var i = 0; i < isPlacedReceive.length; i++) {
      if (storage.hasData('Receive$i${listOrder.value.maChuyen}')) {
        isPlacedReceive = (storage.read('Receive$i${listOrder.value.maChuyen}')
                as List<dynamic>)
            .map((value) => value as bool)
            .toList()
            .obs;
      }
    }
    for (var i = 0; i < isPlacedGive.length; i++) {
      if (storage.hasData('Give$i${listOrder.value.maChuyen}')) {
        isPlacedGive =
            (storage.read('Give$i${listOrder.value.maChuyen}') as List<dynamic>)
                .map((value) => value as bool)
                .toList()
                .obs;
      }
    }
    for (var i = 0; i < isPlacedGiveEmpty.length; i++) {
      if (storage.hasData('GiveEmpty$i${listOrder.value.maChuyen}')) {
        isPlacedGiveEmpty =
            (storage.read('GiveEmpty$i${listOrder.value.maChuyen}')
                    as List<dynamic>)
                .map((value) => value as bool)
                .toList()
                .obs;
      }
    }

    isLoad(true);
    super.onInit();
  }

  void updateReceiveEmpty({required int index, required int placeId}) {
    isLoadStatus(false);
    isPlacedReceiveEmpty[index] = !isPlacedReceiveEmpty[index];
    // Store the updated boolean list in get_storage
    storage.write(
        'ReceiveEmpty$index${listOrder.value.maChuyen}', isPlacedReceiveEmpty);
    // getCurrentLocation();
    postGeolorcation(placeId: placeId);
    isLoadStatus(true);
  }

  void updateReceive({required int index, required int placeId}) {
    isLoadStatus(false);
    isPlacedReceive[index] = !isPlacedReceive[index];
    // Store the updated boolean list in get_storage
    storage.write('Receive$index${listOrder.value.maChuyen}', isPlacedReceive);
    // getCurrentLocation();
    postGeolorcation(placeId: placeId);
    isLoadStatus(true);
  }

  void updateGive({required int index, required int placeId}) {
    isLoadStatus(false);
    isPlacedGive[index] = !isPlacedGive[index];
    // Store the updated boolean list in get_storage
    storage.write('Give$index${listOrder.value.maChuyen}', isPlacedGive);
    // getCurrentLocation();
    postGeolorcation(placeId: placeId);
    isLoadStatus(true);
  }

  void updateGiveEmpty({required int index, required int placeId}) {
    isLoadStatus(false);
    isPlacedGiveEmpty[index] = !isPlacedGiveEmpty[index];
    // Store the updated boolean list in get_storage
    storage.write(
        'GiveEmpty$index${listOrder.value.maChuyen}', isPlacedGiveEmpty);
    // getCurrentLocation();
    postGeolorcation(placeId: placeId);
    isLoadStatus(true);
  }

  void postSetRuning(
      {required int firstIndex,
      required int secondIndex,
      required int id,
      required String idList}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    isLoadStatus(false);
    // isLoad(false);
    isLoading(true);

    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/ChangeStatusHandling?id=$id&maChuyen=${listOrder.value.maChuyen}";
    try {
      response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;

        Get.back();
        // getSnack(message: "${data["message"]}");
        getDialog(message: data["message"]);
        var listPTCVItems = [];
        var listSamePTVCItems = [];
        var lenghtGetData = listOrder.value.getDataHandlingMobiles!.length;
        for (var i = 0; i < lenghtGetData; i++) {
          var items = listOrder.value.getDataHandlingMobiles![i].maPTVC;
          listPTCVItems.add(items);
        }
        int position = listPTCVItems.indexOf('FCL');
        listSamePTVCItems = listPTCVItems.toSet().toList();
        //Trường hợp cont đặc biệt
        if (listSamePTVCItems.length == 2) {
          cont20Special(
              firstIndex: firstIndex,
              secondIndex: secondIndex,
              idList: idList,
              position: position);
        } else {
          stateProcessing(
              firstIndex: firstIndex, secondIndex: secondIndex, idList: idList);
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: "${e.response!.data["message"]}");
      }
    } finally {
      Future.delayed(const Duration(seconds: 2), () {
        isLoading(false);
        // isLoad(true);
        isLoadStatus(true);
      });
    }
  }

  //Bắt đầu chuyến
  void postSetRuningStart({required int id}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/ChangeStatusHandling?id=$id&maChuyen=${listOrder.value.maChuyen}";
    try {
      response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;

        // Get.back(result: true);
        getSnack(message: data["message"]);

        listOrder.value;
        timerRealTime();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: e.response!.data);
      }
    }
  }

  void postCancel(
      {required int firstIndex,
      required int secondsIndex,
      required int id,
      required String idList}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    // isLoad(false);
    isLoadStatus(false);
    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/CancelHandling?handlingId=$id";
    Get.back(result: true);
    try {
      response = await dio.post(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = response.data;

        getDialog(message: data["message"]);
        switch (idList) {
          case "lr":
            switch (newListDataForReceiveEmpty[firstIndex]
                .getData![secondsIndex]
                .maTrangThai) {
              case 17:
                newListDataForReceiveEmpty[firstIndex]
                    .getData![secondsIndex]
                    .maTrangThai = 46;
                break;
              default:
            }
            break;
          case "lh":
            switch (newListDataForReceive[firstIndex]
                .getData![secondsIndex]
                .maTrangThai) {
              case 37:
                newListDataForReceive[firstIndex]
                    .getData![secondsIndex]
                    .maTrangThai = 46;
                break;
              case 40:
                newListDataForReceive[firstIndex]
                    .getData![secondsIndex]
                    .maTrangThai = 46;
                break;

              default:
            }
            break;
          case "th":
            switch (newListDataForGive[firstIndex]
                .getData![secondsIndex]
                .maTrangThai) {
              case 18:
                newListDataForGive[firstIndex]
                    .getData![secondsIndex]
                    .maTrangThai = 46;
                break;
              default:
            }
            break;
          case "tr":
            switch (newListDataForGiveEmpty[firstIndex]
                .getData![secondsIndex]
                .maTrangThai) {
              case 18:
                newListDataForGiveEmpty[firstIndex]
                    .getData![secondsIndex]
                    .maTrangThai = 46;
                break;
              default:
            }
            break;
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: "${e.response!.data["message"]}");
      }
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoadStatus(true);
        // isLoad(true);
      });
    }
  }

  void postSetRuningTypeFull({required int id}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/ChangeStatusHandling?id=$id&maChuyen=${listOrder.value.maChuyen}";
    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        listOrder.value;
        var data = response.data;
        Get.back(result: true);
        getSnack(message: "${response.data["message"]}");
        cancelTimer();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: "${e.response!.data["message"]}");
      } else if (e.response!.statusCode == 500) {
        getSnack(message: "${e.response!.data["message"]}");
      }
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoad(false);
      });
    }
  }

  void updateContNo({required String maChuyen, required String contNo}) async {
    var tokens = await SharePerApi().getTokenTMS();
    var dio = Dio();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/UpdateContNo?maChuyen=$maChuyen&contNo=$contNo";
    try {
      response = await dio.post(url, options: Options(headers: headers));

      if (response.statusCode == 200) {
        var data = response.data;

        Get.back(result: true);

        getSnack(message: "${response.data["message"]}");
        listOrder.value.getDataHandlingMobiles![0].contNo = contNo;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: "${e.response!.data["message"]}");
      }
    }
  }

  void loadData() async {
    // isLoading.value = true; // Set loading to true before starting operation

    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: Colors.white,
      title: "Loading",
      content: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              color: Colors.orangeAccent,
            ),
          ),
        ],
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

    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";

    locationMessage.value = "$lat,$long";
  }

  void postGeolorcation({required int placeId}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    var geoLocation = GeoLocationModel(
      placeId: placeId,
      gps: locationMessage.value,
    );
    var jsonData = geoLocation.toJson();

    var url =
        "${AppConstants.urlBaseTms}/api/Mobile/LogGPS?maChuyen=${listOrder.value.maChuyen}";

    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonData,
      );

      if (response.statusCode == 200) {
        var data = response.data;
        // getSnack(message: "${response.data["message"]}");
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(message: "${e.response!.data["message"]}");
      }
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

  void getDialog({required String message}) {
    Get.defaultDialog(
        backgroundColor: Colors.white,
        title: "Thông báo",
        titleStyle: const TextStyle(
          color: Colors.red,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        content: Column(
          children: [
            Text(
              message,
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 16,
              ),
            ),
          ],
        ),
        confirm: Container(
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Colors.white),
          ),
          height: 45,
          width: 120,
          child: TextButton(
            child: const Text(
              "Xác nhận",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ));
  }

  void cont20Special(
      {required int firstIndex,
      required int secondIndex,
      required String idList,
      required int position}) {
    switch (listOrder.value.getDataHandlingMobiles![0].loaiVanDon) {
      case "xuat":
        switch (idList) {
          case "lr":
            switch (newListDataForReceiveEmpty[firstIndex]
                .getData![secondIndex]
                .maPTVC) {
              case "LCL":
                for (var i = 0;
                    i < newListDataForReceiveEmpty[firstIndex].getData!.length;
                    i++) {
                  if (newListDataForReceiveEmpty[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          17 &&
                      i != position) {
                    newListDataForReceiveEmpty[firstIndex]
                        .getData![i]
                        .maTrangThai = 37;
                  }
                }

                break;
              case "FCL":
                newListDataForReceiveEmpty[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai = 37;
                break;
            }
            break;
          case "lh":
            switch (newListDataForReceive[firstIndex]
                .getData![secondIndex]
                .maPTVC) {
              case "LCL":
                switch (newListDataForReceive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 37:
                    newListDataForReceive[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai = 18;
                    break;
                  case 40:
                    newListDataForReceive[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai = 18;
                    break;
                }
                break;
              case "FCL":
                switch (newListDataForReceive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 37:
                    newListDataForReceive[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai = 18;
                    break;
                  case 40:
                    newListDataForReceive[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai = 18;
                    break;
                }
                break;
            }
            break;
          case "th":
            var listIdPlaceItems = [];
            var listSameIdPlaceItems = [];
            for (var i = 0;
                i < listOrder.value.getDataHandlingMobiles!.length;
                i++) {
              var itemsSamePlace =
                  listOrder.value.getDataHandlingMobiles![i].diemTraHang;
              listIdPlaceItems.add(itemsSamePlace);
            }
            listSameIdPlaceItems = listIdPlaceItems.toSet().toList();
            if (listSameIdPlaceItems.length == 2) {
              switch (
                  newListDataForGive[firstIndex].getData![secondIndex].maPTVC) {
                case "LCL":
                  for (var i = 0;
                      i < newListDataForGive[firstIndex].getData!.length;
                      i++) {
                    if (newListDataForGive[firstIndex]
                                .getData![i]
                                .maTrangThai ==
                            18 &&
                        newListDataForGive[firstIndex].getData![i].maPTVC ==
                            "LCL") {
                      newListDataForGive[firstIndex].getData![i].maTrangThai =
                          36;
                    }
                  }
                  var listIdStatus = [];
                  var listIdSameStatus = [];
                  for (var i = 0;
                      i < listOrder.value.getDataHandlingMobiles!.length;
                      i++) {
                    var items =
                        listOrder.value.getDataHandlingMobiles![i].maTrangThai;
                    listIdStatus.add(items);
                  }
                  listIdSameStatus = listIdStatus.toSet().toList();
                  if (listIdSameStatus.length == 1 &&
                          listIdSameStatus.contains(36) == true ||
                      listIdSameStatus.length == 2 &&
                          listIdSameStatus.contains(36) == true &&
                          listIdSameStatus.contains(46) == true) {
                    listOrder
                        .value
                        .getDataHandlingMobiles![
                            listOrder.value.getDataHandlingMobiles!.length - 1]
                        .maTrangThai = 36;
                  }
                  break;
                case "FCL":
                  newListDataForGive[firstIndex]
                      .getData![secondIndex]
                      .maTrangThai = 36;
                  var listIdStatusItems = [];
                  var listIdSameStatusItems = [];
                  for (var i = 0;
                      i < listOrder.value.getDataHandlingMobiles!.length;
                      i++) {
                    var items =
                        listOrder.value.getDataHandlingMobiles![i].maTrangThai;
                    listIdStatusItems.add(items);
                  }
                  listIdSameStatusItems = listIdStatusItems.toSet().toList();
                  if (listIdSameStatusItems.length == 1 &&
                          listIdSameStatusItems.contains(36) == true ||
                      listIdSameStatusItems.length == 2 &&
                          listIdSameStatusItems.contains(36) == true &&
                          listIdSameStatusItems.contains(46) == true) {
                    listOrder
                        .value
                        .getDataHandlingMobiles![
                            listOrder.value.getDataHandlingMobiles!.length - 1]
                        .maTrangThai = 36;
                  }
                  break;
              }
            } else {
              switch (
                  newListDataForGive[firstIndex].getData![secondIndex].maPTVC) {
                case "LCL":
                  for (var i = 0;
                      i < newListDataForGive[firstIndex].getData!.length;
                      i++) {
                    if (newListDataForGive[firstIndex]
                                .getData![i]
                                .maTrangThai ==
                            18 &&
                        i != position) {
                      newListDataForGive[firstIndex].getData![i].maTrangThai =
                          36;
                    }
                  }
                  var listIdStatus = [];
                  var listIdSameStatus = [];
                  for (var i = 0;
                      i < listOrder.value.getDataHandlingMobiles!.length;
                      i++) {
                    var items =
                        listOrder.value.getDataHandlingMobiles![i].maTrangThai;
                    listIdStatus.add(items);
                  }
                  listIdSameStatus = listIdStatus.toSet().toList();
                  if (listIdSameStatus.length == 1 &&
                          listIdSameStatus.contains(36) == true ||
                      listIdSameStatus.length == 2 &&
                          listIdSameStatus.contains(36) == true &&
                          listIdSameStatus.contains(46) == true) {
                    listOrder
                        .value
                        .getDataHandlingMobiles![
                            listOrder.value.getDataHandlingMobiles!.length - 1]
                        .maTrangThai = 36;
                  }
                  break;
                case "FCL":
                  newListDataForGive[firstIndex]
                      .getData![secondIndex]
                      .maTrangThai = 36;
                  var listIdStatusItems = [];
                  var listIdSameStatusItems = [];
                  for (var i = 0;
                      i < listOrder.value.getDataHandlingMobiles!.length;
                      i++) {
                    var items =
                        listOrder.value.getDataHandlingMobiles![i].maTrangThai;
                    listIdStatusItems.add(items);
                  }
                  listIdSameStatusItems = listIdStatusItems.toSet().toList();
                  if (listIdSameStatusItems.length == 1 &&
                          listIdSameStatusItems.contains(36) == true ||
                      listIdSameStatusItems.length == 2 &&
                          listIdSameStatusItems.contains(36) == true &&
                          listIdSameStatusItems.contains(46) == true) {
                    listOrder
                        .value
                        .getDataHandlingMobiles![
                            listOrder.value.getDataHandlingMobiles!.length - 1]
                        .maTrangThai = 36;
                  }
                  break;
              }
            }

            break;
        }
        break;
      case "nhap":
        switch (idList) {
          case "lh":
            switch (newListDataForReceive[firstIndex]
                .getData![secondIndex]
                .maPTVC) {
              case "LCL":
                switch (newListDataForReceive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 37:
                    for (var i = 0;
                        i < newListDataForReceive[firstIndex].getData!.length;
                        i++) {
                      if (newListDataForReceive[firstIndex]
                                  .getData![i]
                                  .maTrangThai ==
                              37 &&
                          newListDataForReceive[firstIndex]
                                  .getData![i]
                                  .maPTVC ==
                              "LCL") {
                        newListDataForReceive[firstIndex]
                            .getData![i]
                            .maTrangThai = 18;
                      }
                    }

                    break;
                  case 40:
                    for (var i = 0;
                        i < newListDataForReceive[firstIndex].getData!.length;
                        i++) {
                      if (newListDataForReceive[firstIndex]
                                  .getData![i]
                                  .maTrangThai ==
                              40 &&
                          newListDataForReceive[firstIndex]
                                  .getData![i]
                                  .maPTVC ==
                              "LCL") {
                        newListDataForReceive[firstIndex]
                            .getData![i]
                            .maTrangThai = 18;
                      }
                    }
                    break;
                }
                break;
              case "FCL":
                switch (newListDataForReceive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 37:
                    newListDataForReceive[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai = 18;
                    break;
                  case 40:
                    newListDataForReceive[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai = 18;
                    break;
                }
                break;
            }
            break;
          case "th":
            switch (
                newListDataForGive[firstIndex].getData![secondIndex].maPTVC) {
              case "LCL":
                newListDataForGive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai = 35;
                break;
              case "FCL":
                newListDataForGive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai = 35;
                break;
            }

            break;
          case "tr":
            var listIdPlaceItems = [];
            var listSameIdPlaceItems = [];
            for (var i = 0;
                i < listOrder.value.getDataHandlingMobiles!.length;
                i++) {
              var itemsSamePlace =
                  listOrder.value.getDataHandlingMobiles![i].diemTraRong;
              listIdPlaceItems.add(itemsSamePlace);
            }
            listSameIdPlaceItems = listIdPlaceItems.toSet().toList();
            if (listSameIdPlaceItems.length == 2) {
              switch (newListDataForGiveEmpty[firstIndex]
                  .getData![secondIndex]
                  .maPTVC) {
                case "LCL":
                  for (var i = 0;
                      i < newListDataForGiveEmpty[firstIndex].getData!.length;
                      i++) {
                    if (newListDataForGiveEmpty[firstIndex]
                                .getData![i]
                                .maTrangThai ==
                            18 &&
                        newListDataForGiveEmpty[firstIndex]
                                .getData![i]
                                .maPTVC ==
                            "LCL") {
                      newListDataForGiveEmpty[firstIndex]
                          .getData![i]
                          .maTrangThai = 48;
                    }
                  }
                  var listIdStatus = [];
                  var listIdSameStatus = [];
                  for (var i = 0;
                      i < listOrder.value.getDataHandlingMobiles!.length;
                      i++) {
                    var items =
                        listOrder.value.getDataHandlingMobiles![i].maTrangThai;
                    listIdStatus.add(items);
                  }
                  listIdSameStatus = listIdStatus.toSet().toList();
                  if (listIdSameStatus.length == 1 &&
                          listIdSameStatus.contains(36) == true ||
                      listIdSameStatus.length == 2 &&
                          listIdSameStatus.contains(36) == true &&
                          listIdSameStatus.contains(46) == true) {
                    listOrder
                        .value
                        .getDataHandlingMobiles![
                            listOrder.value.getDataHandlingMobiles!.length - 1]
                        .maTrangThai = 48;
                  }
                  break;
                case "FCL":
                  newListDataForGiveEmpty[firstIndex]
                      .getData![secondIndex]
                      .maTrangThai = 48;
                  var listIdStatusItems = [];
                  var listIdSameStatusItems = [];
                  for (var i = 0;
                      i < listOrder.value.getDataHandlingMobiles!.length;
                      i++) {
                    var items =
                        listOrder.value.getDataHandlingMobiles![i].maTrangThai;
                    listIdStatusItems.add(items);
                  }
                  listIdSameStatusItems = listIdStatusItems.toSet().toList();
                  if (listIdSameStatusItems.length == 1 &&
                          listIdSameStatusItems.contains(48) == true ||
                      listIdSameStatusItems.length == 2 &&
                          listIdSameStatusItems.contains(48) == true &&
                          listIdSameStatusItems.contains(46) == true) {
                    listOrder
                        .value
                        .getDataHandlingMobiles![
                            listOrder.value.getDataHandlingMobiles!.length - 1]
                        .maTrangThai = 48;
                  }
                  break;
              }
            } else {
              // print([
              //   newListDataForGiveEmpty[firstIndex]
              //       .getData![secondIndex]
              //       .maPTVC,
              //   position
              // ]);
              switch (newListDataForGiveEmpty[firstIndex]
                  .getData![secondIndex]
                  .maPTVC) {
                case "LCL":
                  for (var i = 0;
                      i < newListDataForGiveEmpty[firstIndex].getData!.length;
                      i++) {
                    if (newListDataForGiveEmpty[firstIndex]
                                .getData![i]
                                .maTrangThai ==
                            35 &&
                        i != position) {
                      newListDataForGiveEmpty[firstIndex]
                          .getData![i]
                          .maTrangThai = 48;
                    }
                  }
                  var listIdStatus = [];
                  var listIdSameStatus = [];
                  for (var i = 0;
                      i < listOrder.value.getDataHandlingMobiles!.length;
                      i++) {
                    var items =
                        listOrder.value.getDataHandlingMobiles![i].maTrangThai;
                    listIdStatus.add(items);
                  }
                  listIdSameStatus = listIdStatus.toSet().toList();
                  if (listIdSameStatus.length == 1 &&
                          listIdSameStatus.contains(48) == true ||
                      listIdSameStatus.length == 2 &&
                          listIdSameStatus.contains(48) == true &&
                          listIdSameStatus.contains(46) == true) {
                    listOrder
                        .value
                        .getDataHandlingMobiles![
                            listOrder.value.getDataHandlingMobiles!.length - 1]
                        .maTrangThai = 48;
                  }
                  break;
                case "FCL":
                  newListDataForGiveEmpty[firstIndex]
                      .getData![secondIndex]
                      .maTrangThai = 48;
                  var listIdStatusItems = [];
                  var listIdSameStatusItems = [];
                  for (var i = 0;
                      i < listOrder.value.getDataHandlingMobiles!.length;
                      i++) {
                    var items =
                        listOrder.value.getDataHandlingMobiles![i].maTrangThai;
                    listIdStatusItems.add(items);
                  }
                  listIdSameStatusItems = listIdStatusItems.toSet().toList();
                  if (listIdSameStatusItems.length == 1 &&
                          listIdSameStatusItems.contains(48) == true ||
                      listIdSameStatusItems.length == 2 &&
                          listIdSameStatusItems.contains(48) == true &&
                          listIdSameStatusItems.contains(46) == true) {
                    listOrder
                        .value
                        .getDataHandlingMobiles![
                            listOrder.value.getDataHandlingMobiles!.length - 1]
                        .maTrangThai = 48;
                  }
                  break;
              }
            }

            break;
        }
        break;
    }
  }

  void stateProcessing(
      {required int firstIndex,
      required int secondIndex,
      required String idList}) {
    switch (listOrder.value.maPTVC) {
      case "LCL":
        switch (listOrder.value.getDataHandlingMobiles![0].loaiVanDon) {
          case "xuat":
            switch (idList) {
              case "lr":
                switch (newListDataForReceiveEmpty[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 17:
                    for (var i = 0;
                        i <
                            newListDataForReceiveEmpty[firstIndex]
                                .getData!
                                .length;
                        i++) {
                      if (newListDataForReceiveEmpty[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          17) {
                        newListDataForReceiveEmpty[firstIndex]
                            .getData![i]
                            .maTrangThai = 37;
                      }
                    }
                    break;
                  default:
                }
                break;
              case "lh":
                switch (newListDataForReceive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 37:
                    if (newListDataForReceive[firstIndex]
                            .getData![secondIndex]
                            .maTrangThai ==
                        37) {
                      newListDataForReceive[firstIndex]
                          .getData![secondIndex]
                          .maTrangThai = 18;
                    }
                    break;
                  case 40:
                    if (newListDataForReceive[firstIndex]
                            .getData![secondIndex]
                            .maTrangThai ==
                        40) {
                      newListDataForReceive[firstIndex]
                          .getData![secondIndex]
                          .maTrangThai = 18;
                    }
                    break;
                  case 46:
                    if (newListDataForReceive[firstIndex]
                            .getData![secondIndex]
                            .maTrangThai ==
                        46) {
                      newListDataForReceive[firstIndex]
                          .getData![secondIndex]
                          .maTrangThai = 46;
                    }
                    break;
                  default:
                }
                break;
              case "th":
                switch (newListDataForGive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 18:
                    for (var i = 0;
                        i < newListDataForGive[firstIndex].getData!.length;
                        i++) {
                      if (newListDataForGive[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          18) {
                        newListDataForGive[firstIndex].getData![i].maTrangThai =
                            36;
                      }
                    }
                    var listIdStatus = [];
                    var listIdSameStatus = [];
                    for (var i = 0;
                        i < newListDataForGive[firstIndex].getData!.length;
                        i++) {
                      var items = newListDataForGive[firstIndex]
                          .getData![i]
                          .maTrangThai;
                      listIdStatus.add(items);
                    }
                    listIdSameStatus = listIdStatus.toSet().toList();
                    if (listIdSameStatus.length == 1 &&
                            listIdSameStatus.contains(36) == true ||
                        listIdSameStatus.length == 2 &&
                            listIdSameStatus.contains(36) == true &&
                            listIdSameStatus.contains(46) == true) {
                      listOrder
                          .value
                          .getDataHandlingMobiles![
                              listOrder.value.getDataHandlingMobiles!.length -
                                  1]
                          .maTrangThai = 36;
                    }
                    break;
                  default:
                }
                break;
            }
            break;
          case "nhap":
            switch (idList) {
              case "":
                listOrder
                    .value
                    .getDataHandlingMobiles![
                        listOrder.value.getDataHandlingMobiles!.length - 1]
                    .maTrangThai = 20;
                break;
              case "lr":
                switch (newListDataForReceiveEmpty[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 17:
                    for (var i = 0;
                        i <
                            newListDataForReceiveEmpty[firstIndex]
                                .getData!
                                .length;
                        i++) {
                      if (newListDataForReceiveEmpty[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          17) {
                        newListDataForReceiveEmpty[firstIndex]
                            .getData![i]
                            .maTrangThai = 37;
                      }
                    }
                    break;

                  default:
                }
                break;
              case "lh":
                switch (newListDataForReceive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 37:
                    for (var i = 0;
                        i < newListDataForReceive[firstIndex].getData!.length;
                        i++) {
                      if (newListDataForReceive[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          37) {
                        newListDataForReceive[firstIndex]
                            .getData![i]
                            .maTrangThai = 18;
                      }
                    }
                    break;

                  case 40:
                    for (var i = 0;
                        i < newListDataForReceive[firstIndex].getData!.length;
                        i++) {
                      if (newListDataForReceive[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          40) {
                        newListDataForReceive[firstIndex]
                            .getData![i]
                            .maTrangThai = 18;
                      }
                    }
                    break;
                  default:
                }
                break;
              case "th":
                switch (newListDataForGive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 18:
                    for (var i = 0;
                        i < newListDataForGive[firstIndex].getData!.length;
                        i++) {
                      if (newListDataForGive[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          18) {
                        newListDataForGive[firstIndex].getData![i].maTrangThai =
                            35;
                      }
                    }
                    break;
                  case 46:
                    for (var i = 0;
                        i < newListDataForGive[firstIndex].getData!.length;
                        i++) {
                      if (newListDataForGive[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          46) {
                        newListDataForGive[firstIndex].getData![i].maTrangThai =
                            46;
                      }
                    }
                    break;
                  default:
                }
                break;
              case "tr":
                switch (newListDataForGiveEmpty[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 35:
                    for (var i = 0;
                        i < newListDataForGiveEmpty[firstIndex].getData!.length;
                        i++) {
                      if (newListDataForGiveEmpty[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          35) {
                        newListDataForGiveEmpty[firstIndex]
                            .getData![i]
                            .maTrangThai = 48;
                        listOrder
                            .value
                            .getDataHandlingMobiles![
                                listOrder.value.getDataHandlingMobiles!.length -
                                    1]
                            .maTrangThai = 48;
                      }
                    }
                    break;
                  case 46:
                    for (var i = 0;
                        i < newListDataForGiveEmpty[firstIndex].getData!.length;
                        i++) {
                      if (newListDataForGiveEmpty[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          46) {
                        newListDataForGiveEmpty[firstIndex]
                            .getData![i]
                            .maTrangThai = 46;
                      }
                    }
                    break;
                  default:
                }
                break;
              default:
            }
        }
        break;
      case "LTL":
        switch (idList) {
          case "lh":
            switch (newListDataForReceive[firstIndex]
                .getData![secondIndex]
                .maTrangThai) {
              case 37:
                if (newListDataForReceive[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai ==
                    37) {
                  for (var i = 0;
                      i < newListDataForReceive[firstIndex].getData!.length;
                      i++) {
                    if (newListDataForReceive[firstIndex]
                            .getData![i]
                            .maTrangThai !=
                        46) {
                      newListDataForReceive[firstIndex]
                          .getData![i]
                          .maTrangThai = 18;
                    }
                  }
                }
                break;
              case 40:
                if (newListDataForReceive[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai ==
                    40) {
                  for (var i = 0;
                      i < newListDataForReceive[firstIndex].getData!.length;
                      i++) {
                    newListDataForReceive[firstIndex].getData![i].maTrangThai =
                        18;
                  }
                }
                break;

              default:
            }
            break;
          case "th":
            switch (newListDataForGive[firstIndex]
                .getData![secondIndex]
                .maTrangThai) {
              case 18:
                newListDataForGive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai = 36;
                var listIdStatus = [];
                var listSameStatus = [];
                for (var i = 0; i < newListDataForGive.length; i++) {
                  for (var j = 0;
                      j < newListDataForGive[i].getData!.length;
                      j++) {
                    var items = newListDataForGive[i].getData![j].maTrangThai;

                    listIdStatus.add(items);
                  }
                  listSameStatus = listIdStatus.toSet().toList();
                }
                if (listSameStatus.length == 1 &&
                        listSameStatus.contains(36) == true ||
                    listSameStatus.length == 2 &&
                        listSameStatus.contains(46) == true &&
                        listSameStatus.contains(36) == true) {
                  listOrder
                      .value
                      .getDataHandlingMobiles![
                          listOrder.value.getDataHandlingMobiles!.length - 1]
                      .maTrangThai = 36;
                }
                break;
              default:
            }
            break;

          default:
        }
        break;
      case "FTL":
        switch (idList) {
          case "lh":
            switch (newListDataForReceive[firstIndex]
                .getData![secondIndex]
                .maTrangThai) {
              case 37:
                for (var i = 0;
                    i < newListDataForReceive[firstIndex].getData!.length;
                    i++) {
                  if (newListDataForReceive[firstIndex]
                          .getData![i]
                          .maTrangThai ==
                      37) {
                    newListDataForReceive[firstIndex].getData![i].maTrangThai =
                        18;
                  }
                }
                break;
              case 40:
                for (var i = 0;
                    i < newListDataForReceive[firstIndex].getData!.length;
                    i++) {
                  if (newListDataForReceive[firstIndex]
                          .getData![i]
                          .maTrangThai ==
                      40) {
                    newListDataForReceive[firstIndex].getData![i].maTrangThai =
                        18;
                  }
                }
                break;
              default:
            }
            break;
          case "th":
            switch (newListDataForGive[firstIndex]
                .getData![secondIndex]
                .maTrangThai) {
              case 18:
                for (var i = 0;
                    i < newListDataForGive[firstIndex].getData!.length;
                    i++) {
                  if (newListDataForGive[firstIndex].getData![i].maTrangThai ==
                      18) {
                    listOrder
                        .value
                        .getDataHandlingMobiles![
                            listOrder.value.getDataHandlingMobiles!.length - 1]
                        .maTrangThai = 36;
                  }
                }
                break;

              default:
            }
            break;

          default:
        }
        break;

      case "FCL":
        switch (listOrder.value.getDataHandlingMobiles!.length) {
          case 1:
            switch (idList) {
              case "lr":
                switch (newListDataForReceiveEmpty[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 17:
                    for (var i = 0;
                        i <
                            newListDataForReceiveEmpty[firstIndex]
                                .getData!
                                .length;
                        i++) {
                      if (newListDataForReceiveEmpty[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          17) {
                        newListDataForReceiveEmpty[firstIndex]
                            .getData![i]
                            .maTrangThai = 37;
                      }
                    }
                    break;
                  default:
                }
                break;
              case "lh":
                switch (newListDataForReceive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 37:
                    for (var i = 0;
                        i < newListDataForReceive[firstIndex].getData!.length;
                        i++) {
                      if (newListDataForReceive[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          37) {
                        newListDataForReceive[firstIndex]
                            .getData![i]
                            .maTrangThai = 18;
                      }
                    }
                    break;
                  case 40:
                    for (var i = 0;
                        i < newListDataForReceive[firstIndex].getData!.length;
                        i++) {
                      if (newListDataForReceive[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          40) {
                        newListDataForReceive[firstIndex]
                            .getData![i]
                            .maTrangThai = 18;
                      }
                    }
                    break;

                  default:
                }
                break;
              case "th":
                switch (newListDataForGive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 18:
                    if (newListDataForGive[firstIndex]
                            .getData![secondIndex]
                            .loaiVanDon ==
                        "nhap") {
                      for (var i = 0;
                          i < newListDataForGive[firstIndex].getData!.length;
                          i++) {
                        if (newListDataForGive[firstIndex]
                                .getData![i]
                                .maTrangThai ==
                            18) {
                          newListDataForGive[firstIndex]
                              .getData![i]
                              .maTrangThai = 35;
                        }
                      }
                    } else {
                      for (var i = 0;
                          i < newListDataForGive[firstIndex].getData!.length;
                          i++) {
                        if (newListDataForGive[firstIndex]
                                .getData![i]
                                .maTrangThai ==
                            18) {
                          listOrder
                              .value
                              .getDataHandlingMobiles![listOrder
                                      .value.getDataHandlingMobiles!.length -
                                  1]
                              .maTrangThai = 36;
                        }
                      }
                    }

                    break;

                  default:
                }
                break;
              case "tr":
                switch (newListDataForGiveEmpty[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 35:
                    for (var i = 0;
                        i < newListDataForGiveEmpty[firstIndex].getData!.length;
                        i++) {
                      if (newListDataForGiveEmpty[firstIndex]
                              .getData![i]
                              .maTrangThai ==
                          35) {
                        listOrder
                            .value
                            .getDataHandlingMobiles![
                                listOrder.value.getDataHandlingMobiles!.length -
                                    1]
                            .maTrangThai = 48;
                      }
                    }
                    break;
                  default:
                }
                break;
              default:
            }
            break;
          case 2:
            switch (idList) {
              case "lr":
                switch (newListDataForReceiveEmpty[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 17:
                    newListDataForReceiveEmpty[firstIndex]
                            .getData![secondIndex]
                            .maTrangThai ==
                        37;
                    break;
                  default:
                }
                break;
              case "lh":
                switch (newListDataForReceive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 37:
                    newListDataForReceive[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai = 18;
                    break;
                  case 40:
                    newListDataForReceive[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai = 18;
                    break;
                  default:
                }
                break;
              case "th":
                switch (newListDataForGive[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 18:
                    if (newListDataForGive[firstIndex]
                            .getData![secondIndex]
                            .loaiVanDon ==
                        "nhap") {
                      newListDataForGive[firstIndex]
                          .getData![secondIndex]
                          .maTrangThai = 35;
                    } else {
                      newListDataForGive[firstIndex]
                          .getData![secondIndex]
                          .maTrangThai = 36;
                      var listIdStatus = [];
                      var listIdSameStatus = [];
                      for (var i = 0;
                          i < newListDataForGive[firstIndex].getData!.length;
                          i++) {
                        if (newListDataForGive[firstIndex]
                                .getData![i]
                                .maTrangThai ==
                            18) {
                          var items = newListDataForGive[firstIndex]
                              .getData![i]
                              .maTrangThai;
                          listIdStatus.add(items);
                          listIdSameStatus = listIdStatus.toSet().toList();
                        }
                        if (listIdSameStatus.length == 1 &&
                                listIdSameStatus.contains(36) == true ||
                            listIdSameStatus.length == 2 &&
                                listIdSameStatus.contains(36) == true &&
                                listIdSameStatus.contains(46) == true) {
                          listOrder
                              .value
                              .getDataHandlingMobiles![listOrder
                                      .value.getDataHandlingMobiles!.length -
                                  1]
                              .maTrangThai = 36;
                        }
                      }
                    }

                    break;

                  default:
                }
                break;
              case "tr":
                switch (newListDataForGiveEmpty[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 35:
                    newListDataForGiveEmpty[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai = 48;
                    var listIdStatus = [];
                    var listIdSameStatus = [];
                    for (var i = 0;
                        i < newListDataForGiveEmpty[firstIndex].getData!.length;
                        i++) {
                      var items = newListDataForGiveEmpty[firstIndex]
                          .getData![i]
                          .maTrangThai;
                      listIdStatus.add(items);
                    }
                    listIdSameStatus = listIdStatus.toSet().toList();
                    if (listIdSameStatus.length == 1 &&
                            listIdSameStatus.contains(48) == true ||
                        listIdSameStatus.length == 2 &&
                            listIdSameStatus.contains(48) == true &&
                            listIdSameStatus.contains(46) == true) {
                      listOrder
                          .value
                          .getDataHandlingMobiles![
                              listOrder.value.getDataHandlingMobiles!.length -
                                  1]
                          .maTrangThai = 48;
                    }
                    break;
                  default:
                }
                break;
              default:
            }
            break;
        }
        break;
      default:
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

  void cancelTimer() {
    timer!.cancel();
    timer = null;
  }
}
