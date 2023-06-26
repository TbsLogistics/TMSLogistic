import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/page/tms/dashboard/controller/dash_board_controller.dart';
import 'package:tbs_logistics_tms/app/page/tms/dashboard/data/mysouce.dart';
import 'package:tbs_logistics_tms/app/page/tms/dashboard/data/table_total.dart';

class DashBoardTmsPage extends GetView<DashBoardTmsController> {
  const DashBoardTmsPage({super.key});

  final String routes = "/DASH_BOARD_TMS_PAGE";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 24,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text("TMS PAGE"),
        centerTitle: true,
        backgroundColor: CustomColor.backgroundAppbar,
      ),
      body: GetBuilder<DashBoardTmsController>(
        init: DashBoardTmsController(),
        builder: (controller) {
          MySource mySource = MySource(controller.listTable);
          TableTotal tableTotal = TableTotal(controller.listTableTotal);

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildDateTime(context, size, controller),
                const SizedBox(
                  height: 10,
                ),
                //Initialize the chart widget
                Obx(() {
                  return controller.isLoadChart.value
                      ? SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(
                              text: 'Thống kê vận đơn và chuyến theo tháng'),
                          // Enable legend
                          legend: const Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                          ),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<ChartData, String>>[
                            LineSeries<ChartData, String>(
                              dataSource: controller.listChart,
                              xValueMapper: (ChartData sales, _) => sales.month,
                              yValueMapper: (ChartData sales, _) =>
                                  sales.chuyen,
                              name: 'Chuyen',

                              // Enable data label
                              // dataLabelSettings: DataLabelSettings(isVisible: true),
                            ),
                            LineSeries<ChartData, String>(
                              dataSource: controller.listChart,
                              xValueMapper: (ChartData sales, _) => sales.month,
                              yValueMapper: (ChartData sales, _) =>
                                  sales.vandon,
                              name: 'Van don',

                              // xAxisName: "true",
                              // yAxisName: "asdasdsadsa",
                              // Enable data label
                              // dataLabelSettings: DataLabelSettings(isVisible: true),
                            )
                          ],
                        )
                      : Container(
                          height: 200,
                          color: Colors.grey[300],
                          width: size.width * 0.9,
                        );
                }),
                Obx(() {
                  return controller.isLoadChartTotal.value
                      ? SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(
                              text: 'Thống kê Chi Phí,Lợi Nhuận, Doanh Thu'),
                          // Enable legend
                          legend: const Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                          ),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<ChartTotalData, String>>[
                            LineSeries<ChartTotalData, String>(
                              dataSource: controller.listChartTotal,
                              xValueMapper: (ChartTotalData sales, _) =>
                                  sales.month,
                              yValueMapper: (ChartTotalData sales, _) =>
                                  sales.chiPhi,
                              name: 'Chi phi',

                              // Enable data label
                              // dataLabelSettings: DataLabelSettings(isVisible: true),
                            ),
                            LineSeries<ChartTotalData, String>(
                              dataSource: controller.listChartTotal,
                              xValueMapper: (ChartTotalData sales, _) =>
                                  sales.month,
                              yValueMapper: (ChartTotalData sales, _) =>
                                  sales.doanhThu,
                              name: 'Doanh thu',

                              // xAxisName: "true",
                              // yAxisName: "asdasdsadsa",
                              // Enable data label
                              // dataLabelSettings:
                              //     DataLabelSettings(isVisible: true),
                            ),
                            LineSeries<ChartTotalData, String>(
                              dataSource: controller.listChartTotal,
                              xValueMapper: (ChartTotalData sales, _) =>
                                  sales.month,
                              yValueMapper: (ChartTotalData sales, _) =>
                                  sales.loiNhuan,
                              name: 'Loi nhuan',

                              // xAxisName: "true",
                              // yAxisName: "asdasdsadsa",
                              // Enable data label
                              // dataLabelSettings: DataLabelSettings(isVisible: true),
                            )
                          ],
                        )
                      : Container(
                          height: 200,
                          color: Colors.grey[300],
                          width: size.width * 0.9,
                        );
                }),
                Container(
                  height: 500,
                  width: size.width,
                  child: PaginatedDataTable(
                    source: mySource,
                    columns: const [
                      DataColumn(label: Text('Khách hàng')),
                      DataColumn(label: Text('Tháng')),
                      DataColumn(label: Text('Doanh thu'))
                    ],
                    header: const Center(
                        child: Text('Thống kê dữ liệu của khách hàng')),
                    columnSpacing: 50,
                    horizontalMargin: 40,
                    rowsPerPage: 5,
                  ),
                ),
                Container(
                  height: 500,
                  width: size.width,
                  child: PaginatedDataTable(
                    source: tableTotal,
                    columns: const [
                      DataColumn(label: Text('Khách hàng')),
                      DataColumn(label: Text('Doanh thu'))
                    ],
                    header: const Center(
                        child: Text('Thống kê dữ liệu nhà cung cấp')),
                    columnSpacing: 50,
                    horizontalMargin: 40,
                    rowsPerPage: 5,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildDateTime(
      BuildContext context, Size size, DashBoardTmsController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   padding: const EdgeInsets.only(left: 5),
        //   child: const Row(
        //     children: [
        //       Text(
        //         "Thời gian dự kiến *",
        //         textAlign: TextAlign.left,
        //         style: TextStyle(
        //           color: Colors.green,
        //           fontSize: 16,
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              // color: Color(0xFFF3BD60),
              color: Colors.orangeAccent,
            ),
            // color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.only(top: 10, left: 10),
          height: 40,
          width: 100,
          margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: TextFormField(
            style: const TextStyle(color: Colors.green),
            onTap: () {
              _selectDate(context);
            },
            controller: controller.dateinput,
            decoration: InputDecoration(
              hintText: controller.dateinput.text == ""
                  ? DateFormat('MM-yyyy').format(controller.dateTime)
                  : controller.dateinput.text,
              hintStyle: const TextStyle(
                color: Colors.green,
              ),
              contentPadding: const EdgeInsets.only(left: 10),
              border: InputBorder.none,
              // icon: const Icon(
              //   Icons.calendar_month,
              //   size: 26,
              // ),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
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
      context: context,
      initialDate: controller.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != controller.selectedDate) {
      controller.selectedDate = selected;
      controller.update();
    }
    controller.dateinput.text = "${getDateTime()}";
    controller.getData1(
        datetime: DateFormat('yyyy-MM-dd').format(controller.selectedDate));
    controller.getData2(
        datetime: DateFormat('yyyy-MM-dd').format(controller.selectedDate));
    controller.getData3(
        datetime: DateFormat('yyyy-MM-dd').format(controller.selectedDate));
    return controller.selectedDate;
  }

  String getDateTime() {
    // ignore: unnecessary_null_comparison
    if (controller.dateTime == null) {
      return '';
    } else {
      return DateFormat('MM-yyyy').format(controller.selectedDate);
    }
  }
}

class ChartData {
  ChartData(this.month, this.chuyen, this.vandon);

  final String month;
  final int chuyen;
  final int vandon;
}

class ChartTotalData {
  ChartTotalData(this.month, this.chiPhi, this.doanhThu, this.loiNhuan);

  final String month;
  final int chiPhi;
  final int doanhThu;
  final int loiNhuan;
}
