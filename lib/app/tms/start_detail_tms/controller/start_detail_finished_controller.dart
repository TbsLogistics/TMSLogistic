// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tbs_logistics_tms/app/tms/start_detail_tms/model/list_data_for_place_model.dart';
import 'package:tbs_logistics_tms/app/tms/start_detail_tms/model/list_place_model.dart';
import 'package:tbs_logistics_tms/config/model/tms_orders_model.dart';

class StartDetailFinishedController extends GetxController {
  Rx<TmsOrdersModel> listOrder = TmsOrdersModel().obs;

  //ContNo controller

  var contController = TextEditingController();

  //Danh sách địa điểm
  RxList<String> idPlaceReceiveEmpty = <String>[].obs;
  RxList<String> idPlaceReceive = <String>[].obs;
  RxList<String> idPlaceGive = <String>[].obs;
  RxList<String> idPlaceGiveEmpty = <String>[].obs;

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

  Rx<ListPlaceModel> placeModel = ListPlaceModel().obs;

  final storage = GetStorage();
  var isLoad = true.obs;
  var isLoadStatus = true.obs;

  @override
  void onInit() {
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
    //++ Danh sách trả rỗng---------------------------------------------------------------------
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

    //++ Danh sách lấy hàng-------------------------------------------------------------------
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
    //++ Danh sách trả hàng----------------------------------------------------------------------
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

    //++ Danh sách trả rỗng-------------------------------------------------------------------------
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

    super.onInit();
  }
}
