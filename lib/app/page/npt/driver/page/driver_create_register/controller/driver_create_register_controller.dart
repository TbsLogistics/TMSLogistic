import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_of_ware_home_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/list_customer_of_ware_home_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_customer_for_driver_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_car.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_product_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_warehome_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/register_driver_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/select_list_model.dart';

class DriverCreateRegisterController extends GetxController {
  //tikerin
  TextEditingController numberCar = TextEditingController();
  TextEditingController numberCont1 = TextEditingController();
  TextEditingController numberCont2 = TextEditingController();
  TextEditingController numberCont1Seal1 = TextEditingController();
  TextEditingController numberCont1Seal2 = TextEditingController();

  TextEditingController numberCont2Seal1 = TextEditingController();
  TextEditingController numberCont2Seal2 = TextEditingController();

  TextEditingController numberKien = TextEditingController(text: "0");
  TextEditingController numberKien1 = TextEditingController(text: "0");

  TextEditingController numberKhoi = TextEditingController(text: "0");
  TextEditingController numberKhoi1 = TextEditingController(text: "0");

  TextEditingController numberBook = TextEditingController();
  TextEditingController numberBook1 = TextEditingController();

  TextEditingController numberTan = TextEditingController(text: "0");
  TextEditingController numberTan1 = TextEditingController(text: "0");
  // tickerout
  TextEditingController contRa1 = TextEditingController();
  TextEditingController contRa2 = TextEditingController();
  TextEditingController contRa1seal1 = TextEditingController();
  TextEditingController contRa1seal2 = TextEditingController();
  TextEditingController contRa2seal1 = TextEditingController();
  TextEditingController contRa2seal2 = TextEditingController();

  TextEditingController searchTextEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxList<ListCustomerForDriverModel> selectListCustomer =
      <ListCustomerForDriverModel>[].obs;

  Rx<ListCustomerForDriverModel> selectCustomer =
      ListCustomerForDriverModel().obs;

  Rx<ListWareHomeModel> selectWareHome = ListWareHomeModel().obs;

  Rx<ListTypeProductModel> selectTypeProduct = ListTypeProductModel().obs;

  Rx<ListTypeCarModel> selectTypeCar = ListTypeCarModel().obs;

  var isClientSelect = true.obs;
  var selectListItem = <SelectedListItem>[].obs;

  String? selectItems;

  var selectedKhachhang = "";

  @override
  void onInit() async {
    formKey;
    super.onInit();
    getKhachhang();
  }

  Future<List<CustomerOfWareHomeModel>> getCusomter(String? maKho) async {
    for (var i = 0; i < listKhachhang.length; i++) {
      if (listKhachhang[i].maKho == maKho) {
        var items = listKhachhang[i];
        listClient.add(items);
      } else {
        listClient.value = [];
      }
    }

    return listClient;
  }

  Future<void> postRegisterDriver(
      {required String? maKhachHang,
      required String? time,
      required String? typeWarehome,
      required String? typeCar,
      required String? numberCar,
      required String? numberCont1,
      required String? numberCont1Seal1,
      required String? numberCont1Seal2,
      required double? numberKien,
      required double? numberKhoi,
      required String? numberBook,
      required double? numberTan,
      required String? numberCont2,
      required String? numberCont2Seal1,
      required String? numberCont2Seal2,
      required double? numberKien1,
      required double? numberKhoi1,
      required String? numberBook1,
      required double? numberTan1,
      required String? typeProduct,
      required int? numberCont}) async {
    var dio = Dio();
    Response response;
    var token = await SharePerApi().getTokenNPT();
    var idDriver = await SharePerApi().getIdUser();
    var idTeamCar = await SharePerApi().getIdKHforTX();

    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    const url = "${AppConstants.urlBaseNpt}/createphieuvaocong";
    var create = RegisterForDriverModel(
      maTaixe: int.parse(idDriver),
      maKhachHang: maKhachHang,
      maDoixe: idTeamCar,
      giodukien: time,
      kho: typeWarehome,
      note: "",
      loaixe: typeCar,
      soxe: numberCar,
      soReMooc: "",
      socont1: numberCont1,
      socont2: numberCont2,
      cont1seal1: numberCont1Seal1,
      cont1seal2: numberCont1Seal2,
      soKien: numberKien ?? 0,
      sokhoi: numberKhoi ?? 0,
      soBook: numberBook,
      soTan: numberTan ?? 0,
      trangthaihang: false,
      trangthaikhoa: false,
      cont2seal1: numberCont2Seal1,
      cont2seal2: numberCont2Seal2,
      sokien1: numberKien1 ?? 0,
      sokhoi1: numberKhoi1 ?? 0,
      soBook1: numberBook1,
      soTan1: numberTan1 ?? 0,
      trangthaihang1: false,
      trangthaikhoa1: false,
      maloaiHang: typeProduct,
      soXera: "",
    );

    var jsonData = create.toJson();

    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonData,
      );
      if (response.statusCode == 200) {
        var data = response.data;

        if (data["status"] == 204) {
          Get.snackbar(
            "Thông báo",
            "${data["detail"]}",
            titleText: const Text(
              "Thông báo",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              "${data["detail"]}",
              style: const TextStyle(
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            snackPosition: SnackPosition.TOP,
          );
        } else {
          getSnack(messageText: "${data["detail"]}");

          Get.toNamed(Routes.DETAILS_FORM_REGISTER_DRIVER, arguments: [
            RegisterForDriverModel(
              maKhachHang: maKhachHang,
              maDoixe: idTeamCar,
              giodukien: time,
              kho: typeWarehome,
              loaixe: typeCar,
              soxe: numberCar,
              socont1: numberCont1,
              socont2: numberCont2,
              cont1seal1: numberCont1Seal1,
              cont1seal2: numberCont1Seal2,
              soKien: numberKien,
              sokhoi: numberKhoi,
              soBook: numberBook,
              trangthaihang: false,
              trangthaikhoa: false,
              cont2seal1: numberCont2Seal1,
              cont2seal2: numberCont2Seal2,
              sokien1: numberKien1,
              sokhoi1: numberKhoi1,
              soBook1: numberBook1,
              trangthaihang1: false,
              trangthaikhoa1: false,
              maloaiHang: typeProduct,
              soTan: numberTan,
              soTan1: numberTan1,
            ),
            data["data1"],
            numberCont,
          ]);
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
      } else {
        if (e.response!.statusCode == 422) {
        } else {
          if (e.response!.statusCode == 500) {
            getSnack(
                messageText: "Lỗi máy chủ, vui lòng thử lại trong giây lát !");
          }
        }
      }
    }
  }

  // Danh sách khách hàng
  Future<List<ListCustomerForDriverModel>> getDataCustomer(query) async {
    var dio = Dio();
    Response response;
    var token = await SharePerApi().getTokenNPT();

    const url = '${AppConstants.urlBaseNpt}/danh-sach-khach-hang';
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: {"query": query},
      );

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var customer = response.data["data"];
        if (customer != null) {
          return ListCustomerForDriverModel.fromJsonList(customer);
        }
        return [];
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  RxList<CustomerOfWareHomeModel> listKhachhang =
      <CustomerOfWareHomeModel>[].obs;

  RxList<CustomerOfWareHomeModel> listClient = <CustomerOfWareHomeModel>[].obs;

  // Danh sách khách hàng
  void getKhachhang() async {
    var dio = Dio();
    Response response;

    const url = '${AppConstants.urlBaseNpt}/counter-part-has-warehouses';

    try {
      response = await dio.get(
        url,
      );

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        List<dynamic> customer = response.data["data"];
        listKhachhang.value =
            customer.map((e) => CustomerOfWareHomeModel.fromJson(e)).toList();

        var data = ListCustomerOfWareHomeModel.fromJsonList(customer);
      }
    } on DioError catch (e) {
      print([e.response!.statusCode, e.response!.statusMessage]);
    }
  }

  // Danh sách kho
  Future<List<ListWareHomeModel>> getDataWareHome(query) async {
    var dio = Dio();
    Response response;
    var token = await SharePerApi().getTokenNPT();

    const url = '${AppConstants.urlBaseNpt}/selectbox';
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: {"query": query},
      );

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var warehome = response.data["kho"];
        if (warehome != null) {
          return ListWareHomeModel.fromJsonList(warehome);
        }
        return [];
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  // Danh sách loại hàng
  Future<List<ListTypeProductModel>> getDataTypeProduct(query) async {
    var dio = Dio();
    Response response;
    var token = await SharePerApi().getTokenNPT();

    const url = '${AppConstants.urlBaseNpt}/selectbox';
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: {"query": query},
      );

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var warehome = response.data["loaihang"];
        if (warehome != null) {
          return ListTypeProductModel.fromJsonList(warehome);
        }
        return [];
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  // Danh sách loại xe
  Future<List<ListTypeCarModel>> getDataTypeCar(query) async {
    var dio = Dio();
    Response response;
    var token = await SharePerApi().getTokenNPT();

    const url = '${AppConstants.urlBaseNpt}/selectbox';
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: {"query": query},
      );

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var warehome = response.data["loaixe"];
        if (warehome != null) {
          return ListTypeCarModel.fromJsonList(warehome);
        }
        return [];
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  void getSnack({required String messageText}) {
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
        messageText,
        style: const TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }
}
