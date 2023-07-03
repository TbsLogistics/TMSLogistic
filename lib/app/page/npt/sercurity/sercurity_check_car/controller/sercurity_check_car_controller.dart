// ignore_for_file: unused_local_variable
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_car.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_cont_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/model/detail_entry_vote_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/sercurity_check_car/model/register_of_sercurity_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/sercurity_check_car/model/scan_model.dart';

class SercurityCheckCarController extends GetxController {
  TextEditingController qrController = TextEditingController();
  String scannerQrCode = "";
  RxString idPhieuvao = "".obs;
  RxInt numberCont = 0.obs;
  RxInt idDoor = 0.obs;
  RxInt idZone = 0.obs;
  RxString nameCustomer = "".obs;
  RxBool isShowCont1 = true.obs;
  RxBool isShowCont2 = false.obs;
  RxBool isShowCont2Local = false.obs;
  RxInt numberSelectCont = 0.obs;
  RxBool isShowCar = false.obs;

  FocusNode cccdFocusNode = FocusNode();

  Rx<ListTypeCarModel> selectTypeCar = ListTypeCarModel().obs;
  Rx<ListTypeContModel> selectTypeCont1 = ListTypeContModel().obs;
  Rx<ListTypeContModel> selectTypeCont2 = ListTypeContModel().obs;

  Rx<DetailEntryVoteModel> detailEntryVote = DetailEntryVoteModel().obs;
  TextEditingController zoneController = TextEditingController();
  TextEditingController doorController = TextEditingController();
  TextEditingController warehomeController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController nameDriverController = TextEditingController();
  TextEditingController cccdController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController typecarController = TextEditingController();
  TextEditingController numberCarController = TextEditingController();

  TextEditingController cont1Controller = TextEditingController();
  TextEditingController cont2Controller = TextEditingController();
  TextEditingController seal11Controller = TextEditingController();
  TextEditingController seal12Controller = TextEditingController();
  TextEditingController seal21Controller = TextEditingController();
  TextEditingController seal22Controller = TextEditingController();
  TextEditingController kienController = TextEditingController();
  TextEditingController kien1Controller = TextEditingController();
  TextEditingController bkController = TextEditingController();
  TextEditingController bk1Controller = TextEditingController();
  TextEditingController tanController = TextEditingController();
  TextEditingController tan1Controller = TextEditingController();
  TextEditingController CBMController = TextEditingController();
  TextEditingController CBM1Controller = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void onSubmitField2() {
    cccdFocusNode.requestFocus();
  }

  void putInOut({required int typeInvote}) async {
    var dio = Dio();
    var token = await SharePerApi().getTokenNPT();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url =
        "${AppConstants.urlBaseNpt}/scan/result-in-out/${typeInvote}/${detailEntryVote.value.pdriverInOutWarehouseCode}";
    var putData = RegisterOfSercurityModel(
      maTaixe: detailEntryVote.value.maTaixe!.maTaixe,
      maKhachHang: detailEntryVote.value.maKhachHang!.maKhachHang,
      kho: detailEntryVote.value.khoRe!.maKho,
      note: "",
      loaixe: selectTypeCar.value.maLoaiXe,
      soxe: detailEntryVote.value.soxe,
      soReMooc: "",
      socont1: cont1Controller.text,
      socont2: cont2Controller.text,
      cont1seal1: seal11Controller.text,
      cont1seal2: seal12Controller.text,
      loaiCont: selectTypeCont1.value.typeContCode,
      trangthaihang: false,
      trangthaikhoa: false,
      cont2seal1: seal21Controller.text,
      cont2seal2: seal22Controller.text,
      loaiCont1: selectTypeCont2.value.typeContCode,
      trangthaihang1: false,
      trangthaikhoa1: false,
    );
    var jsonData = putData.toJson();

    try {
      response = await dio.put(
        url,
        data: jsonData,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        print("data : $data");
        getSnack(
          messageText: data["detail"],
        );

        zoneController.text = "";
        doorController.text = "";
        warehomeController.text = "";
        customerController.text = "";
        nameDriverController.text = "";
        cccdController.text = "";
        phoneController.text = "";
        typecarController.text = "";
        numberCarController.text = "";
        cont1Controller.text = "";
        seal11Controller.text = "";
        seal12Controller.text = "";
        bkController.text = "";
        CBMController.text = "";
        kienController.text = "";
        tanController.text = "";
        cont2Controller.text = "";
        seal21Controller.text = "";
        seal22Controller.text = "";
        bk1Controller.text = "";
        CBM1Controller.text = "";
        kien1Controller.text = "";
        tan1Controller.text = "";
        selectTypeCar.value.tenLoaiXe = null;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(messageText: "Lỗi");
      } else if (e.response!.statusCode == 500) {
        getSnack(messageText: "Lỗi sever !");
      }
    }
  }

  void getDetailEntryVote({required String maPhieuvao, String? cccd}) async {
    var dio = Dio();
    var token = await SharePerApi().getTokenNPT();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var result = ScanModel(
      cCCD: cccd,
      driverInOutWarehouseCode: maPhieuvao,
    );
    var jsonData = result.toJson();

    var url = "${AppConstants.urlBaseNpt}/scan/checkCCCDandInvoteID";

    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonData,
      );

      if (response.statusCode == 200) {
        if (response.data["status_code"] == 204) {
          getSnack(messageText: response.data["detail"]);
        } else {
          getSnack(messageText: response.data["detail"]);
          var data = DetailEntryVoteModel.fromJson(response.data["data"]);
          print("tenloaijxe: ${selectTypeCar.value.tenLoaiXe}");
          detailEntryVote.value = data;

          customerController.text =
              detailEntryVote.value.maKhachHang!.tenKhachhang!;
          nameDriverController.text = detailEntryVote.value.maTaixe!.tenTaixe!;
          cccdController.text = detailEntryVote.value.maTaixe!.cCCD!;
          phoneController.text = detailEntryVote.value.maTaixe!.phone!;
          selectTypeCar.value.tenLoaiXe =
              detailEntryVote.value.loaixe!.tenLoaiXe!;
          print("tenloaijxe: ${selectTypeCar.value.tenLoaiXe}");
          selectTypeCar.value.maLoaiXe = detailEntryVote.value.loaixe!.maLoaiXe;

          numberCarController.text = detailEntryVote.value.soxe!;

          //cont1
          cont1Controller.text = detailEntryVote.value.socont1 ?? "";
          seal11Controller.text = detailEntryVote.value.cont1seal1 ?? "";
          seal12Controller.text = detailEntryVote.value.cont1seal2 ?? "";
          kienController.text = detailEntryVote.value.soKien.toString();
          tanController.text = detailEntryVote.value.soTan.toString();
          bkController.text = detailEntryVote.value.soBook.toString();
          CBMController.text = detailEntryVote.value.sokhoi.toString();

          //cont2
          cont2Controller.text = detailEntryVote.value.socont2 ?? "";
          if (cont2Controller.text != "") {
            isShowCont2(true);
            isShowCont2Local(true);
          }
          seal21Controller.text = detailEntryVote.value.cont2seal1 ?? "";
          seal22Controller.text = detailEntryVote.value.cont2seal2 ?? "";
          kien1Controller.text = detailEntryVote.value.sokien1.toString();
          tan1Controller.text = detailEntryVote.value.soTan1.toString();
          bk1Controller.text = detailEntryVote.value.soBook1.toString();
          CBM1Controller.text = detailEntryVote.value.sokhoi1.toString();
          if (selectTypeCar.value.maLoaiXe == "con") {
            isShowCar(false);
            isShowCont1(true);
            if (detailEntryVote.value.loaiCont1!.typeContCode != null) {
              isShowCont2(true);
              isShowCont2Local(true);
            }
          } else {
            isShowCar(true);
            isShowCont1(false);
            isShowCont2(false);
            isShowCont2Local(false);
          }
          update();
        }
      }
    } on DioError catch (e) {
      print(e.response!.statusCode);
      if (e.response!.statusCode == 400) {
      } else if (e.response!.statusCode == 500) {}
    }
  }

  void updateTypeCar(ListTypeCarModel? data) {
    selectTypeCar.value.maLoaiXe = data!.maLoaiXe;

    if (selectTypeCar.value.maLoaiXe == "con") {
      numberSelectCont.value = 1;
      isShowCar.value = false;
      isShowCont1.value = true;
      isShowCont2.value = false;
      isShowCont2Local.value = false;
    } else {
      numberSelectCont.value = 0;
      isShowCar.value = true;
      isShowCont1.value = false;
      isShowCont2.value = false;
      isShowCont2Local.value = false;
    }
    update();
    print(selectTypeCar.value.maLoaiXe);
    print([isShowCar.value, isShowCont2.value, isShowCont2Local.value]);
  }

  void updateShowCont2() {
    isShowCont2Local.value = !isShowCont2Local.value;
    isShowCont2.value = !isShowCont2.value;
    if (isShowCont2Local.value == false || isShowCont2.value == false) {
      selectTypeCont2.value.typeContCode = null;
      if (selectTypeCont1.value.typeContCode != null) {
        selectTypeCont1.value.typeContCode =
            detailEntryVote.value.loaiCont!.typeContCode;
      }
    }
    update();
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
          var maPhieuVao = scannerQrCode;
          idPhieuvao.value = maPhieuVao;
          getDetailEntryVote(maPhieuvao: maPhieuVao);
          onSubmitField2();
          break;
        case "CCCD":
          // lwhFromController.text = scannerQrCode;
          getCheckCCCD(CCCD: scannerQrCode);
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

  void getCheckCCCD({required String CCCD}) async {
    var dio = Dio();
    var token = await SharePerApi().getTokenNPT();
    Response response;

    var result = ScanModel(
      cCCD: CCCD,
      driverInOutWarehouseCode: detailEntryVote.value.pdriverInOutWarehouseCode,
    );
    var jsonData = result.toJson();
    var url = "${AppConstants.urlBaseNpt}/scan/checkCCCDandInvoteID";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonData,
      );

      if (response.statusCode == 200) {
        var data = response.data;

        if (data["status_code"] == 204) {
          getSnack(messageText: data["detail"]);
        } else if (data["status_code"] == 200) {
          getSnack(messageText: data["detail"]);
          if (detailEntryVote.value.pdriverInOutWarehouseCode == null) {
            getDialogMessage(
              "Thông tin tài xế",
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(children: [Text("Tên tài xế : ")]),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                            children: [Text(data["data"]["tenTaixe"] ?? "")]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(children: [Text("CCCD : ")]),
                      ),
                      Expanded(
                        flex: 3,
                        child:
                            Row(children: [Text(data["data"]["CCCD"] ?? "")]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(children: [Text("Email : ")]),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(children: [
                          Expanded(child: Text(data["data"]["email"] ?? ""))
                        ]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(children: [Text("Số điện thoại : ")]),
                      ),
                      Expanded(
                        flex: 3,
                        child:
                            Row(children: [Text(data["data"]["phone"] ?? "")]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(children: [Text("Địa chỉ : ")]),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                data["data"]["diaChi"] ?? "",
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            getDialogMessage(
              "Thông tin tài xế",
              Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Text(
                              "Trạng thái : ",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Text(
                              data["detail"] ?? "",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Row(children: [Text("Tên tài xế : ")]),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(children: [
                          Text(data["data"]["taixe"]["tenTaixe"] ?? "")
                        ]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(children: [Text("CCCD : ")]),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(children: [
                          Text(data["data"]["taixe"]["CCCD"] ?? "")
                        ]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Row(children: [Text("Email : ")]),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(children: [
                          Expanded(
                              child: Text(data["data"]["taixe"]["email"] ?? ""))
                        ]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(children: [Text("Số điện thoại : ")]),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(children: [
                          Text(data["data"]["taixe"]["phone"] ?? "")
                        ]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(children: [Text("Địa chỉ : ")]),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                data["data"]["taixe"]["diaChi"] ?? "",
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(messageText: "Lỗi");
      } else if (e.response!.statusCode == 500) {
        getSnack(messageText: "Lỗi sever");
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

  void getDialogMessage(String messageText, Widget child) {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "Thông báo",
      titleStyle: const TextStyle(
          color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
      content: child,
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

  @override
  void dispose() {
    zoneController.dispose();
    doorController.dispose();
    warehomeController.dispose();
    customerController.dispose();
    nameDriverController.dispose();
    cccdController.dispose();
    phoneController.dispose();
    typecarController.dispose();
    numberCarController.dispose();
    cont1Controller.dispose();
    seal11Controller.dispose();
    seal12Controller.dispose();
    bkController.dispose();
    CBMController.dispose();
    kienController.dispose();
    tanController.dispose();
    cont2Controller.dispose();
    seal21Controller.dispose();
    seal22Controller.dispose();
    bk1Controller.dispose();
    CBM1Controller.dispose();
    kien1Controller.dispose();
    tan1Controller.dispose();
    super.dispose();
  }
}
