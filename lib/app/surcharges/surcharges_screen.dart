// import 'package:dropdown_search/dropdown_search.dart';
// ignore_for_file: avoid_init_to_null, unused_local_variable, unused_element

import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/surcharges/controller/surchanges_controller.dart';
import 'package:tbs_logistics_tms/app/surcharges/model/list_subfee_model.dart';
import 'package:tbs_logistics_tms/app/surcharges/modules/list_add.dart';
import 'package:tbs_logistics_tms/app/surcharges/modules/list_added.dart';

import 'package:tbs_logistics_tms/config/core/data/color.dart';

class SurChangesScreen extends StatefulWidget {
  const SurChangesScreen({super.key});

  @override
  State<SurChangesScreen> createState() => _SurChangesScreenState();
}

class _SurChangesScreenState extends State<SurChangesScreen> {
  final dropDownController = Get.put(SurChangesController());
  String? selectedNumberCont;

  final String routes = "/SUR_CHANGE_SCREEN";
  String? selectedValue = null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var day = DateFormat("dd/MM");
    var hour = DateFormat("hh-mm a");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Phụ phí "),
          centerTitle: true,
          // automaticallyImplyLeading: false,
          backgroundColor: CustomColor.backgroundAppbar,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
        body: GetBuilder<SurChangesController>(
            init: SurChangesController(),
            builder: (controller) => Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildInputForm(controller),
                          _buildListSurFee(controller, size),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(
                            //   height: 45,
                            //   width: 150,
                            //   child: ElevatedButton(
                            //     style: ButtonStyle(
                            //       backgroundColor: MaterialStateProperty.all(
                            //           Colors.orangeAccent),
                            //     ),
                            //     onPressed: () {
                            //       if (controller.formKey.currentState!
                            //           .validate()) {
                            //         controller.addItem(
                            //             controller.priceController.text);
                            //         controller.addSurTimes(
                            //           price:
                            //               int.parse(controller.priceText.value),
                            //           sfId: int.parse(
                            //               controller.selectedValue.toString()),
                            //           sfName: controller.subFee.value,
                            //           note: controller.noteController.text,
                            //         );
                            //         controller.addSurFee(
                            //           price:
                            //               int.parse(controller.priceText.value),
                            //           sfId: int.parse(
                            //               controller.selectedValue.toString()),
                            //           note: controller.noteController.text,
                            //         );
                            //       }
                            //     },
                            //     child: const Text('Thêm'),
                            //   ),
                            // ),
                            // const SizedBox(width: 15),
                            SizedBox(
                              height: 45,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.orangeAccent),
                                ),
                                onPressed: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.addItem(
                                        controller.priceController.text);
                                    controller.addSurTimes(
                                      price:
                                          int.parse(controller.priceText.value),
                                      sfId: int.parse(
                                          controller.selectedValue.toString()),
                                      sfName: controller.subFee.value,
                                      note: controller.noteController.text,
                                    );
                                    controller.addSurFee(
                                      price:
                                          int.parse(controller.priceText.value),
                                      sfId: int.parse(
                                          controller.selectedValue.toString()),
                                      note: controller.noteController.text,
                                    );
                                    controller
                                        .postData(controller.listSurRegister);
                                    controller.listSur.value = [];
                                    controller.itemList.value = [];
                                    controller.listSurRegisted.value = [];
                                    controller.priceController.clear();
                                    controller.noteController.clear();
                                  }
                                },
                                child: const Text('Gửi'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
      ),
    );
  }

  Widget _customPopupItemBuilderExample3(
    BuildContext context,
    ListSubFeeModel? item,
    bool isSelected,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        // color: Colors.green,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color(0xFFF3BD60),
          ),

          borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        ),
        child: ListTile(
          style: ListTileStyle.drawer,
          focusColor: Colors.white,
          title: Text(
            item?.subFeeName ?? '',
            style: const TextStyle(color: Colors.blueGrey),
          ),
          leading: const CircleAvatar(),
        ),
      ),
    );
  }

  Widget _buildListSurFee(SurChangesController controller, Size size) {
    return SizedBox(
      height: size.height,
      child: Column(
        children: const [
          // ListAddScreen(),
          ListAddedScreen(),
        ],
      ),
    );
  }

  Widget _buildInputForm(SurChangesController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            FindDropdown<ListSubFeeModel>(
              label: "Phụ phí",
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              onFind: (String filter) => controller.getSubFee(filter),
              onChanged: (ListSubFeeModel? data) {
                controller.selectedValue.value = data!.subFeeId!;
                controller.subFee.value = data.subFeeName!;
              },
              dropdownBuilder: (BuildContext context, ListSubFeeModel? item) {
                return Container(
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: (item?.subFeeName == null)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Chọn chứng từ",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.black,
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                item!.subFeeName!.trim(),
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.black,
                            )
                          ],
                        ),
                );
              },
              dropdownItemBuilder: (BuildContext context, ListSubFeeModel item,
                  bool isSelected) {
                return Container(
                  decoration: !isSelected
                      ? null
                      : BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(item.subFeeName!),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            _inputSubFee(controller),
            const SizedBox(height: 10),
            _inputNotes(controller),
          ],
        ),
      ),
    );
  }

  Widget _inputSubFee(SurChangesController controller) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 40,
            child: Row(
              children: const [
                Text(
                  "Giá phụ phí : ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(width: 1, color: Colors.black.withOpacity(0.4)),
            ),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: controller.priceController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 5, left: 10),
                hintText: 'Nhập giá',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Chưa nhập giá';
                }
                return null;
              },
              onChanged: (value) {
                controller.priceText.value = value;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _inputNotes(SurChangesController controller) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 40,
            child: Row(
              children: const [
                Text(
                  "Ghi chú : ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(width: 1, color: Colors.black.withOpacity(0.4)),
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              controller: controller.noteController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 5, left: 10),
                hintText: 'Nhập ghi chú',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none),
              ),
              onChanged: (value) {
                controller.ghichu.value = value;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListTitle({
    required SurChangesController controller,
    required String sfName,
    required String price,
    required String trangThai,
    required String date,
  }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    sfName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(price),
            ],
          ),
          Column(),
        ],
      ),
    );
  }
}
