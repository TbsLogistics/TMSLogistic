// ignore_for_file: unused_local_variable, duplicate_ignore, non_constant_identifier_names

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/login/model/login_hrm_model.dart';
import 'package:tbs_logistics_tms/app/page/login/model/login_model.dart';
import 'package:tbs_logistics_tms/app/page/login/model/login_user_hrm_model.dart';
import 'package:tbs_logistics_tms/app/page/login/model/login_user_npt_model.dart';

class LoginController extends GetxController {
  var dio = Dio();

  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoadLogin = false.obs;

  RxBool obcureText = true.obs;
  void updateObcureText() {
    obcureText.value = !obcureText.value;
    update();
  }

  Future<void> postLoginTms(
      {required String account, required String password}) async {
    Response response;
    var login = LoginModel(
      username: account,
      password: md5.convert(utf8.encode(password)).toString(),
    );
    var jsonData = login.toJson();
    const url = "${AppConstants.urlBaseTms}/api/User/Login";

    try {
      response = await dio.post(
        url,
        data: jsonData,
      );
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var data = response.data;

        var access_token_tms = await prefs.setString(
          AppConstants.KEY_ACCESS_TOKEN_TMS,
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
        getDialog();
        Future.delayed(const Duration(seconds: 1), () {
          Get.toNamed(Routes.HOME_PAGE);
        });
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
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

  //Login with NPT
  Future<void> postLoginNpt({
    required String account,
    required String password,
  }) async {
    // ignore: prefer_typing_uninitialized_variables
    var jsonRespone;
    Response response;

    var dio = Dio();
    var user = LoginModel(
      username: account,
      password: password,
    );
    var jsonData = user.toJson();
    String url = "${AppConstants.urlBaseNpt}/login";
    try {
      response = await dio.post(
        url,
        data: jsonData,
        options: Options(
          validateStatus: (_) => true,
        ),
      );
      if (response.statusCode == AppConstants.RESPONSE_CODE_SERVER_ERROR) {
        getSnack(messageText: "Lỗi máy chủ, vui lòng thử lại sau 1 phút!");
      } else if (response.statusCode == AppConstants.RESPONSE_CODE_ERROR) {
        getSnack(messageText: "Tên đăng nhập hoặc mật khẩu không đúng");
        // print("Tên đăng nhập hoặc mật khẩu không đúng");
      } else if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        jsonRespone = response.data;

        if (response.data["status_code"] == 204) {
          Get.defaultDialog(
            title: "Thông báo",
            titleStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            middleText: response.data["detail"],
            confirmTextColor: Colors.white,
            backgroundColor: Colors.orangeAccent,
            confirm: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all(
                    const BorderSide(width: 1, color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Xác nhận",
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 16,
                  ),
                )),
            onConfirm: () {
              Get.back();
            },
          );
        } else {
          var tokens = LoginUserNptModel.fromJson(jsonRespone);
          // tokens_KH = LoginCustomerModel.fromJson(jsonData);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          Map<String, dynamic> decodedTokenNpt =
              JwtDecoder.decode(tokens.accessToken!);
          // print(decodedTokenNpt);
          // ignore: unused_local_variable
          var accessToken = await prefs.setString(
              AppConstants.KEY_ACCESS_TOKEN_NPT, "${tokens.accessToken}");
          //ignore: unused_local_variable
          var roleName = await prefs.setString(
              AppConstants.KEY_ROLE, "${tokens.data!.role}");

          var roles = tokens.data!.role;
          switch (roles) {
            case "TX":
              // ignore: unused_local_variable

              var idUser = await prefs.setString(
                  AppConstants.KEY_ID_USER, "${tokens.data!.taixe!.maTaixe}");
              var idKHforTX = await prefs.setString(
                  AppConstants.KEY_ID_KH_OF_DRIVER,
                  "${tokens.data!.taixe!.maKhachHang}");
              getDialog();
              Future.delayed(const Duration(seconds: 1), () {
                Get.toNamed(
                  Routes.HOME_PAGE,
                  arguments: tokens.data!.taixe as Taixe,
                );
              });
              break;
            case "KH":
              // ignore: unused_local_variable
              var idKH = await prefs.setString(AppConstants.KEY_ID_KH,
                  "${tokens.data!.khachHang!.maKhachHang}");
              getDialog();
              Future.delayed(const Duration(seconds: 1), () {
                Get.toNamed(Routes.HOME_PAGE);
              });
              break;

            default:
              if (kDebugMode) {
                print("Lỗi sai account");
              }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //Login HRM
  Future<void> postLoginHrm({
    required String username,
    required String password,
  }) async {
    Response response;
    var user = LoginHrmModel(
      username: username,
      password: password,
      autogen: 0,
    );
    var jsonData = user.toJson();
    String url = "${AppConstants.urlBaseHrm}/Login";
    // String url = "${AppConstants.urlBaseHrm}/user/login";

    try {
      response = await dio.post(
        url,
        data: jsonData,
        options: Options(
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        var jsonRespone = response.data;
        // ignore: unused_local_variable
        var tokens = LoginUserHrmModel.fromJson(jsonRespone);

        if (response.data["rCode"] == 1) {
          diaLogCreateAccout(username);
        } else if (response.data["rCode"] == 2) {
          passwordController.text = response.data["rData"]["password"];
        } else if (response.data["rCode"] == 0) {
          // print("Tài khoản hoặc mật khẩu không đúng !");
          Get.defaultDialog(
            barrierDismissible: false,
            title: "Thông báo",
            middleText: "Tài khoản hoặc mật khẩu không đúng !",
            confirmTextColor: Colors.orangeAccent,
            backgroundColor: Colors.white,
            onConfirm: () {
              Get.back();
            },
          );
        } else if (response.data["rCode"] == 3) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: unused_local_variable
          var accessToken = await prefs.setString(
              AppConstants.KEY_ACCESS_TOKEN_HRM,
              "${response.data["rData"]["token"]}");
          Map<String, dynamic> decodedTokenHrm =
              JwtDecoder.decode(response.data["rData"]["token"]);
          // print(decodedTokenHrm);
          getDialog();
          Future.delayed(const Duration(seconds: 1), () {
            Get.toNamed(Routes.HOME_PAGE);
          });
          accountController.text = "";
          passwordController.text = "";
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(messageText: e.response!.statusMessage.toString());
        // print(e.response!.statusMessage);
      }
    }
  }

  void createAccount({
    required String username,
  }) async {
    Response response;

    var users = LoginHrmModel(
      username: username,
      password: "",
      autogen: 1,
    );
    var jsonData = users.toJson();
    String url = "${AppConstants.urlBaseHrm}/Login";
    // String url = "${AppConstants.urlBaseHrm}/user/login";

    try {
      response = await dio.post(
        url,
        data: jsonData,
        options: Options(validateStatus: (_) => true),
      );

      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        var jsonRespone = response.data;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        // ignore: unused_local_variable
        var accessToken = await prefs.setString(
            AppConstants.KEY_ACCESS_TOKEN_HRM,
            "${response.data["rData"]["token"]}");
        Map<String, dynamic> decodedTokenHrm =
            JwtDecoder.decode(response.data["rData"]["token"]);
        print(decodedTokenHrm);
        Get.defaultDialog(
          barrierDismissible: false,
          title: "Thông báo",
          middleText: "",
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Tạo thành công :"),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Mật khẩu : ${response.data["rData"]["password"]}",
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 5,
              ),
              Text("${response.data["rMsg"]}"),
            ],
          ),
          confirmTextColor: Colors.orangeAccent,
          backgroundColor: Colors.white,
          confirm: Container(
            height: 35,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.orangeAccent,
              ),
              borderRadius: BorderRadius.circular(15),
              color: Colors.orangeAccent,
            ),
            child: TextButton(
              onPressed: () {
                Get.defaultDialog(
                  barrierDismissible: false,
                  title: "Thông báo",
                  middleText: "Bạn có muốn đổi mật khẩu !",
                  confirmTextColor: Colors.orangeAccent,
                  backgroundColor: Colors.white,
                  cancel: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.orangeAccent,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: TextButton(
                      onPressed: () {
                        // print(response.data["rData"]["token"]);
                        getDialog();
                        Future.delayed(const Duration(seconds: 1), () {
                          Get.toNamed(Routes.HOME_PAGE);
                        });
                      },
                      child: const Text(
                        "Không",
                        style: TextStyle(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                  confirm: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.orangeAccent,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.orangeAccent,
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Get.toNamed(
                        //   Routes.CHANGE_PASSWORD_PAGE,
                        //   arguments: [
                        //     username,
                        //     response.data["rData"]["password"]
                        //   ],
                        // );
                      },
                      child: const Text(
                        "Đồng ý",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Text(
                "Oke",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onConfirm: () {
            // Get.back();
          },
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  void fetchMedia({required String account, required String password}) async {
    var dio = Dio();

    RxList listLogin = [].obs;
    Response responseNpt;
    Response responseHrm;
    Response responseTms;

    var loginTms = LoginModel(
      username: account,
      password: md5.convert(utf8.encode(password)).toString(),
    );
    var jsonTms = loginTms.toJson();

    var loginNpt = LoginModel(
      username: account,
      password: password,
    );
    var jsonNpt = loginNpt.toJson();

    var loginHrm = LoginHrmModel(
      username: account,
      password: password,
      autogen: 0,
    );
    var jsonHrm = loginHrm.toJson();
    var urlNpt = "${AppConstants.urlBaseNpt}/login";

    try {
      responseNpt = await dio.post(
        urlNpt,
        data: jsonNpt,
      );

      if (responseNpt.statusCode == 200) {
        if (responseNpt.data["status_code"] == 204) {
          //++++++++++++++++++++++++++++Đăng nhập HRM ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          responseHrm = await dio.post(
            "${AppConstants.urlBaseHrm}/Login",
            data: jsonHrm,
          );
          // responseHrm = await dio.post(
          //   "${AppConstants.urlBaseHrm}/user/login",
          //   data: jsonHrm,
          // );

          if (responseHrm.statusCode == 200) {
            if (responseHrm.data["rCode"] == 1) {
              diaLogCreateAccout(account);
            } else if (responseHrm.data["rCode"] == 2) {
              passwordController.text = responseHrm.data["rData"]["password"];
            } else if (responseHrm.data["rCode"] == 3) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              // ignore: unused_local_variable
              var accessToken = await prefs.setString(
                  AppConstants.KEY_ACCESS_TOKEN_HRM,
                  "${responseHrm.data["rData"]["token"]}");
              Map<String, dynamic> decodedTokenHrm =
                  JwtDecoder.decode(responseHrm.data["rData"]["token"]);
              // print(decodedTokenHrm);
              getDialog();
              getSnack(messageText: "Đăng nhập thành công !");
              Future.delayed(const Duration(seconds: 1), () {
                Get.toNamed(Routes.HOME_PAGE);
              });
              accountController.text = "";
              passwordController.text = "";
            } else if (responseHrm.data["rCode"] == 0) {
              //+++++++++++++++++++++++++++++++++++++++++++++++++Đăng nhập của TMS ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
              responseTms = await dio.post(
                "${AppConstants.urlBaseTms}/api/User/Login",
                data: jsonTms,
              );
              if (responseTms.statusCode == 200) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var data = responseTms.data;
                // print("tokens : $data");
                var access_token_tms = await prefs.setString(
                  AppConstants.KEY_ACCESS_TOKEN_TMS,
                  data,
                );

                Map<String, dynamic> decodedToken = JwtDecoder.decode(data);
                print(decodedToken);
                // ignore: unused_local_variable
                var idTX = await prefs.setString(
                  AppConstants.KEY_ID_TX,
                  decodedToken["UserName"],
                );
                var accType = await prefs.setString(
                  AppConstants.KEY_ACCOUNT_TYPE,
                  decodedToken["AccType"],
                );
                getDialog();
                getSnack(messageText: "Đăng nhập thành công !");
                Future.delayed(const Duration(seconds: 1), () {
                  Get.toNamed(Routes.HOME_PAGE);
                });
              }
            }
          }
        }
        //+++++++++++++++++++++++++ Đăng nhập thành công của NPT +++++++++++++++++++++++++++++++++++++++++++++++++
        else {
          var tokens = LoginUserNptModel.fromJson(responseNpt.data);
          // tokens_KH = LoginCustomerModel.fromJson(jsonData);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          Map<String, dynamic> decodedTokenNpt =
              JwtDecoder.decode(tokens.accessToken!);

          // ignore: unused_local_variable
          var accessToken = await prefs.setString(
              AppConstants.KEY_ACCESS_TOKEN_NPT, "${tokens.accessToken}");
          //ignore: unused_local_variable
          var roleName = await prefs.setString(
              AppConstants.KEY_ROLE, "${tokens.data!.role}");

          var roles = tokens.data!.role;
          switch (roles) {
            case "TX":
              // ignore: unused_local_variable

              var idUser = await prefs.setString(
                  AppConstants.KEY_ID_USER, "${tokens.data!.taixe!.maTaixe}");
              var idKHforTX = await prefs.setString(
                  AppConstants.KEY_ID_KH_OF_DRIVER,
                  "${tokens.data!.taixe!.maKhachHang}");
              getDialog();
              getSnack(messageText: "Đăng nhập thành công !");
              Future.delayed(const Duration(seconds: 1), () {
                Get.toNamed(
                  Routes.HOME_PAGE,
                  arguments: tokens.data!.taixe as Taixe,
                );
              });
              break;
            case "KH":
              // ignore: unused_local_variable
              var idKH = await prefs.setString(AppConstants.KEY_ID_KH,
                  "${tokens.data!.khachHang!.maKhachHang}");
              getDialog();
              Future.delayed(const Duration(seconds: 1), () {
                Get.toNamed(Routes.HOME_PAGE);
              });
              break;
            case "NV":
              // ignore: unused_local_variable

              getDialog();
              Future.delayed(const Duration(seconds: 1), () {
                Get.toNamed(Routes.HOME_PAGE);
              });
              break;

            default:
              if (kDebugMode) {
                print("Lỗi sai account");
              }
          }
        }
      }
    } on DioError catch (e) {
      // print("Status Code : ${e.response!.statusCode}");
      if (e.response == null) {
        getSnack(messageText: "Lỗi mạng !");
      } else if (e.response!.statusCode == 400) {
        getSnack(messageText: "Tài khoản hoặc mật khẩu không đúng !");
      } else if (e.response!.statusCode == 500) {
        getSnack(messageText: "Lỗi ! Khoảng 5 phút sau đăng nhập lại !");
      }
    }

    // try {
    //   // Make the first API call NPT
    //   Response responseNpt = await dio.post(
    //     "https://tlogapi.tbslogistics.com.vn:200/login",
    //     data: jsonNpt,
    //     options: Options(
    //       validateStatus: (_) => true,
    //     ),
    //   );
    //   // Make the second API call HRM
    //   Response responseHrm = await dio
    //       .post("http://tlogapi.tbslogistics.com.vn:202/Login", data: jsonHrm);
    //   // Make the third API call TMS
    //   Response responseTms = await dio.post(
    //     "https://api.tbslogistics.com.vn/api/User/Login",
    //     data: jsonTms,
    //   );
    // } on DioError catch (e) {
    //   // Handle any errors that occur during the API calls
    //   if (e.response!.statusCode == 400) {
    //     print("Mật khẩu không đúng !");
    //   }
    // }
  }

  Future<void> fetchData(
      {required String account, required String password}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    List result = await Future.wait([
      postLoginTms(account: account, password: password),
      postLoginNpt(account: account, password: password),
      postLoginHrm(username: account, password: password),
    ]);
    // Do something with the data
  }

  diaLogCreateAccout(String username) {
    Get.defaultDialog(
      barrierDismissible: false,
      title: "Thông báo",
      middleText: "Chưa có tài khoản ! Bạn có muốn tạo tài khoản ?",
      confirmTextColor: Colors.orangeAccent,
      backgroundColor: Colors.white,
      buttonColor: Colors.white,
      cancel: Container(
        height: 35,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.orangeAccent,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton(
          child: const Text(
            "Không",
            style: TextStyle(color: Colors.orangeAccent),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      confirm: Container(
        height: 35,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.orangeAccent,
          ),
          borderRadius: BorderRadius.circular(15),
          color: Colors.orangeAccent,
        ),
        child: TextButton(
          child: const Text(
            "Có",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            createAccount(
              username: username,
            );
            Get.back();
          },
        ),
      ),
    );
  }

  void getDialog() {
    Get.defaultDialog(
      title: "Loading",
      titleStyle: const TextStyle(
        color: Colors.orangeAccent,
      ),
      confirm: CircularProgressIndicator(
        color: Colors.orangeAccent.withOpacity(0.7),
      ),
      middleText: "",
      textConfirm: null,
      confirmTextColor: Colors.orangeAccent,
      backgroundColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
      buttonColor: Colors.orangeAccent.withOpacity(0.4),
    );
  }

  void getSnack({required String messageText}) {
    Get.snackbar(
      "",
      "",
      backgroundColor: Colors.white,
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
