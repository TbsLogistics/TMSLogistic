import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbs_logistics_tms/app/login/model/login_model.dart';
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/routes/pages.dart';

class LoginController extends GetxController {
  late Response response;
  var dio = Dio();

  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoadLogin = false.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  RxBool obcureText = true.obs;
  void updateObcureText() {
    obcureText.value = !obcureText.value;
    update();
  }

  void postLogin({required String account, required String password}) async {
    var login = LoginModel(
      username: account,
      password: password,
    );
    var jsonData = login.toJson();
    const url = "${AppConstants.urlBase}/api/User/Login";

    try {
      response = await dio.post(
        url,
        data: jsonData,
      );
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var data = response.data;

        var access_token = await prefs.setString(
          AppConstants.KEY_ACCESS_TOKEN,
          data,
        );
        Map<String, dynamic> decodedToken = JwtDecoder.decode(data);

        // ignore: unused_local_variable
        var idTX = await prefs.setString(
          AppConstants.KEY_ID_TX,
          decodedToken["UserName"],
        );

        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: const Text(
            "Đăng nhập thành công !",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          snackPosition: SnackPosition.TOP,
        );
        Get.toNamed(Routes.TMS_PAGE);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        // print(e.response!.statusCode);

        Get.snackbar(
          "Thông báo",
          "Nhập thiếu tài khoản hoặc mật khẩu !",
          backgroundColor: Colors.white,
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: Text(
            "${e.response!.data} !",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
      } else if (e.response!.statusCode == 500) {
        Get.snackbar(
          "Thông báo",
          "Nhập thiếu tài khoản hoặc mật khẩu !",
          backgroundColor: Colors.white,
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: const Text(
            "Lỗi máy chủ vui lòng xem lại mạng !",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        );
      }
    } finally {
      isLoadLogin(true);
    }
  }
}
