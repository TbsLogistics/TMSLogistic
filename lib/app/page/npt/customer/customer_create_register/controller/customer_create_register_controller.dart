// ignore_for_file: unused_catch_clause, unused_local_variable, avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_of_ware_home_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_register_for_driver_model.dart';

import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/list_customer_of_ware_home_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/list_driver_for_customer_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_customer_for_driver_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_matrongtai_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_number_cont_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_car.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_cont_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_product_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_warehome_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status/model/driver_list_ticker_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status_details/model/list_driver_by_customer_model.dart';

class CustomerRegisterController extends GetxController {
  var dio = Dio();
  late Response response;

  Rx<ListCustomerForDriverModel> selectCustomer =
      ListCustomerForDriverModel().obs;

  Rx<ListDriverForCustomerModel> selectDriver =
      ListDriverForCustomerModel().obs;

  Rx<ListWareHomeModel> selectWareHome = ListWareHomeModel().obs;

  Rx<ListTypeProductModel> selectTypeProduct = ListTypeProductModel().obs;

  Rx<ListTypeCarModel> selectTypeCar = ListTypeCarModel().obs;

  Rx<ListTypeContModel> selectTypeCont1 = ListTypeContModel().obs;

  Rx<ListTypeContModel> selectTypeCont2 = ListTypeContModel().obs;

  Rx<ListNumberContModel> selectNumberCont = ListNumberContModel().obs;

  Rx<ListMaTrongTai> selectTrongTai = ListMaTrongTai().obs;
  String? selectItems;

  TextEditingController numberCar = TextEditingController();
  TextEditingController numberCont1 = TextEditingController();
  TextEditingController numberCont2 = TextEditingController();

  TextEditingController numberCont1Seal1 = TextEditingController();
  TextEditingController numberCont1Seal2 = TextEditingController();
  TextEditingController numberCont1Seal3 = TextEditingController();

  TextEditingController numberCont2Seal1 = TextEditingController();
  TextEditingController numberCont2Seal2 = TextEditingController();
  TextEditingController numberCont2Seal3 = TextEditingController();

  TextEditingController numberKien = TextEditingController(text: "0");
  TextEditingController numberKien1 = TextEditingController(text: "0");

  TextEditingController numberKhoi = TextEditingController(text: "0");
  TextEditingController numberKhoi1 = TextEditingController(text: "0");

  TextEditingController numberTan = TextEditingController(text: "0");
  TextEditingController numberTan1 = TextEditingController(text: "0");

  TextEditingController numberBook = TextEditingController();
  TextEditingController numberBook1 = TextEditingController();

  TextEditingController dateinput = TextEditingController(text: "");

  RxBool isShowCont2 = false.obs;
  @override
  void onInit() {
    getKhachhang();
    super.onInit();
  }

  void changeHideShowCont2() {
    isShowCont2.value = !isShowCont2.value;
    if (isShowCont2.value == false) {
      selectTypeCont2.value.typeContCode = null;
    }
    print(isShowCont2.value);
  }

  Future<List<CustomerOfWareHomeModel>> getCusomter(String? maKho) async {
    listClient.value = [];
    for (var i = 0; i < listKhachhang.length; i++) {
      if (listKhachhang[i].maKho == maKho) {
        var items = listKhachhang[i];

        listClient.add(items);
      }
    }
    if (listClient.isEmpty) {
      listClient.value = [];
    }

    return listClient;
  }

  // Danh sách loại cont
  Future<List<ListTypeContModel>> getDataTypeCont(query) async {
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
        var loaiCont = response.data["loaiCont"];
        if (loaiCont != null) {
          return ListTypeContModel.fromJsonList(loaiCont);
        }
        return [];
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> postRegisterCustomer({
    required int? idTaixe,
    required String maKhachHang,
    required String? time,
    required String? idKho,
    required String? idCar,
    required String? numberCar,
    required String? numberCont1,
    required String? numberCont2,
    required String? numberCont1Seal1,
    required String? numberCont1Seal2,
    required String? numberCont2Seal1,
    required String? numberCont2Seal2,
    required double? numberKien,
    required double? numberKien1,
    required double? numberKhoi,
    required double? numberKhoi1,
    required String? numberBook,
    required String? numberBook1,
    required double? numberTan,
    required double? numberTan1,
    required String? typeCont,
    required String? typeCont1,
    required String? idProduct,
    required int? numberCont,
    required String? nameCustomer,
    required String? maTrongtai,
  }) async {
    var token = await SharePerApi().getTokenNPT();
    var idTeamCar = await SharePerApi().getIdKH();

    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    const url = "${AppConstants.urlBaseNpt}/invote/create";
    var create = RegisterModel(
      maTaixe: idTaixe,
      maKhachHang: maKhachHang,
      maDoixe: idTeamCar,
      giodukien: time,
      kho: idKho,
      loaixe: idCar,
      soxe: numberCar,
      socont1: typeCont == "null" ? null : numberCont1,
      socont2: typeCont1 == "null" ? null : numberCont2,
      cont1seal1: typeCont == "null" ? null : numberCont1Seal1,
      cont1seal2: typeCont == "null" ? null : numberCont1Seal2,
      soKien: numberKien ?? 0,
      sokhoi: numberKhoi ?? 0,
      soBook: typeCont == "null" ? null : numberBook,
      soTan: numberTan ?? 0,
      loaiCont: typeCont == "null" ? null : typeCont,
      trangthaihang: false,
      trangthaikhoa: false,
      cont2seal1: typeCont1 == "null" ? null : numberCont2Seal1,
      cont2seal2: typeCont1 == "null" ? null : numberCont2Seal2,
      sokien1: numberKien1 ?? 0,
      sokhoi1: numberKhoi1 ?? 0,
      soTan1: numberTan1 ?? 0,
      loaiCont1: typeCont1 == "null" ? null : typeCont1,
      soBook1: typeCont1 == "null" ? null : numberBook1,
      trangthaihang1: false,
      trangthaikhoa1: false,
      maloaiHang: idProduct,
      typeInvote: 0,
      maTrongTai: maTrongtai,
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

        if (data["status_code"] == 204) {
          Get.defaultDialog(
            title: "Thông báo",
            titleStyle: const TextStyle(
              color: Colors.red,
            ),
            content: Column(
              children: [
                Center(
                  child: Text(
                    "${data["detail"]}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Quay lại"),
            ),
          );
        } else {
          getSnack(messageText: data["detail"]);
          Get.toNamed(Routes.DETAILS_REGISTER_CUSTOMER, arguments: [
            RegisterModel(
              maTaixe: idTaixe,
              maKhachHang: maKhachHang,
              maDoixe: idTeamCar,
              giodukien: time,
              kho: idKho,
              loaixe: idCar,
              soxe: numberCar,
              socont1: numberCont1,
              socont2: numberCont2,
              cont1seal1: numberCont1Seal1,
              cont1seal2: numberCont1Seal2,
              soKien: numberKien ?? 0,
              sokhoi: numberKhoi ?? 0,
              soBook: numberBook,
              soTan: numberTan ?? 0,
              loaiCont: typeCont,
              trangthaihang: false,
              trangthaikhoa: false,
              cont2seal1: numberCont2Seal1,
              cont2seal2: numberCont2Seal2,
              sokien1: numberKien1 ?? 0,
              sokhoi1: numberKhoi1 ?? 0,
              soBook1: numberBook1,
              soTan1: numberTan1 ?? 0,
              loaiCont1: typeCont1,
              trangthaihang1: false,
              trangthaikhoa1: false,
              maloaiHang: idProduct,
            ),
            data["data"]["code"],
            numberCont,
            nameCustomer,
          ]);
        }
      }
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  Future<List<ListCustomerOfWareHomeModel>> getDataCustomer(query) async {
    var dio = Dio();
    Response response;
    const url = '${AppConstants.urlBaseNpt}/counter-part-has-warehouses';
    try {
      response = await dio.get(url);
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var customer = response.data["data"];
        if (customer != null) {
          return ListCustomerOfWareHomeModel.fromJsonList(customer);
        }
        return [];
      } else {
        return [];
      }
    } on DioError catch (e) {
      return [];
    }
  }

  RxList<CustomerOfWareHomeModel> listKhachhang =
      <CustomerOfWareHomeModel>[].obs;

  RxList<CustomerOfWareHomeModel> listClient = <CustomerOfWareHomeModel>[].obs;

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

  Future<List<ListDriverByCustomerModel>> getDataDriver(query) async {
    var dio = Dio();
    Response response;
    var token = await SharePerApi().getTokenNPT();

    const url = '${AppConstants.urlBaseNpt}/LayDanhSachCuaTaiXe';
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
        var driver = response.data;
        if (driver != null) {
          return ListDriverByCustomerModel.fromJsonList(driver);
        }
        return [];
      } else {
        return [];
      }
    } on DioError catch (e) {
      return [];
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

  // Danh sách trong tai
  Future<List<ListMaTrongTai>> getTrongTai(query) async {
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
        var warehome = response.data["trongTai"];
        if (warehome != null) {
          return ListMaTrongTai.fromJsonList(warehome);
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

  // Danh sách so luong cont
  Future<List<ListNumberContModel>> getNumberCont(query) async {
    List<Map<String, dynamic>> listNumberCont = [
      {"id": 1, "name": "1 Cont"},
      {"id": 2, "name": "2 Cont"},
    ];

    return ListNumberContModel.fromJsonList(listNumberCont);
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
          fontSize: 16,
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
