// import 'package:dropdown_search/dropdown_search.dart';
// ignore_for_file: avoid_init_to_null, unused_local_variable, unused_element

import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/surcharges/controller/surchanges_controller.dart';
import 'package:tbs_logistics_tms/app/surcharges/model/list_subfee_model.dart';

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
    return Scaffold(
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
        builder: (controller) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 200,
                    // width: 350,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: FindDropdown<ListSubFeeModel>(
                            label: "Phụ phí",
                            onFind: (String filter) =>
                                controller.getSubFee(filter),
                            onChanged: (ListSubFeeModel? data) {
                              controller.selectedValue.value = data!.subFeeId!;
                              controller.subFee.value = data.subFeeName!;
                            },
                            dropdownBuilder:
                                (BuildContext context, ListSubFeeModel? item) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).dividerColor),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: (item?.subFeeName == null)
                                    ? const ListTile(
                                        title: Text("Chọn phụ phí"))
                                    : ListTile(
                                        title: Text(item!.subFeeName!),
                                      ),
                              );
                            },
                            dropdownItemBuilder: (BuildContext context,
                                ListSubFeeModel item, bool isSelected) {
                              return Container(
                                decoration: !isSelected
                                    ? null
                                    : BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
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
                        ),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: controller.priceController,
                            decoration: const InputDecoration(
                              hintText: 'Nhập giá',
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
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: controller.noteController,
                            decoration: const InputDecoration(
                              hintText: 'Nhập ghi chú',
                            ),
                            onChanged: (value) {
                              controller.ghichu.value = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text("Danh sách phụ phí thêm"),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: controller.itemList.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text("${controller.listSur[index].sfName}"),
                          subtitle:
                              Text("${controller.listSur[index].finalPrice}"),
                        );
                      },
                    ))
                  ],
                );
              }),
            ),
            Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 45,
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orangeAccent),
                      ),
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.addItem(controller.priceController.text);
                          controller.addSurTimes(
                            price: int.parse(controller.priceText.value),
                            sfId:
                                int.parse(controller.selectedValue.toString()),
                            sfName: controller.subFee.value,
                            note: controller.noteController.text,
                          );
                          controller.postData(controller.listSur);
                          controller.listSur.value = [];
                          controller.itemList.value = [];
                          controller.priceController.clear();
                          controller.noteController.clear();
                        }
                      },
                      child: const Text('Gửi'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
}
