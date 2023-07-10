import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_of_ware_home_model.dart';
// import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/list_customer_of_ware_home_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_customer_for_driver_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_matrongtai_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_number_cont_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_product_lock_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_car.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_cont_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_product_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_vote_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_warehome_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/register_driver_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/select_list_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status/model/driver_list_ticker_model.dart';

class DriverEditCreateRegisterController extends GetxController {
  //tikerin
  TextEditingController numberCar = TextEditingController();
  TextEditingController numberCont1 = TextEditingController();
  TextEditingController numberCont2 = TextEditingController();
  TextEditingController numberCont1Seal1 = TextEditingController();
  TextEditingController numberCont1Seal2 = TextEditingController();

  TextEditingController numberCont2Seal1 = TextEditingController();
  TextEditingController numberCont2Seal2 = TextEditingController();

  TextEditingController numberKien = TextEditingController();
  TextEditingController numberKien1 = TextEditingController();

  TextEditingController numberKhoi = TextEditingController();
  TextEditingController numberKhoi1 = TextEditingController();

  TextEditingController numberBook = TextEditingController();
  TextEditingController numberBook1 = TextEditingController();

  TextEditingController numberTan = TextEditingController();
  TextEditingController numberTan1 = TextEditingController();
  // tickerout
  TextEditingController contRa1 = TextEditingController();
  TextEditingController contRa2 = TextEditingController();
  TextEditingController contRa1seal1 = TextEditingController();
  TextEditingController contRa1seal2 = TextEditingController();
  TextEditingController contRa2seal1 = TextEditingController();
  TextEditingController contRa2seal2 = TextEditingController();

  TextEditingController dateinput = TextEditingController();

  TextEditingController searchTextEditingController = TextEditingController();

  RxList<ListCustomerForDriverModel> selectListCustomer =
      <ListCustomerForDriverModel>[].obs;

  Rx<ListCustomerForDriverModel> selectCustomer =
      ListCustomerForDriverModel().obs;
  Rx<ListCustomerForDriverModel> selectCustomerName =
      ListCustomerForDriverModel().obs;
  Rx<ListMaTrongTai> selectTrongTai = ListMaTrongTai().obs;
  Rx<ListTypeVoteModel> selectTypeVote = ListTypeVoteModel().obs;
  Rx<ListTypeContModel> selectTypeCont1 = ListTypeContModel().obs;
  Rx<ListTypeContModel> selectTypeCont2 = ListTypeContModel().obs;
  Rx<ListWareHomeModel> selectWareHome = ListWareHomeModel().obs;
  Rx<ListProductLockModel> selectHaveProduct1 = ListProductLockModel().obs;
  Rx<ListProductLockModel> selectHaveProduct2 = ListProductLockModel().obs;
  Rx<ListProductLockModel> selectProductLock1 = ListProductLockModel().obs;
  Rx<ListProductLockModel> selectProductLock2 = ListProductLockModel().obs;
  Rx<ListNumberContModel> selectNumberCont = ListNumberContModel().obs;

  Rx<ListTypeProductModel> selectTypeProduct = ListTypeProductModel().obs;
  Rx<ListTypeCarModel> selectTypeCar = ListTypeCarModel().obs;

  var isClientSelect = true.obs;
  RxBool isShowCont2 = false.obs;
  var selectListItem = <SelectedListItem>[].obs;
  String? selectItems;
  var selectedKhachhang = "";
  RxList<CustomerOfWareHomeModel> listKhachhang =
      <CustomerOfWareHomeModel>[].obs;
  RxList<CustomerOfWareHomeModel> listClient = <CustomerOfWareHomeModel>[].obs;
  Rx<DriverListTickerModel> getDriverFinishedScreen =
      DriverListTickerModel().obs;
  @override
  void onInit() async {
    super.onInit();
    getKhachhang();

    var driverFinishedScreen = Get.arguments as DriverListTickerModel;
    getDriverFinishedScreen.value = driverFinishedScreen;

    selectCustomer.value.maKhachHang =
        getDriverFinishedScreen.value.maKhachHang!.maKhachHang!;
    dateinput.text = getDriverFinishedScreen.value.giodukien!;
    selectWareHome.value.maKho = getDriverFinishedScreen.value.khoRe!.maKho;
    selectTypeCar.value.maLoaiXe =
        getDriverFinishedScreen.value.loaixe!.maLoaiXe;
    numberCar.text = getDriverFinishedScreen.value.soxe!;
    if (getDriverFinishedScreen.value.maTrongTai != null) {
      selectTrongTai.value.maTrongTai =
          getDriverFinishedScreen.value.maTrongTai!.maTrongTai;
    }

    //cont1
    numberCont1.text = getDriverFinishedScreen.value.socont1 ?? "";
    numberCont1Seal1.text = getDriverFinishedScreen.value.cont1seal1 ?? "";
    numberCont1Seal2.text = getDriverFinishedScreen.value.cont1seal2 ?? "";
    numberKien.text = getDriverFinishedScreen.value.soKien.toString();
    numberTan.text = getDriverFinishedScreen.value.soTan.toString();
    numberBook.text = getDriverFinishedScreen.value.soBook.toString();
    numberKhoi.text = getDriverFinishedScreen.value.sokhoi.toString();

    selectHaveProduct1.value.trangthai =
        getDriverFinishedScreen.value.trangthaihang ?? false;
    selectHaveProduct2.value.trangthai =
        getDriverFinishedScreen.value.trangthaihang1 ?? false;
    selectProductLock1.value.trangthai =
        getDriverFinishedScreen.value.trangthaikhoa ?? false;
    selectProductLock2.value.trangthai =
        getDriverFinishedScreen.value.trangthaikhoa1 ?? false;

    //cont2
    numberCont2.text = getDriverFinishedScreen.value.socont2 ?? "";

    numberCont2Seal1.text = getDriverFinishedScreen.value.cont2seal1 ?? "";
    numberCont2Seal2.text = getDriverFinishedScreen.value.cont2seal2 ?? "";
    numberKien1.text = getDriverFinishedScreen.value.sokien1.toString();
    numberTan1.text = getDriverFinishedScreen.value.soTan1.toString();
    numberBook1.text = getDriverFinishedScreen.value.soBook1.toString();
    numberKhoi1.text = getDriverFinishedScreen.value.sokhoi1.toString();

    //loaicont
    selectTypeCont1.value.typeContCode =
        getDriverFinishedScreen.value.loaiCont!.typeContCode;
    selectTypeCont2.value.typeContCode =
        getDriverFinishedScreen.value.loaiCont1!.typeContCode;
    if (getDriverFinishedScreen.value.maloaiHang != null) {
      selectTypeProduct.value.maloaiHang =
          getDriverFinishedScreen.value.maloaiHang!.maloaiHang;
    }

    selectCustomer.value.tenKhachhang =
        getDriverFinishedScreen.value.maKhachHang!.tenKhachhang;

    if (getDriverFinishedScreen.value.loaiCont!.typeContCode != null) {
      selectNumberCont.value.id = 1;
    } else if (getDriverFinishedScreen.value.loaiCont1!.typeContCode != null) {
      selectNumberCont.value.id = 2;
    }
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

        // var data = ListCustomerOfWareHomeModel.fromJsonList(customer);
      }
    } on DioError catch (e) {
      print([e.response!.statusCode, e.response!.statusMessage]);
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

  // Danh sách loại phieu
  Future<List<ListTypeVoteModel>> getDataTypeVote(query) async {
    // List<ListTypeVoteModel> listVote = [
    //   ListTypeVoteModel(id: 1, name: "Phiếu vào"),
    //   ListTypeVoteModel(id: 2, name: "Phiếu ra"),
    // ];
    List<Map<String, dynamic>> listVote = [
      {"id": 1, "name": "Phiếu vào"},
      {"id": 2, "name": "Phiếu ra"},
    ];

    return ListTypeVoteModel.fromJsonList(listVote);
  }

  // Danh sách so luong cont
  Future<List<ListNumberContModel>> getNumberCont(query) async {
    List<Map<String, dynamic>> listNumberCont = [
      {"id": 1, "name": "1 Cont"},
      {"id": 2, "name": "2 Cont"},
    ];

    return ListNumberContModel.fromJsonList(listNumberCont);
  }

  // Danh sách trang thai co KHOA
  Future<List<ListProductLockModel>> getDataProductTrue(query) async {
    List<Map<String, dynamic>> listVote = [
      {"id": 1, "name": "Có", "trangthai": true},
      {"id": 2, "name": "Không có", "trangthai": false},
    ];
    return ListProductLockModel.fromJsonList(listVote);
  }

  // Danh sách trang thai co hang
  Future<List<ListProductLockModel>> getDataProductLockTrue(query) async {
    List<Map<String, dynamic>> listVote = [
      {"id": 1, "name": "Khóa", "trangthai": true},
      {"id": 2, "name": "Không khóa", "trangthai": false},
    ];
    return ListProductLockModel.fromJsonList(listVote);
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

  Future<void> puttRegisterDriver({
    required String? maKhachHang,
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
    required String? loaiCont,
    required String? loaiCont1,
    required int? numberCont,
    required String? nameCustomer,
    required String? maTrongTai,
    required bool? statusHang1,
    required bool? statusHang2,
    required bool? statusKhoa1,
    required bool? statusKhoa2,
  }) async {
    var dio = Dio();
    Response response;
    var token = await SharePerApi().getTokenNPT();
    var idDriver = await SharePerApi().getIdUser();
    var idTeamCar = await SharePerApi().getIdKHforTX();

    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url =
        "${AppConstants.urlBaseNpt}/invote/update/${getDriverFinishedScreen.value.pdriverInOutWarehouseCode}";
    var create = RegisterModel(
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
      loaiCont: loaiCont,
      trangthaihang: statusHang1,
      trangthaikhoa: statusKhoa1,
      cont2seal1: numberCont2Seal1,
      cont2seal2: numberCont2Seal2,
      sokien1: numberKien1 ?? 0,
      sokhoi1: numberKhoi1 ?? 0,
      soBook1: numberBook1,
      soTan1: numberTan1 ?? 0,
      loaiCont1: loaiCont1,
      trangthaihang1: statusHang2,
      trangthaikhoa1: statusKhoa2,
      maloaiHang: typeProduct,
      maTrongTai: maTrongTai,
      typeInvote: 0,
    );

    var jsonData = create.toJson();

    try {
      response = await dio.put(
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
          // Get.toNamed(Routes.LIST_STATUS_INFINISHED_SCREEN);
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
