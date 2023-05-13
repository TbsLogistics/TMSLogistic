// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/widget/button_form_submit.dart';
import 'package:tbs_logistics_tms/app/config/widget/custom_text_form_field.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/controller/customer_controller.dart';

import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status_details/model/list_driver_by_customer_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_customer_for_driver_model.dart';

import '../../../../../config/widget/dropdown_button.dart';

class RegisterCustomer extends StatefulWidget {
  const RegisterCustomer({Key? key}) : super(key: key);

  @override
  State<RegisterCustomer> createState() => _RegisterCustomerState();
}

class _RegisterCustomerState extends State<RegisterCustomer> {
  final String routes = "/REGISTER_CUSTOMER";
  ListCustomerForDriverModel? selectedKhachhang;
  String? idKhachhang;
  ListDriverByCustomerModel? selectedTaixe;
  String? selectedTeamCar;
  String? selectedCar;
  String? selectedWarehome;
  String? selectedNumberCont;
  int numberSelectCont = 0;

  int? idTaixe;
  String? selectedProduct;

  TextEditingController dateinput = TextEditingController(text: "");
  bool showDateTime = false;
  bool showDate = false;
  bool showTime = false;
  DateTime dateTime = DateTime.now();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orangeAccent,
              onPrimary: Colors.white,
              onSurface: Colors.blueAccent,
              onBackground: Colors.orangeAccent,
              onSurfaceVariant: Colors.black,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    // ignore: unnecessary_null_comparison
    if (date == null) return;

    // ignore: use_build_context_synchronously
    final time = await _selectTime(context);

    // ignore: unnecessary_null_comparison
    if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      // ignore: unnecessary_string_interpolations
      dateinput.text = "${getDateTime()}";
      // print(dateinput.text);
    });
  }

  String getDate() {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('MMM d, yyyy').format(selectedDate);
    }
  }

  String getDateTime() {
    // ignore: unnecessary_null_comparison
    if (dateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CustomerController>(
      init: CustomerController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "TBS Logistics",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 24,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ),
        body: Container(
          height: size.height,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        children: [
                          Text(
                            "Thời gian dự kiến *",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
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
                      height: 60,
                      width: size.width - 10,
                      margin:
                          EdgeInsets.symmetric(vertical: size.height * 0.02),
                      child: TextFormField(
                        onTap: () {
                          _selectDateTime(context);
                        },
                        controller: dateinput,
                        decoration: InputDecoration(
                          hintText: "Nhập thời gian dự kiến",
                          hintStyle: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          ),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.calendar_month,
                            size: 26,
                            color: Theme.of(context).primaryColorLight,
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            Text(
                              "Tài xế *",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          // Expanded(
                          //   child: Theme(
                          //     data: ThemeData(
                          //       inputDecorationTheme:
                          //           const InputDecorationTheme(
                          //               border: InputBorder.none),
                          //     ),
                          //     child: DropdownSearch<ListDriverByCustomerModel>(
                          //       asyncItems: (String? query) {
                          //         return controller.getData(query);
                          //       },
                          //       popupProps: PopupProps.dialog(
                          //         showSelectedItems: true,
                          //         itemBuilder: _customPopupItemBuilderExample2,
                          //         showSearchBox: true,
                          //       ),
                          //       compareFn: (item, sItem) {
                          //         return item.maTaixe == sItem.maTaixe;
                          //       },
                          //       onChanged:
                          //           (ListDriverByCustomerModel? newValue) {
                          //         controller.selectedTaixe =
                          //             newValue!.maTaixe.toString();
                          //       },
                          //       dropdownDecoratorProps: DropDownDecoratorProps(
                          //         dropdownSearchDecoration: InputDecoration(
                          //           hintText: "Chọn tài xế",
                          //           hintStyle: TextStyle(
                          //             color:
                          //                 Theme.of(context).primaryColorLight,
                          //           ),
                          //           filled: true,
                          //           iconColor: const Color(0xFFF3BD60),
                          //           focusColor: const Color(0xFFF3BD60),
                          //           // fillColor: Colors.white,
                          //           focusedBorder: const OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Color(0xFFF3BD60), width: 1.0),
                          //           ),
                          //           enabledBorder: const OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Color(0xFFF3BD60), width: 1.0),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            Text(
                              "Khách hàng *",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          // Expanded(
                          //   child: Theme(
                          //     data: ThemeData(
                          //       inputDecorationTheme:
                          //           const InputDecorationTheme(
                          //               border: InputBorder.none),
                          //     ),
                          //     child: DropdownSearch<ListCustomerForDriverModel>(
                          //       asyncItems: (String? query) {
                          //         return controller.getDataCustomer(query);
                          //       },
                          //       popupProps: PopupProps.dialog(
                          //         showSelectedItems: true,
                          //         itemBuilder: _customPopupItemBuilderExample3,
                          //         showSearchBox: true,
                          //       ),
                          //       compareFn: (item, sItem) {
                          //         return item.maKhachHang == sItem.maKhachHang;
                          //       },
                          //       onChanged:
                          //           (ListCustomerForDriverModel? newValue) {
                          //         controller.selectedKhachhang =
                          //             newValue!.maKhachHang.toString();
                          //       },
                          //       dropdownDecoratorProps: DropDownDecoratorProps(
                          //         dropdownSearchDecoration: InputDecoration(
                          //           hintText: "Chọn khách hàng",
                          //           hintStyle: TextStyle(
                          //             color:
                          //                 Theme.of(context).primaryColorLight,
                          //           ),
                          //           filled: true,
                          //           iconColor: const Color(0xFFF3BD60),
                          //           focusColor: const Color(0xFFF3BD60),
                          //           // fillColor: Colors.white,
                          //           focusedBorder: const OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Color(0xFFF3BD60), width: 1.0),
                          //           ),
                          //           enabledBorder: const OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Color(0xFFF3BD60), width: 1.0),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
                CustomDropdownButton(
                  items: idKho
                      .map((item) => DropdownMenuItem<String>(
                            value: item["value"],
                            child: Text(
                              item["name"],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                    selectedWarehome = value;
                  },
                  onSaved: (value) {
                    selectedWarehome = value.toString();
                  },
                  text: 'Kho *',
                ),
                CustomFormFiels(
                  title: "Số xe *",
                  controller: controller.numberCar,
                  hintText: "Nhập số xe",
                  icon: Icons.abc,
                  color: Theme.of(context).primaryColorLight,
                ),
                CustomDropdownButton(
                  items: idProduct
                      .map((item) => DropdownMenuItem<String>(
                            value: item["value"],
                            child: Text(
                              item["name"],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                    setState(() {
                      selectedProduct = value;
                      // print(selectedProduct);
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      selectedProduct = value.toString();
                    });
                  },
                  text: 'Loại hàng *',
                ),
                CustomDropdownButton(
                  items: genderItems
                      .map((item) => DropdownMenuItem<String>(
                            value: item["value"],
                            child: Text(
                              item["name"],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                    setState(() {
                      selectedCar = value;
                    });
                    // print(selectedCar);
                  },
                  onSaved: (value) {
                    setState(() {
                      selectedCar = value.toString();
                    });
                  },
                  text: 'Loại xe *',
                ),
                selectedCar == "tai"
                    ? CustomFormFiels(
                        title: "Số seal",
                        controller: controller.numberCont1Seal1,
                        hintText: "Nhập số seal",
                        icon: Icons.abc,
                        color: Theme.of(context).primaryColorLight,
                      )
                    : CustomDropdownButton(
                        items: numberCont
                            .map((item) => DropdownMenuItem<String>(
                                  value: item["value"],
                                  child: Text(
                                    item["name"],
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          //Do something when changing the item if you want.
                          setState(() {
                            selectedNumberCont = value;
                            numberSelectCont =
                                // ignore: unnecessary_brace_in_string_interps
                                int.parse("${selectedNumberCont}");
                          });
                          // print(selectedCar);
                        },
                        onSaved: (value) {
                          setState(() {
                            selectedNumberCont = value.toString();
                          });
                        },
                        text: 'Chọn tổng số cont *',
                      ),
                numberSelectCont >= 1 ? _contFirt(controller) : Container(),
                numberSelectCont >= 2 ? _contFirt(controller) : Container(),
                ButtonFormSubmit(
                    onPressed: () {
                      if (selectedCar == null ||
                          controller.selectedTaixe.isEmpty ||
                          selectedWarehome!.isEmpty ||
                          dateinput.text == "" ||
                          selectedProduct!.isEmpty ||
                          controller.selectedKhachhang.isEmpty) {
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
                            "Bạn nhập thiếu thông tin *",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        );
                      }
                      // print(dateinput.text);
                      else {
                        controller.postRegisterCustomer(
                          numberCar: controller.numberCar.text,
                          numberCont1: controller.numberCont1.text,
                          numberCont1Seal1: controller.numberCont1Seal1.text,
                          numberCont1Seal2: controller.numberCont1Seal2.text,
                          numberCont2: controller.numberCont2.text,
                          numberCont2Seal1: controller.numberCont2Seal1.text,
                          numberCont2Seal2: controller.numberCont2Seal2.text,
                          numberKhoi: double.parse(controller.numberKhoi.text),
                          numberKhoi1:
                              double.parse(controller.numberKhoi1.text),
                          numberKien: double.parse(controller.numberKien.text),
                          numberKien1:
                              double.parse(controller.numberKien1.text),
                          numberBook: controller.numberBook.text,
                          numberBook1: controller.numberBook1.text,
                          idCar: selectedCar,
                          idTaixe: int.parse(controller.selectedTaixe),
                          idKho: selectedWarehome,
                          time: dateinput.text,
                          idProduct: selectedProduct,
                          maKhachHang: controller.selectedKhachhang,
                        );
                      }
                    },
                    text: "Đăng ký")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contFirt(CustomerController controller) {
    return Column(
      children: [
        const Divider(),
        CustomFormFiels(
          title: "Số cont 1",
          controller: controller.numberCont1,
          hintText: "Nhập số cont",
          icon: Icons.abc,
          color: Theme.of(context).primaryColorLight,
        ),
        CustomFormFiels(
          title: "Số seal 1",
          controller: controller.numberCont1Seal1,
          hintText: "Nhập số seal",
          icon: Icons.abc,
          color: Theme.of(context).primaryColorLight,
        ),
        CustomFormFiels(
          title: "Số seal 2",
          controller: controller.numberCont1Seal2,
          hintText: "Nhập số seal",
          icon: Icons.abc,
          color: Theme.of(context).primaryColorLight,
        ),
        CustomFormFiels(
          title: "Số book",
          controller: controller.numberBook,
          hintText: "Nhập số book",
          icon: Icons.abc,
          color: Theme.of(context).primaryColorLight,
        ),
        CustomFormFiels(
          title: "Số kiện",
          controller: controller.numberKien,
          hintText: "Nhập số kiện",
          icon: Icons.abc,
          color: Theme.of(context).primaryColorLight,
        ),
        CustomFormFiels(
          title: "Số khối",
          controller: controller.numberKhoi,
          hintText: "Nhập số khối",
          icon: Icons.abc,
          color: Theme.of(context).primaryColorLight,
        ),
      ],
    );
  }

  Widget contSecond(CustomerController controller) {
    return Column(
      children: [
        const Divider(),
        CustomFormFiels(
          title: "Số cont 2",
          controller: controller.numberCont2,
          hintText: "Nhập số cont",
          icon: Icons.abc,
          color: Theme.of(context).primaryColorLight,
        ),
        CustomFormFiels(
          title: "Số seal 1",
          controller: controller.numberCont2Seal1,
          hintText: "Nhập số seal",
          icon: Icons.abc,
          color: Theme.of(context).primaryColorLight,
        ),
        CustomFormFiels(
          title: "Số seal 2",
          controller: controller.numberCont2Seal2,
          hintText: "Nhập số seal",
          icon: Icons.abc,
          color: Theme.of(context).primaryColorLight,
        ),
        CustomFormFiels(
          title: "Số book",
          controller: controller.numberBook1,
          hintText: "Nhập số book",
          icon: Icons.abc,
          color: Theme.of(context).primaryColorLight,
        ),
        CustomFormFiels(
          title: "Số kiện",
          controller: controller.numberKien1,
          hintText: "Nhập số kiện",
          icon: Icons.abc,
          color: Theme.of(context).primaryColorLight,
        ),
        CustomFormFiels(
          title: "Số khối",
          controller: controller.numberKhoi1,
          hintText: "Nhập số khối",
          icon: Icons.abc,
          color: Theme.of(context).primaryColorLight,
        ),
      ],
    );
  }

  Widget _customPopupItemBuilderExample2(
    BuildContext context,
    ListDriverByCustomerModel? item,
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
            item?.tenTaixe ?? '',
            style: const TextStyle(color: Colors.blueGrey),
          ),
          subtitle: Text(item?.phone ?? ''),
          leading: const CircleAvatar(
              // this does not work - throws 404 error
              // backgroundImage: NetworkImage(item.avatar ?? ''),
              ),
        ),
      ),
    );
  }

  Widget _customPopupItemBuilderExample3(
    BuildContext context,
    ListCustomerForDriverModel? item,
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
            item?.tenKhachhang ?? '',
            style: const TextStyle(color: Colors.blueGrey),
          ),
          subtitle: Text(item?.maKhachHang ?? ''),
          leading: const CircleAvatar(
              // this does not work - throws 404 error
              // backgroundImage: NetworkImage(item.avatar ?? ''),
              ),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> idProduct = [
    {'value': "HN", "name": "Nhập hàng"},
    {'value': "HX", "name": "Xuất hàng"},
  ];

  final List<Map<String, dynamic>> genderItems = [
    {"value": "tai", "name": "Xe tải"},
    {"value": "con", "name": "Xe container"},
  ];

  final List<Map<String, dynamic>> numberCont = [
    {'value': "0", "name": "Xe không có cont"},
    {'value': "1", "name": "Xe có 1 cont"},
    {'value': "2", "name": "Xe có 2 cont"},
  ];

  final List<Map<String, dynamic>> idKho = [
    {"value": "K1", "name": "Kho 1"},
    {"value": "K2", "name": "Kho 2"},
    {"value": "K3", "name": "Kho 3"},
    {"value": "K4", "name": "Kho 4"},
    {"value": "K5", "name": "Kho 5"},
    {"value": "K6", "name": "Kho 6"},
    {"value": "K7", "name": "Kho 7"},
  ];
}
