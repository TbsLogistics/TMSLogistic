// ignore_for_file: unrelated_type_equality_checks

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_list_ticker_register_details/view/customer_list_ticker_register_details_screen.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/repass_driver/model/sercurity_re_pass_model.dart';

class SercurityRePassController extends GetxController {
  TextEditingController cccdController = TextEditingController();
  TextEditingController nameDriverController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode cccdForcus = FocusNode();
  FocusNode nameDriverForcus = FocusNode();
  FocusNode emailForcus = FocusNode();
  FocusNode phoneForcus = FocusNode();

  @override
  void onInit() {
    cccdForcus.requestFocus();
    super.onInit();
  }

  void rePassword({required int id}) async {
    var dio = Dio();
    Response response;
    var rePassModel = SercurityRePassModel(
      cCCD: cccdController.text,
      tenTaixe: nameDriverController.text,
      phone: phoneController.text,
      email: emailController.text,
    );
    var jsonData = rePassModel.toJson();
    var url = "${AppConstants.urlBaseNpt}/account/rest-data-driver/$id";

    try {
      response = await dio.post(
        url,
        data: jsonData,
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data["status_code"] == 83) {
          messDialog(
            messageText: data["detail"],
            onPressedSubmit: () {
              rePassword(id: 1);
            },
          );
        } else {
          Get.back();
          getSnack(messageText: data["detail"]);
          getDialogMessage(
            messageText: "${data["data"]}",
            onPressed: () {
              Get.back();
            },
          );
        }
      }
    } on DioError catch (e) {
      if (e.response == null) {
        getSnack(messageText: "Lỗi mạng ! Vui lòng thử đường mạng khác !");
      } else if (e.response!.statusMessage == 400) {
        getSnack(messageText: "Lỗi nhập dữ liệu !");
      } else if (e.response!.statusMessage == 500) {
        getSnack(messageText: "Lỗi máy chủ, vui lòng thử lại trong giây lát !");
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

  void messDialog(
      {required String messageText, required VoidCallback? onPressedSubmit}) {
    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: Colors.white,
      title: "Thông báo",
      titleStyle: const TextStyle(
        color: Colors.redAccent,
      ),
      content: Container(
        height: 75,
        // width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              messageText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
      confirm: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        height: 40,
        width: 100,
        child: TextButton(
          onPressed: onPressedSubmit,
          child: const Text(
            "Xác nhận",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
      cancel: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.orangeAccent),
          borderRadius: BorderRadius.circular(15),
        ),
        height: 40,
        width: 100,
        child: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "Trở về",
            style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
