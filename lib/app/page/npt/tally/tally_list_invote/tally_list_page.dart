import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/page/npt/tally/tally_list_invote/controller/tally_list_controller.dart';

class TallyListPage extends GetView<TallyListController> {
  const TallyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var hours = DateFormat('dd-MM-yyyy HH:mm a');
    return GetBuilder<TallyListController>(
      init: TallyListController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.backgroundAppbar,
          title: const Text(
            "Tbs Logistics",
            style: CustomTextStyle.tilteAppbar,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: ListView.builder(
            itemBuilder: (c, i) {
              var items = controller.listDangtai[i];
              return _customListTitle(
                stt: "${i + 1}",
                nameDriver: items.maTaixe!.tenTaixe ?? "",
                IDPhieu: items.pdriverInOutWarehouseCode ?? "",
                colorID: items.giovao != null ? Colors.red : Colors.green,
                soCont: items.socont1 ?? "",
                numberCar: items.soxe ?? "",
                titleTime: items.giovao != null ? "Giờ vào" : "Giờ dự kiến",
                time: hours.format(
                  DateTime.parse("${items.giovao ?? items.giodukien}"),
                ),
                onTap: () {
                  // Get.toNamed(
                  //   Routes.SERCURITY_DETAILS_LIST_DANGTAI,
                  //   arguments: items,
                  // );
                },
              );
            },
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}

Widget _customListTitle({
  required String stt,
  required String nameDriver,
  required String IDPhieu,
  required String soCont,
  required String numberCar,
  required String time,
  required String titleTime,
  required Color colorID,
  Function()? onTap,
}) {
  return Card(
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        width: 1,
        color: Colors.orangeAccent,
      ),
    ),
    shadowColor: Colors.grey,
    elevation: 10,
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                      child: Text(
                    stt,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            nameDriver,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            IDPhieu,
                            style: TextStyle(
                              color: colorID,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Số Cont: ",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            soCont,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Số xe :",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            numberCar,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            titleTime,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            time,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
