// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_driver_of_customer/model/list_tracking_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/model/changstatustrackingIn_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/model/convert_token_data_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/model/detail_entry_vote_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/model/select_box_model.dart';

class SercurityController extends GetxController {
  TextEditingController qrController = TextEditingController();
  String scannerQrCode = "";
  RxInt idPhieuvao = 0.obs;
  RxInt numberCont = 0.obs;
  RxInt idDoor = 0.obs;
  RxInt idZone = 0.obs;
  RxString nameCustomer = "".obs;
  Rx<DetailEntryVoteModel> detailEntryVote = DetailEntryVoteModel().obs;

  RxBool isShowDetail = false.obs;
  @override
  void onInit() {
    getIdDoor();
    super.onInit();
  }

  void getIdDoor() async {
    var dio = Dio();
    var token = await SharePerApi().getTokenNPT();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppConstants.urlBaseNpt}/convert-token-data";
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        var data = ConvertTokenDataModel.fromJson(response.data);
        idDoor.value = data.nhanvien!.gateWithWareHouse![0].maCong!;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
      } else if (e.response!.statusCode == 500) {}
    }
  }

  void getSelectbox() async {
    var dio = Dio();
    var token = await SharePerApi().getTokenNPT();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppConstants.urlBaseNpt}/selectbox";
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        var data = SelectBoxModel.fromJson(response.data);
        for (var i = 0; i < data.cong!.length; i++) {
          if (data.cong![i].maCong == idDoor.value) {
            idZone.value = data.cong![i].zone!;
          }
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
      } else if (e.response!.statusCode == 500) {}
    }
  }

  void getDetailEntryVote({required int maPhieuvao}) async {
    var dio = Dio();
    var token = await SharePerApi().getTokenNPT();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url =
        "${AppConstants.urlBaseNpt}/detail-entry-vote-in?maPhieuVao=$maPhieuvao";
    isShowDetail(false);
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        if (response.data["status_code"] == 200) {
          var data = DetailEntryVoteModel.fromJson(response.data);
          detailEntryVote.value = data;
          isShowDetail(true);
        } else {
          getSnack(messageText: response.data["detail"]);
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
      } else if (e.response!.statusCode == 500) {}
    }
  }

  void putSubmitTrackingIn({
    required int maPhieuVao,
    required String soxe,
    required String capTrangthai,
    required int maTaixe,
    int? maDock,
  }) async {
    var dio = Dio();
    var token = await SharePerApi().getTokenNPT();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var dataCheck = ChangeStatusTrackingInModel(
      maPhieuvao: maPhieuVao,
      soxe: soxe,
      capTrangthai: capTrangthai,
      maTaiXe: maTaixe,
      maCong: idDoor.value,
      madock: 0,
    );
    print(dataCheck);
    var jsonData = dataCheck.toJson();

    var url = "${AppConstants.urlBaseNpt}/changstatustrackingIn";
    try {
      response = await dio.put(
        url,
        data: jsonData,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        getSnack(messageText: data["detail"]);
      }
    } on DioError catch (e) {
      print([e.response!.statusCode, e.response!.statusMessage]);
      if (e.response!.statusCode == 400) {
      } else if (e.response!.statusCode == 500) {}
    } finally {
      isShowDetail(false);
    }
  }

  void putSubmitCheckCongPhu({
    required int maPhieuVao,
  }) async {
    var dio = Dio();
    var token = await SharePerApi().getTokenNPT();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var dataCheck = ChangeStatusTrackingInModel(
      maPhieuvao: maPhieuVao,
      maCong: idDoor.value,
      madock: 0,
    );

    var jsonData = dataCheck.toJson();

    var url = "${AppConstants.urlBaseNpt}/changstatustrackingIn";
    try {
      response = await dio.put(
        url,
        data: jsonData,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        getSnack(messageText: data["detail"]);
      }
    } on DioError catch (e) {
      print([e.response!.statusCode, e.response!.statusMessage]);
      if (e.response!.statusCode == 400) {
      } else if (e.response!.statusCode == 500) {}
    } finally {
      isShowDetail(false);
    }
  }

  Future<void> scanQr({required String idCode}) async {
    try {
      scannerQrCode = await FlutterBarcodeScanner.scanBarcode(
        "#FF6666",
        "Cancel",
        false,
        ScanMode.BARCODE,
      );
      switch (idCode) {
        case "Vao":
          int maPhieuVao = int.parse(scannerQrCode);
          idPhieuvao.value = maPhieuVao;
          getDetailEntryVote(maPhieuvao: maPhieuVao);
          // getBk(bk: bkController.text);

          break;
        case "lwhF":
          // lwhFromController.text = scannerQrCode;
          break;
        case "lwhT":
          // lwhToController.text = scannerQrCode;
          break;

        default:
      }
    } on PlatformException catch (e) {
      print("Lỗi :  ${e.message}");
    }
  }

  Future<List<ListTrackingModel>> getListRegisted() async {
    var dio = Dio();
    var token = await SharePerApi().getTokenNPT();
    Response response;
    const url = "${AppConstants.urlBaseNpt}/LayDanhSachTaiXeChuaVaoCong";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        List<dynamic> data = response.data;

        return data.map((e) => ListTrackingModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  //lấy thông tin user
  Future<Map<String, dynamic>> getUser() async {
    var dio = Dio();
    var tokens = await SharePerApi().getTokenNPT();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    Response response;
    var url = "${AppConstants.urlBaseNpt}/getdetailByUsername";

    try {
      response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = response.data;
        // print(data);
        return data;
      } else {
        return response.data;
      }
    } catch (e) {
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
