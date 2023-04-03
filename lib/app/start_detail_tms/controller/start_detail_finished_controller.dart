import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/model/list_data_for_place_model.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/model/list_place_model.dart';
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
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeReceiveEmpty![i] ==
            listOrder.value.getDataHandlingMobiles![j].diemLayRong) {
          var items = listOrder.value.getDataHandlingMobiles![j];
          listReceiveEmpty.value.add(items);
        }
      }
    }
    for (var i = 0; i < placeModel.value.placeReceiveEmpty!.length; i++) {
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeReceiveEmpty![i] ==
            listReceiveEmpty[j].diemLayRong) {
          var place = placeModel.value.placeReceiveEmpty![i];
          var getData = listOrder.value.getDataHandlingMobiles![j];
          listDataForReceiveEmpty.value.add(
            ListDataForPlaceModel(place: "$place", getData: [getData]),
          );
        }
      }
    }
    //++ Danh sách lấy hàng
    for (var i = 0; i < placeModel.value.placeReceive!.length; i++) {
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeReceive![i] ==
            listOrder.value.getDataHandlingMobiles![j].diemLayHang) {
          var items = listOrder.value.getDataHandlingMobiles![j];
          listReceive.value.add(items);
        }
      }
    }
    for (var i = 0; i < placeModel.value.placeReceive!.length; i++) {
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeReceive![i] == listReceive[j].diemLayHang) {
          var place = placeModel.value.placeReceive![i];
          var getData = listOrder.value.getDataHandlingMobiles![j];
          listDataForReceive.value.add(
            ListDataForPlaceModel(place: "$place", getData: [getData]),
          );
        }
      }
    }
    //++ Danh sách trả hàng
    for (var i = 0; i < placeModel.value.placeGive!.length; i++) {
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeGive![i] ==
            listOrder.value.getDataHandlingMobiles![j].diemTraHang) {
          var items = listOrder.value.getDataHandlingMobiles![j];
          listGive.value.add(items);
        }
      }
    }
    for (var i = 0; i < placeModel.value.placeGive!.length; i++) {
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeGive![i] == listGive[j].diemTraHang) {
          var place = placeModel.value.placeGive![i];
          var getData = listOrder.value.getDataHandlingMobiles![j];
          listDataForGive.value.add(
            ListDataForPlaceModel(place: "$place", getData: [getData]),
          );
        }
      }
    }
    //++ Danh sách trả rỗng
    for (var i = 0; i < placeModel.value.placeGiveEmpty!.length; i++) {
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeGiveEmpty![i] ==
            listOrder.value.getDataHandlingMobiles![j].diemTraRong) {
          var items = listOrder.value.getDataHandlingMobiles![j];
          listGiveEmpty.value.add(items);
        }
      }
    }
    for (var i = 0; i < placeModel.value.placeGiveEmpty!.length; i++) {
      for (var j = 0; j < listOrder.value.getDataHandlingMobiles!.length; j++) {
        if (placeModel.value.placeGiveEmpty![i] ==
            listGiveEmpty[j].diemTraRong) {
          var place = placeModel.value.placeGiveEmpty![i];
          var getData = listOrder.value.getDataHandlingMobiles![j];
          listDataForGiveEmpty.value.add(
            ListDataForPlaceModel(place: "$place", getData: [getData]),
          );
        }
      }
    }

    super.onInit();
  }
}
