import 'dart:io';
import "package:collection/collection.dart";
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/model/list_data_for_place_model.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/model/list_place_model.dart';
import 'package:tbs_logistics_tms/app/surcharges/model/status_model.dart';
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/model/tms_orders_model.dart';
import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class StartDetailPendingController extends GetxController {
  Rx<TmsOrdersModel> listOrder = TmsOrdersModel().obs;

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
        idPlaceReceiveEmpty.value.add(idPlaceReceiveEmpted);
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
        idPlaceGiveEmpty.value.add(idPlaceGiveEmpted);
      }
    }
    idSameReceiveEmpty.value = idPlaceReceiveEmpty.toSet().toList();
    idSameReceive.value = idPlaceReceive.toSet().toList();
    idSameGive.value = idPlaceGive.toSet().toList();
    idSameGiveEmpty.value = idPlaceGiveEmpty.toSet().toList();

    placeModel.value = ListPlaceModel(
      placeReceiveEmpty: idSameReceiveEmpty.value,
      placeReceive: idSameReceive.value,
      placeGive: idSameGive.value,
      placeGiveEmpty: idSameGiveEmpty.value,
    );

    //Vòng for lọc vận đơn theo địa điểm
    //++ Danh sách trả rỗng
    for (var i = 0; i < placeModel.value.placeReceiveEmpty!.length; i++) {
      var place = placeModel.value.placeReceiveEmpty![i];
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeReceiveEmpty![i] ==
            listOrder.value.getDataHandlingMobiles![j].diemLayRong) {
          var items = listOrder.value.getDataHandlingMobiles![j];

          listReceiveEmpty.value.add(items);
          listDataForReceiveEmpty.value.add(
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

          listReceive.value.add(items);
          listDataForReceive.value.add(
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

          listGive.value.add(items);
          listDataForGive.value.add(
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

    //++ Danh sách trả rỗng ---------------------------------------------------------------
    for (var i = 0; i < placeModel.value.placeGiveEmpty!.length; i++) {
      var place = placeModel.value.placeGiveEmpty![i];
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeGiveEmpty![i] ==
            listOrder.value.getDataHandlingMobiles![j].diemTraRong) {
          var items = listOrder.value.getDataHandlingMobiles![j];
          listGiveEmpty.value.add(items);
          listDataForGiveEmpty.value.add(
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

  void updateReceiveEmpty(int index) {
    isPlacedReceiveEmpty[index] = !isPlacedReceiveEmpty[index];
    // Store the updated boolean list in get_storage
    storage.write(
        'ReceiveEmpty$index${listOrder.value.maChuyen}', isPlacedReceiveEmpty);
  }

  void updateReceive(int index) {
    isPlacedReceive[index] = !isPlacedReceive[index];
    // Store the updated boolean list in get_storage
    storage.write('Receive$index${listOrder.value.maChuyen}', isPlacedReceive);
  }

  void updateGive(int index) {
    isPlacedGive[index] = !isPlacedGive[index];
    // Store the updated boolean list in get_storage
    storage.write('Give$index${listOrder.value.maChuyen}', isPlacedGive);

    print("isPlacedGiveTest : $isPlacedGive");
  }

  void updateGiveEmpty(int index) {
    isPlacedGiveEmpty[index] = !isPlacedGiveEmpty[index];
    // Store the updated boolean list in get_storage
    storage.write(
        'GiveEmpty$index${listOrder.value.maChuyen}', isPlacedGiveEmpty);
  }

  void postSetRuning(
      {required int firstIndex,
      required int secondIndex,
      required int id,
      required String idList}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    isLoadStatus(false);

    isLoad(false);

    isLoading(true);

    var url =
        "${AppConstants.urlBase}/api/Mobile/ChangeStatusHandling?id=$id&maChuyen=${listOrder.value.maChuyen}";
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
        // loadData();

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
            "${data["message"]} !",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
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
                          newListDataForReceiveEmpty[firstIndex]
                              .getData![i]
                              .maTrangThai = 37;
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
                        for (var i = 0;
                            i < newListDataForGive[firstIndex].getData!.length;
                            i++) {
                          newListDataForGive[firstIndex]
                              .getData![i]
                              .maTrangThai = 36;
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
                            .maTrangThai = 20;
                        break;

                      default:
                    }
                    break;
                }
                break;
              case "nhap":
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
                          newListDataForReceiveEmpty[firstIndex]
                              .getData![i]
                              .maTrangThai = 37;
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
                            i <
                                newListDataForReceive[firstIndex]
                                    .getData!
                                    .length;
                            i++) {
                          newListDataForReceive[firstIndex]
                              .getData![i]
                              .maTrangThai = 18;
                        }
                        break;
                      case 40:
                        for (var i = 0;
                            i <
                                newListDataForReceive[firstIndex]
                                    .getData!
                                    .length;
                            i++) {
                          newListDataForReceive[firstIndex]
                              .getData![i]
                              .maTrangThai = 18;
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
                            .maTrangThai = 35;
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
                            i <
                                newListDataForGiveEmpty[firstIndex]
                                    .getData!
                                    .length;
                            i++) {
                          newListDataForGiveEmpty[firstIndex]
                              .getData![i]
                              .maTrangThai = 20;
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
                    for (var j = 0; j < newListDataForReceive.length; j++) {
                      for (var i = 0;
                          i < newListDataForReceive[j].getData!.length;
                          i++) {
                        newListDataForReceive[j].getData![i].maTrangThai = 18;
                      }
                    }
                    break;
                  case 40:
                    for (var i = 0;
                        i < newListDataForReceive[firstIndex].getData!.length;
                        i++) {
                      newListDataForReceive[firstIndex]
                          .getData![i]
                          .maTrangThai = 18;
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
                        .maTrangThai = 20;
                    break;
                  default:
                }
                break;

              default:
            }
            break;
          case "FTL":
            switch (idList) {
              case "lr":
                switch (newListDataForReceiveEmpty[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 17:
                    newListDataForReceiveEmpty[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai = 37;
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
                    listOrder
                        .value
                        .getDataHandlingMobiles![
                            listOrder.value.getDataHandlingMobiles!.length - 1]
                        .maTrangThai = 36;
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
                        .maTrangThai = 20;
                    break;
                  default:
                }
                break;
              default:
            }
            break;

          case "FCL":
            switch (idList) {
              case "lr":
                switch (newListDataForReceiveEmpty[firstIndex]
                    .getData![secondIndex]
                    .maTrangThai) {
                  case 17:
                    newListDataForReceiveEmpty[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai = 37;
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
                    listDataForReceive[firstIndex]
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
                    newListDataForGive[firstIndex]
                        .getData![secondIndex]
                        .maTrangThai = 35;
                    listOrder
                        .value
                        .getDataHandlingMobiles![
                            listOrder.value.getDataHandlingMobiles!.length - 1]
                        .maTrangThai = 36;
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
                        .maTrangThai = 20;
                    break;

                  default:
                }
                break;
              default:
            }
            break;
          default:
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        if (e.response!.data["message"] == "Vui lòng cập nhật ContNo") {
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
              "${e.response!.data["message"]} !",
              style: const TextStyle(
                color: Colors.green,
              ),
            ),
          );
        }
      }
    } finally {
      Future.delayed(Duration(seconds: 1), () {
        isLoad(true);
        isLoading(false);
        isLoadStatus(true);
      });
    }
  }

  void postCancel(
      {required int firstIndex,
      required int secondsIndex,
      required int id,
      required String idList}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    isLoad(false);
    var url =
        "${AppConstants.urlBase}/api/Mobile/CancelHandling?handlingId=$id";
    Get.back(result: true);
    try {
      response = await dio.post(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = response.data;

        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: Text(
            "${data["message"]}",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
        switch (idList) {
          case "lr":
            switch (listDataForReceiveEmpty[firstIndex]
                .getData![secondsIndex]
                .maTrangThai) {
              case 17:
                listDataForReceiveEmpty[firstIndex]
                    .getData![secondsIndex]
                    .maTrangThai = 20;
                break;

              default:
            }
            break;
          case "lh":
            switch (listDataForReceive[firstIndex]
                .getData![secondsIndex]
                .maTrangThai) {
              case 37:
                listDataForReceive[firstIndex]
                    .getData![secondsIndex]
                    .maTrangThai = 20;
                break;
              case 40:
                listDataForReceive[firstIndex]
                    .getData![secondsIndex]
                    .maTrangThai = 20;
                break;

              default:
            }
            break;
          case "th":
            switch (listDataForGive[firstIndex]
                .getData![secondsIndex]
                .maTrangThai) {
              case 18:
                listDataForGive[firstIndex].getData![secondsIndex].maTrangThai =
                    20;
                break;
              default:
            }
            break;
          case "tr":
            switch (listDataForGiveEmpty[firstIndex]
                .getData![secondsIndex]
                .maTrangThai) {
              case 18:
                listDataForGiveEmpty[firstIndex]
                    .getData![secondsIndex]
                    .maTrangThai = 20;
                break;
              default:
            }
            break;
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: Text(
            "${e.response!.data["message"]}",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
      }
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoad(true);
        isLoading(false);
      });
    }
  }

  void postSetRuningTypeFull({required int handlingId}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    isLoad(false);

    var url =
        "${AppConstants.urlBase}/api/Mobile/ChangeStatusHandling?id=$handlingId&maChuyen=${listOrder.value.maChuyen}";
    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        listOrder.value;

        var data = response.data;

        Get.back(result: true);
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
            "${data["message"]} !",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
        listOrder
            .value
            .getDataHandlingMobiles![
                listOrder.value.getDataHandlingMobiles!.length - 1]
            .maTrangThai = 20;
        isLoad(true);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        // print(e.response!.statusCode);

        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: const Text(
            "Mã điều phối không tồn tại !",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        );
      }
    }
  }

  void updateContNo({required String maChuyen, required String contNo}) async {
    var tokens = await SharePerApi().getToken();
    var dio = Dio();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var url =
        "${AppConstants.urlBase}/api/Mobile/UpdateContNo?maChuyen=$maChuyen&contNo=$contNo";
    try {
      response = await dio.post(url, options: Options(headers: headers));

      if (response.statusCode == 200) {
        var data = response.data;

        Get.back(result: true);
        Get.snackbar(
          "Thông báo",
          "Lỗi thực thi",
          backgroundColor: Colors.white,
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: Text(
            "${response.data["message"]}",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
        listOrder.value.getDataHandlingMobiles![0].contNo = contNo;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        Get.snackbar(
          "Thông báo",
          "Lỗi thực thi",
          backgroundColor: Colors.white,
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: Text(
            "${e.response!.data["message"]}",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
      }
    }
  }

  void loadData() async {
    isLoading.value = true; // Set loading to true before starting operation

    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: Colors.white,
      title: "Loading",
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: CircularProgressIndicator(
              color: Colors.orangeAccent,
            ),
          ),
        ],
      ),
    );

    await Future.delayed(Duration(seconds: 1)); // Simulate loading

    isLoading.value = false; // Set loading to false after operation is complete
  }
}
