import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself/model/user_hrm_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_create_sent/model/list_of_subordinates_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_create_sent/model/list_of_type_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_create_sent/model/of_subordinates_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_create_sent/model/register_model.dart';

class LetterMyselfCreateSentController extends GetxController {
  TextEditingController timeController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  Rx<UserHrmModel> userName = UserHrmModel().obs;

  RxString idUser = "".obs;
  // Rx<ListOfSubordinatesModel> selectMember = ListOfSubordinatesModel().obs;
  RxBool isLoadUser = false.obs;

  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;
  var dio = Dio();

  var numberDayFree = "".obs;
  var dayFreeError = RxnString(null);

  var selectedLoaiphep = "";
  // Khai báo mã nhân viên
  var selectMember = 0.obs;
  // Khai báo loại phép
  var selectedValue = 0.obs;
  var nameType = "".obs;

  RxList listOffType = [].obs;
  GlobalKey<FormState> formKeyCreateLetter = GlobalKey<FormState>();
  var loaiPhep = "";

  RxBool isload = false.obs;
  RxBool isHide = false.obs;
  RxBool isUserInfo = false.obs;

  @override
  void onInit() {
    formKeyCreateLetter;
    getInfo();
    getMember();
    super.onInit();
  }

  final List<Tab> tabCreate = <Tab>[
    const Tab(
      text: 'Tạo/Xem',
    ),
    const Tab(
      text: 'Duyệt',
    ),
  ];

  //Chọn ngày

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.white,
            colorScheme: const ColorScheme.light(
              primary: Colors.orangeAccent,
              onPrimary: Colors.white,
              onSurface: Colors.blueAccent,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      timeController.text =
          DateFormat('yyyy-MM-dd').format(selectedDate.value).toString();
      update();
    }
  }

  //Lấy thông tin user

  void getInfo() async {
    var tokens = await SharePerApi().getTokenHRM();

    Map<String, dynamic> decodedTokenHrm = JwtDecoder.decode(tokens);

    var dio = Dio();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    const url = "${AppConstants.urlBaseHrm}/getEmpInfo";
    isUserInfo(false);
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        var data = UserHrmModel.fromJson(response.data["rData"]);

        userName.value = data;
        idUser.value = decodedTokenHrm["username"];
      }
    } catch (e) {
      rethrow;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isUserInfo(true);
      });
    }
  }

  RxList<OfSubordinatesModel> listMember = <OfSubordinatesModel>[].obs;

  RxList<OfSubordinatesModel> listMemberClient = <OfSubordinatesModel>[].obs;
  // Danh sách khách hàng
  void getMember() async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenHRM();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };

    const url = '${AppConstants.urlBaseHrm}/list-of-subordinates';

    try {
      response = await dio.get(url, options: Options(headers: headers));

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        if (response.data["rCode"] == 1) {
          List<dynamic> member = response.data["rData"];

          listMember.value =
              member.map((e) => OfSubordinatesModel.fromJson(e)).toList();
        } else {
          getSnack(messageText: response.data["rMsg"]);
        }
      }
    } on DioError catch (e) {
      print([e.response!.statusCode, e.response!.statusMessage]);
    }
  }

  Future<List<OfSubordinatesModel>> getDataCustomer(String? maKho) async {
    listMemberClient.value = [];
    var items = userName.value;

    var userLeader = OfSubordinatesModel(
      empID: items.empID,
      firstName: items.firstName,
      lastName: items.lastName,
      comeDate: items.comeDate,
      zoneID: items.zoneID,
      deptID: items.deptID,
      posID: items.jobPosID,
      sex: 1,
      tel: null,
      status: 1,
      directlyMng: null,
      iDWorkingTime: null,
      name: items.jobpositionName,
      jPLevel: items.jPLevelID,
    );

    listMemberClient.add(userLeader);

    for (var i = 0; i < listMember.length; i++) {
      var items = listMember.value[i];
      listMemberClient.add(items);
    }

    print("listMemberClient : ${listMemberClient.length}");

    return listMemberClient;
  }

  // Đăng ký
  void postRegister({
    required int emplid,
    required int type,
    required String reason,
    required String startdate,
    required double period,
    required String address,
    required int command,
  }) async {
    // var tokens = AppConstants.tokens;
    var tokens = await SharePerApi().getTokenHRM();

    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var register = RegisterModel(
      emplid: emplid,
      type: type,
      reason: reason,
      startdate: startdate,
      period: period,
      address: address,
      command: command,
    );
    var jsonData = register.toJson();
    const url = "${AppConstants.urlBaseHrm}/day-off-letter";
    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonData,
      );

      if (response.statusCode == 200) {
        var data = response.data;

        if (data["rCode"] == 0) {
          // print("Lỗi");
          Get.snackbar(
            "Thông báo",
            "${data["rMsg"]} !",
            titleText: const Text(
              "Thông báo",
              style: TextStyle(color: Colors.red),
            ),
            messageText: Text(
              "${data["rMsg"]} !",
              style: const TextStyle(color: Colors.green),
            ),
          );
        } else if (data["rCode"] == 1) {
          dayController.text = "";
          reasonController.text = "";
          addressController.text = "";
          Get.back(result: true);
          Get.snackbar(
            "Thông báo",
            "${data["rMsg"]} !",
            titleText: const Text(
              "Thông báo",
              style: TextStyle(color: Colors.red),
            ),
            messageText: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${data["rMsg"]}!",
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                data["rError"] != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "${data["rError"]["startdate"]}!",
                              textAlign: TextAlign.left,
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(height: 5),
              ],
            ),
            backgroundColor: Colors.white,
          );
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  //Lấy danh sách loại phép
  Future<List<ListOffTypeModel>> getTypeOff(query) async {
    // var tokens = AppConstants.tokens;
    var tokens = SharePerApi().getTokenHRM();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    const url = "${AppConstants.urlBaseHrm}/dayOffType";
    try {
      response = await dio.get(url,
          options: Options(headers: headers),
          queryParameters: {"query": query});
      if (response.statusCode == 200) {
        List<dynamic> data = response.data["rData"];
        // ignore: unused_local_variable
        var result =
            data.map((e) => ListOffTypeModel.fromJson(e).note).toList();

        listOffType.value = data;
        update();
        return data.map((e) => ListOffTypeModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  // // Danh sách nhân viên phụ thuộc
  // Future<List<ListOfSubordinatesModel>> getDataCustomer(query) async {
  //   Response response;
  //   var token = await SharePerApi().getTokenHRM();

  //   const url = '${AppConstants.urlBaseHrm}/list-of-subordinates';
  //   Map<String, dynamic> headers = {
  //     HttpHeaders.authorizationHeader: "Bearer $token"
  //   };
  //   try {
  //     response = await dio.get(
  //       url,
  //       options: Options(headers: headers),
  //       queryParameters: {"query": query},
  //     );

  //     if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
  //       var member = response.data["rData"];

  //       if (member != null) {
  //         return ListOfSubordinatesModel.fromJsonList(member);
  //       }
  //       return [];
  //     } else {
  //       return [];
  //     }
  //   } catch (error) {
  //     rethrow;
  //   }
  // }
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
