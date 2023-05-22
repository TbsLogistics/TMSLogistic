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
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_car.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_product_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_warehome_model.dart';
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
  TextEditingController numberBook = TextEditingController();
  TextEditingController numberBook1 = TextEditingController();

  @override
  void onInit() {
    getKhachhang();
    super.onInit();
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

  Future<void> postRegisterCustomer({
    required int? idTaixe,
    required String maKhachHang,
    required String maDoixe,
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
    required String? idProduct,
  }) async {
    var token = await SharePerApi().getTokenNPT();
    var idTeamCar = await SharePerApi().getIdKH();

    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    const url = "${AppConstants.urlBaseNpt}/doituongkhactaophieuvaocong";
    var create = CustomerRegisterForDriverModel(
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
      trangthaihang: false,
      trangthaikhoa: false,
      cont2seal1: numberCont2Seal1,
      cont2seal2: numberCont2Seal2,
      sokien1: numberKien1 ?? 0,
      sokhoi1: numberKhoi1 ?? 0,
      soBook1: numberBook1,
      trangthaihang1: false,
      trangthaikhoa1: false,
      maloaiHang: idProduct,
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
          Get.toNamed(
            Routes.DETAILS_REGISTER_CUSTOMER,
            arguments: CustomerRegisterForDriverModel(
              maTaixe: idTaixe,
              maKhachHang: maKhachHang,
              maDoixe: maDoixe,
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
              trangthaihang: false,
              trangthaikhoa: false,
              cont2seal1: numberCont2Seal1,
              cont2seal2: numberCont2Seal2,
              sokien1: numberKien1 ?? 0,
              sokhoi1: numberKhoi1 ?? 0,
              soBook1: numberBook1,
              trangthaihang1: false,
              trangthaikhoa1: false,
              maloaiHang: idProduct,
            ),
          );
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
      print([e.response!.statusCode, e.response!.statusMessage]);
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

    const url = '${AppConstants.urlBaseNpt}/getdriverbycustomer';
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
}