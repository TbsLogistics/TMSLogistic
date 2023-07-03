import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager/controller/letter_manager_controller.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';

class LetterManagerScreen extends GetView<LetterManagerController> {
  const LetterManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    var day = DateFormat("dd/MM/yyyy");
    return GetBuilder<LetterManagerController>(
      init: LetterManagerController(),
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Lọc danh sách đơn theo trạng thái
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () {
                    // ignore: unused_local_variable
                    var listType = controller.selectedDepartmentsValue.value;

                    return Text(
                      controller.selectedDepartmentsValue.value,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orangeAccent),
                  ),
                  onPressed: () {
                    controller.selectedDepartmentsId.value = "";
                    controller.selectedDepartmentsValue.value = "";
                    controller.showMultiSelect();
                  },
                  child: const Text('Chọn loại phép'),
                ),
              ],
            ),
            //Duyệt nhanh tất cả các đơn
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     ElevatedButton(
            //       style: ButtonStyle(
            //         backgroundColor:
            //             MaterialStateProperty.all<Color>(Colors.green),
            //       ),
            //       onPressed: () {
            //         // print(controller.listRegid);
            //         controller.postApproveAll(
            //           regID: controller.listRegid,
            //           comment: "",
            //           state: 1,
            //         );
            //       },
            //       child: const Text('Success all'),
            //     ),
            //   ],
            // ),
            Obx(
              () {
                return Expanded(
                  child: controller.isLoadDayOffManganer.value
                      ? controller.listDayOffManager.isNotEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.only(bottom: 50),
                              itemCount: controller.listDayOffManager.length,
                              itemBuilder: (context, index) {
                                var item = controller.listDayOffManager[index];

                                return _buildCustomListtile(
                                  onTap: () async {
                                    var result = await Get.toNamed(
                                      Routes.DETAIL_ACCESS_SINGLE_SCREEN,
                                      arguments: item.regID,
                                    );
                                    if (result is bool && result == true) {
                                      controller.getDayOffLetterManager(
                                          needAppr: 1, astatus: "");
                                    }
                                  },
                                  stt: "${index + 1}",
                                  fromDay: day.format(
                                    DateTime.parse(
                                      item.startDate.toString(),
                                    ),
                                  ),
                                  endDay: item.endDate != null
                                      ? day.format(
                                          DateTime.parse(
                                            item.endDate.toString(),
                                          ),
                                        )
                                      : "",
                                  type: '${item.reason}',
                                  totalDay: '${item.period} ngày',
                                  color: Colors.green,
                                  child: item.aStatus != 1
                                      ? Center(
                                          child: Text(
                                            item.aStatus == 2
                                                ? "Đã duyệt"
                                                : "Từ chối",
                                            style: TextStyle(
                                              color: item.aStatus == 2
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            controller.postApprove(
                                              regID: item.regID!,
                                              comment: "",
                                              state: 1,
                                            );
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              // color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/check.jpg"),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                  msnv: item.empID.toString(),
                                  name: "${item.lastName} ${item.firstName}",
                                );
                              })
                          : const Center(
                              child: Text(
                                "Không có đơn !",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                ),
                              ),
                            )
                      : ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.black.withOpacity(0.4),
                                  width: 1,
                                ),
                              ),
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 15,
                                      width: size.width * 0.2,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Container(
                                      height: 15,
                                      width: size.width * 0.2,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Container(
                                  height: 15,
                                  width: size.width * 0.1,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 15,
                                      width: size.width * 0.15,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Container(
                                      height: 15,
                                      width: size.width * 0.15,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomListtile({
    required String stt,
    required String fromDay,
    required String endDay,
    required String totalDay,
    required String type,
    required Color color,
    required VoidCallback onTap,
    required Widget child,
    required String msnv,
    required String name,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.orangeAccent,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          height: 110,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        msnv,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        name,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: [
                          const Divider(
                            height: 1,
                            indent: 0,
                            endIndent: 10,
                            thickness: 1,
                            color: Colors.orangeAccent,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    fromDay,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                const Expanded(child: Text("-")),
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    endDay,
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                            indent: 0,
                            endIndent: 10,
                            thickness: 1,
                            color: Colors.orangeAccent,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    type,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    totalDay,
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(flex: 2, child: child),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
