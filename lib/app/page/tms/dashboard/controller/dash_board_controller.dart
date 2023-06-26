import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/tms/dashboard/dashboard_page.dart';
import 'package:tbs_logistics_tms/app/page/tms/dashboard/model/chart_line_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/dashboard/model/chart_line_total_model.dart';
import 'package:tbs_logistics_tms/app/page/tms/dashboard/model/table_data_model.dart';

class DashBoardTmsController extends GetxController {
  List<ChartData> listChartData = [];
  RxList<ChartData> listChart = <ChartData>[].obs;
  List<int> listNumber = [];
  RxBool isLoadChart = false.obs;

  List<ChartTotalData> listChartTotalData = [];
  RxList<ChartTotalData> listChartTotal = <ChartTotalData>[].obs;
  List<int> listTotalNumber = [];
  RxBool isLoadChartTotal = false.obs;

  List<CustomerReports> listTableData = [];
  RxList<CustomerReports> listTable = <CustomerReports>[].obs;
  RxList<CustomerReports> listTableTotal = <CustomerReports>[].obs;
  // List<int> listTotalNumber = [];
  TextEditingController dateinput = TextEditingController(text: "");

  var day = DateFormat("dd");
  DateTime dayNow = DateTime.now();
  DateTime dateTime = DateTime.now();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void onInit() {
    getData1();
    getData2();
    getData3();
    super.onInit();
  }

  void getData1({String? datetime}) async {
    print("datetime1 : $datetime");
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    if (datetime == null) {
      datetime = DateFormat('yyyy-MM-dd').format(dayNow);
    }
    print("datetime2 : $datetime");

    var url =
        "https://api.tbslogistics.com.vn/api/Report/GetReportTransportByMonth?dateTime=${datetime}";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    isLoadChart(false);
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        var data = ChartModel.fromJson(response.data);
        listChartData = [];
        for (var i = 0; i < data.dataTotal![0].dataInt!.length; i++) {
          for (var j = 0; j < data.dataTotal![1].dataInt!.length; j++) {
            var items1 = data.dataTotal![0].dataInt![i].date;
            var dayItems1 = day.format(DateTime.parse(items1.toString()));
            // print(dayItems1);
            var items2 = data.dataTotal![1].dataInt![j].date;
            var dayItems2 = day.format(DateTime.parse(items2.toString()));
            // print(dayItems2);
            if (dayItems1 == dayItems2) {
              listChartData.add(
                ChartData(
                  dayItems1,
                  data.dataTotal![0].dataInt![i].count!,
                  data.dataTotal![1].dataInt![j].count!,
                ),
              );
            }
          }
        }
        listNumber = [];
        for (var i = 0; i < listChartData.length; i++) {
          var items = int.parse(listChartData[i].month);
          listNumber.add(items);
        }

        listNumber.sort();
        listChart.value = [];
        for (var i = 0; i < listNumber.length; i++) {
          for (var j = 0; j < listChartData.length; j++) {
            if (i + 1 == int.parse(listChartData[j].month)) {
              var items = listChartData[j];
              listChart.add(items);
            }
          }
        }

        update();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
      } else if (e.response!.statusCode == 401) {
        getSnack(message: "message");
      } else if (e.response!.statusCode == 500) {}
    } finally {
      isLoadChart(true);
    }
  }

  void getData2({String? datetime}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    if (datetime == null) {
      datetime = DateFormat('yyyy-MM-dd').format(dayNow);
    }
    var url =
        "https://api.tbslogistics.com.vn/api/Report/GetReportRevenue?dateTime=${datetime}";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    isLoadChartTotal(false);
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        var data = ChartTotalModel.fromJson(response.data);
        listChartTotalData = [];
        for (var i = 0; i < data.dataTotal![0].dataDouble!.length; i++) {
          for (var j = 0; j < data.dataTotal![1].dataDouble!.length; j++) {
            for (var k = 0; k < data.dataTotal![2].dataDouble!.length; k++) {
              var items1 = data.dataTotal![0].dataDouble![i].date;
              var dayItems1 = day.format(DateTime.parse(items1.toString()));
              // print(dayItems1);
              var items2 = data.dataTotal![1].dataDouble![j].date;
              var dayItems2 = day.format(DateTime.parse(items2.toString()));
              // print(dayItems2);
              var items3 = data.dataTotal![2].dataDouble![k].date;
              var dayItems3 = day.format(DateTime.parse(items3.toString()));
              // print(dayItems2);

              if (dayItems1 == dayItems2 && dayItems1 == dayItems3) {
                listChartTotalData.add(
                  ChartTotalData(
                    dayItems1,
                    data.dataTotal![0].dataDouble![i].value!,
                    data.dataTotal![1].dataDouble![j].value!,
                    data.dataTotal![2].dataDouble![k].value!,
                  ),
                );
              }
            }
          }
        }

        listTotalNumber = [];
        for (var i = 0; i < listChartTotalData.length; i++) {
          var items = int.parse(listChartTotalData[i].month);
          listTotalNumber.add(items);
        }
        listTotalNumber.sort();
        listChartTotal.value = [];
        for (var i = 0; i < listTotalNumber.length; i++) {
          for (var j = 0; j < listChartTotalData.length; j++) {
            if (i + 1 == int.parse(listChartTotalData[j].month)) {
              var items = listChartTotalData[j];
              listChartTotal.add(items);
            }
          }
        }

        // print("listChartTotal : $listChartTotal");
        update();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
      } else if (e.response!.statusCode == 401) {
      } else if (e.response!.statusCode == 500) {}
    } finally {
      isLoadChartTotal(true);
    }
  }

  void getData3({String? datetime}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getTokenTMS();
    if (datetime == null) {
      datetime = DateFormat('yyyy-MM-dd').format(dayNow);
    }
    var url =
        "https://api.tbslogistics.com.vn/api/Report/GetCustomerReport?dateTime=${datetime}";
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        var data = TableDataModel.fromJson(response.data);
        listTable.value = [];
        for (var i = 0; i < data.customerReports!.length; i++) {
          listTable.add(CustomerReports(
            customerName: data.customerReports![i].customerName,
            totalMoney: data.customerReports![i].totalMoney,
            totalBooking: data.customerReports![i].totalBooking,
            total: data.customerReports![i].total,
          ));
        }
        for (var i = 0; i < data.supllierReports!.length; i++) {
          listTableTotal.add(CustomerReports(
            customerName: data.supllierReports![i].customerName,
            totalMoney: data.supllierReports![i].totalMoney,
          ));
        }
        update();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
      } else if (e.response!.statusCode == 401) {
      } else if (e.response!.statusCode == 500) {}
    }
  }

  void getSnack({required String message}) {
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
        message,
        style: const TextStyle(
          color: Colors.green,
        ),
      ),
      snackPosition: SnackPosition.TOP,
    );
  }
}
