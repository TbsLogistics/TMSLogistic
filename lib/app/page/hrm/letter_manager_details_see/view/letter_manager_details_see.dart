import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager_details_see/controller/letter_manager_details_see_controler.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself/model/user_hrm_model.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_details/model/letter_myself_detail_model.dart';

class LetterManagerDetailsSee
    extends GetView<LetterManagerDetailsSeeController> {
  const LetterManagerDetailsSee(this.regID, {super.key});
  final int regID;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: unnecessary_null_comparison
    if (regID != null) {
      return GetBuilder<LetterManagerDetailsSeeController>(
        init: LetterManagerDetailsSeeController(),
        builder: (controller) => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: controller.detailSingle(regID: regID),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var items = snapshot.data as LetterMyselfDetailsModel;
                          var detail = items.rData;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildFormText(
                                title: "MSNV",
                                content: "${detail!.empID}",
                                size: size,
                              ),
                              _buildFormText(
                                title: "Loại phép",
                                content: "${detail.type}",
                                size: size,
                              ),
                              FutureBuilder(
                                  future: controller.getInfoClient(
                                      empId: "${detail.empID}"),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var itemsClient =
                                          snapshot.data as UserHrmModel;
                                      return Column(
                                        children: [
                                          _buildFormText(
                                            title: "Tên nhân viên",
                                            content:
                                                "${itemsClient.lastName} ${itemsClient.firstName}",
                                            size: size,
                                          ),
                                          _buildFormText(
                                            title: "Bộ phận",
                                            content:
                                                "${itemsClient.jobpositionName}",
                                            size: size,
                                          ),
                                        ],
                                      );
                                    }
                                    return Container();
                                  }),
                              _buildFormText(
                                title: "Số ngày nghỉ",
                                content: "${detail.period}",
                                size: size,
                              ),
                              _buildFormText(
                                title: "Lý do nghỉ phép",
                                content: "${detail.reason}",
                                size: size,
                              ),
                            ],
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.orangeAccent,
                          ),
                        );
                      }),
                ],
              )),
        ),
      );
    }
    return SizedBox(
      height: size.height,
      width: size.width,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.orangeAccent,
        ),
      ),
    );
  }

  Widget _buildFormText(
      {required String title, required String content, required Size size}) {
    return Card(
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.05,
                  ),
                  child: Text(title)),
            ),
            Expanded(
              flex: 4,
              child: Text(content),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildFormStatusText({
    required String title,
    required String content,
    required Size size,
    required Color color,
  }) {
    return Card(
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.05,
                  ),
                  child: Text(title)),
            ),
            Expanded(
              flex: 4,
              child: Text(
                content,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
