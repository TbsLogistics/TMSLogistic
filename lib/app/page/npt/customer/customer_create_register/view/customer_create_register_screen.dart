// import 'package:dropdown_search/dropdown_search.dart';
// ignore_for_file: unrelated_type_equality_checks

import 'package:date_time_picker/date_time_picker.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/config/data/validate.dart';
import 'package:tbs_logistics_tms/app/config/widget/button_form_submit.dart';
import 'package:tbs_logistics_tms/app/config/widget/custom_text_form_field.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/controller/customer_create_register_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_of_ware_home_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_matrongtai_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_car.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_cont_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_product_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_warehome_model.dart';

import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status_details/model/list_driver_by_customer_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_customer_for_driver_model.dart';

class CustomerRegisterScreen extends StatefulWidget {
  const CustomerRegisterScreen({Key? key}) : super(key: key);

  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  final String routes = "/REGISTER_CUSTOMER";
  ListCustomerForDriverModel? selectedKhachhang;
  String? idKhachhang;
  ListDriverByCustomerModel? selectedTaixe;

  int numberSelectCont = 0;

  int? idTaixe;
  String? selectedProduct;

  bool showDateTime = false;
  bool showDate = false;
  bool showTime = false;
  DateTime dateTime = DateTime.now();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  // Future<DateTime> _selectDate(BuildContext context) async {
  //   final selected = await showDatePicker(
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           dialogBackgroundColor: Colors.white,
  //           colorScheme: const ColorScheme.light(
  //             primary: Colors.orangeAccent,
  //             onPrimary: Colors.white,
  //             onSurface: Colors.blueAccent,
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2025),
  //   );
  //   if (selected != null && selected != selectedDate) {
  //     setState(() {
  //       selectedDate = selected;
  //     });
  //   }
  //   return selectedDate;
  // }

  // Future<TimeOfDay> _selectTime(BuildContext context) async {
  //   final selected = await showTimePicker(
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: const ColorScheme.light(
  //             primary: Colors.orangeAccent,
  //             onPrimary: Colors.white,
  //             onSurface: Colors.blueAccent,
  //             onBackground: Colors.orangeAccent,
  //             onSurfaceVariant: Colors.black,
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //     initialEntryMode: TimePickerEntryMode.input,
  //     context: context,
  //     initialTime: selectedTime,
  //   );
  //   if (selected != null && selected != selectedTime) {
  //     setState(() {
  //       selectedTime = selected;
  //     });
  //   }
  //   return selectedTime;
  // }

  // Future _selectDateTime(BuildContext context) async {
  //   final date = await _selectDate(context);
  //   // ignore: unnecessary_null_comparison
  //   if (date == null) return;

  //   // ignore: use_build_context_synchronously
  //   final time = await _selectTime(context);

  //   // ignore: unnecessary_null_comparison
  //   if (time == null) return;
  //   setState(() {
  //     dateTime = DateTime(
  //       date.year,
  //       date.month,
  //       date.day,
  //       time.hour,
  //       time.minute,
  //     );
  //     // ignore: unnecessary_string_interpolations
  //     dateinput.text = "${getDateTime()}";
  //     // print(dateinput.text);
  //   });
  // }

  // String getDate() {
  //   // ignore: unnecessary_null_comparison
  //   if (selectedDate == null) {
  //     return 'select date';
  //   } else {
  //     return DateFormat('MMM d, yyyy').format(selectedDate);
  //   }
  // }

  // String getDateTime() {
  //   // ignore: unnecessary_null_comparison
  //   if (dateTime == null) {
  //     return 'select date timer';
  //   } else {
  //     return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CustomerRegisterController>(
      init: CustomerRegisterController(),
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
                      child: const Row(
                        children: [
                          Text(
                            "Thời gian dự kiến *",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.green,
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
                      child: DateTimePicker(
                        type: DateTimePickerType.dateTime,
                        dateMask: 'dd-MM-yyyy HH:mm',
                        controller: controller.dateinput,
                        // initialValue: _initialValue,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        decoration: const InputDecoration(
                          hintText: "Chọn ngày/ giờ vào",
                          hintStyle: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.event,
                            size: 30,
                          ),
                          iconColor: Colors.orangeAccent,
                        ),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        // onChanged: (val) {
                        //   setState(() => controller.valueDateInput = val);
                        // },
                      ),
                    ),
                  ],
                ),
                _numberCar(controller),
                _listDriver(controller),
                _listWareHome(controller),
                Obx(
                  () => controller.selectWareHome.value.maKho != null
                      ? _listCustomer(controller)
                      : Container(),
                ),
                _listTypeProduct(controller),
                _listTypeCar(controller),
                Obx(() => controller.selectTypeCar.value != "" &&
                        controller.selectTypeCar.value.maLoaiXe == "con"
                    ? Column(
                        children: [
                          _contFirt(controller),
                          Center(
                            child: IconButton(
                              onPressed: () {
                                controller.changeHideShowCont2();
                              },
                              icon: controller.isShowCont2.value
                                  ? const Icon(
                                      Icons.remove_circle,
                                      size: 30,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.add_circle,
                                      size: 30,
                                      color: Colors.green,
                                    ),
                            ),
                          ),
                          controller.isShowCont2.value
                              ? _contSecond(controller)
                              : Container(),
                        ],
                      )
                    : _formCar(controller)),
                ButtonFormSubmit(
                    onPressed: () {
                      onSignUp(controller);
                    },
                    text: "Đăng ký")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formCar(CustomerRegisterController controller) {
    return Column(
      children: [
        _listTrongTai(controller),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont1Seal1,
          hintText: "Nhập Số Seal",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số Book",
          controller: controller.numberBook,
          hintText: "Nhập Số Book",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Khối lượng (Kg)",
          controller: controller.numberTan,
          hintText: "Nhập Khối lượng (Kg)",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số Khối (CBM)",
          controller: controller.numberKhoi,
          hintText: "",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số Kiện",
          controller: controller.numberKien,
          hintText: "",
          icon: Icons.abc,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _contFirt(CustomerRegisterController controller) {
    return Column(
      children: [
        const Divider(),
        _listTypeCont1(controller),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số cont 1",
          controller: controller.numberCont1,
          hintText: "Nhập số cont",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont1Seal1,
          hintText: "Nhập số seal",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont1Seal2,
          hintText: "Nhập số seal",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số book",
          controller: controller.numberBook,
          hintText: "Nhập số book",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số kiện",
          controller: controller.numberKien,
          hintText: "Nhập số kiện",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Khối lượng (Kg)",
          controller: controller.numberTan,
          hintText: "Nhập Khối lượng (Kg)",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số Khối (CBM)",
          controller: controller.numberKhoi,
          hintText: "Nhập Số Khối (CBM)",
          icon: Icons.abc,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _contSecond(CustomerRegisterController controller) {
    return Column(
      children: [
        const Divider(),
        _listTypeCont2(controller),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số cont 2",
          controller: controller.numberCont2,
          hintText: "Nhập số cont",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont2Seal1,
          hintText: "Nhập số seal",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont2Seal2,
          hintText: "Nhập số seal",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số book",
          controller: controller.numberBook1,
          hintText: "Nhập số book",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số kiện",
          controller: controller.numberKien1,
          hintText: "Nhập số kiện",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Khối lượng (Kg)",
          controller: controller.numberTan1,
          hintText: "Nhập Khối lượng (Kg)",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số Khối (CBM)",
          controller: controller.numberKhoi1,
          hintText: "Nhập Số Khối (CBM)",
          icon: Icons.abc,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _listTrongTai(CustomerRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Trọng tải *",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          FindDropdown<ListMaTrongTai>(
            showSearchBox: false,
            onFind: (String filter) => controller.getTrongTai(filter),
            onChanged: (ListMaTrongTai? data) {
              setState(() {
                controller.selectTrongTai.value.maTrongTai = data!.maTrongTai;
              });
            },
            dropdownBuilder: (BuildContext context, ListMaTrongTai? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.tenTrongTai == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn trọng tải",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      )
                    : ListTile(
                        title: Text(
                          item!.tenTrongTai!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder:
                (BuildContext context, ListMaTrongTai item, bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(
                      item.tenTrongTai!,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      item.maTrongTai!,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _numberCar(CustomerRegisterController controller) {
    return CustomFormFiels(
      keyboardType: TextInputType.text,
      title: "Số xe *",
      controller: controller.numberCar,
      hintText: "Nhập số xe",
      icon: Icons.abc,
      color: Colors.green,
    );
  }

  Widget _listCustomer(CustomerRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Khách hàng *",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          FindDropdown<CustomerOfWareHomeModel>(
            showSearchBox: false,
            onFind: (String filter) => controller
                .getCusomter("${controller.selectWareHome.value.maKho}"),
            onChanged: (value) {
              setState(() {
                controller.selectCustomer.value.maKhachHang =
                    value!.maKhachHang;
                controller.selectCustomer.value.tenKhachhang =
                    value.tenKhachhang;
                // print(controller.selectCustomer.value.tenKhachhang);
              });
            },
            dropdownBuilder:
                (BuildContext context, CustomerOfWareHomeModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.tenKhachhang == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn khách hàng",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      )
                    : ListTile(
                        title: Text(
                          item!.tenKhachhang!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder: (BuildContext context,
                CustomerOfWareHomeModel item, bool isSelected) {
              return Container(
                // height: 100,
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(
                      item.tenKhachhang!,
                      style: const TextStyle(color: Colors.orangeAccent),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _listDriver(CustomerRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Tài xế *",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          FindDropdown<ListDriverByCustomerModel>(
            showSearchBox: false,
            onFind: (String filter) => controller.getDataDriver(filter),
            onChanged: (value) {
              controller.selectDriver.value.maTaixe = value!.maTaixe;
            },
            dropdownBuilder:
                (BuildContext context, ListDriverByCustomerModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.tenTaixe == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn tài xế",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      )
                    : ListTile(
                        title: Text(
                          item!.tenTaixe!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder: (BuildContext context,
                ListDriverByCustomerModel item, bool isSelected) {
              return Container(
                // height: 100,
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(
                      item.tenTaixe!,
                      style: const TextStyle(color: Colors.orangeAccent),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _listWareHome(CustomerRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Kho *",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          FindDropdown<ListWareHomeModel>(
            showSearchBox: false,
            onFind: (String filter) => controller.getDataWareHome(filter),
            onChanged: (ListWareHomeModel? data) {
              setState(() {
                controller.selectWareHome.value.maKho = data!.maKho;
              });
            },
            dropdownBuilder: (BuildContext context, ListWareHomeModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.tenKho == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn kho",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      )
                    : ListTile(
                        title: Text(
                          item!.tenKho!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder: (BuildContext context, ListWareHomeModel item,
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
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(
                      item.tenKho!,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      item.maKhuVuc!,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _listTypeProduct(CustomerRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Loại hàng *",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          FindDropdown<ListTypeProductModel>(
            // label: "Khách hàng",
            validate: (ListTypeProductModel? value) =>
                Validate().selectCustomer(value: value!.tenLoaiHang),
            showSearchBox: false,
            onFind: (String filter) => controller.getDataTypeProduct(filter),
            onChanged: (ListTypeProductModel? data) {
              controller.selectTypeProduct.value.maloaiHang = data!.maloaiHang;
            },
            dropdownBuilder:
                (BuildContext context, ListTypeProductModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.tenLoaiHang == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn loại hàng",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      )
                    : ListTile(
                        title: Text(
                          item!.tenLoaiHang!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder: (BuildContext context,
                ListTypeProductModel item, bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(
                      item.tenLoaiHang!,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      item.maloaiHang!,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _listNumberCont(CustomerRegisterController controller, Size size) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5),
          child: const Row(
            children: [
              Text(
                "Số lượng cont *",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: size.width,
          child: Card(
            shape: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orangeAccent,
                width: 1,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  isExpanded: false,
                  value: controller.selectItems,
                  onChanged: (String? value) {
                    setState(() {
                      controller.selectItems = value!;
                      numberSelectCont = int.parse(value);
                    });
                  },
                  alignment: Alignment.centerLeft,
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 16,
                  ),
                  underline: Container(color: Colors.transparent),
                  items: numberCont.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _listTypeCar(CustomerRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Loại xe *",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          FindDropdown<ListTypeCarModel>(
            showSearchBox: false,
            onFind: (String filter) => controller.getDataTypeCar(filter),
            onChanged: (ListTypeCarModel? data) {
              setState(() {
                controller.selectTypeCar.value.maLoaiXe = data!.maLoaiXe;
                // print(controller.selectTypeCar.value.maLoaiXe);
                if (controller.selectTypeCar.value.maLoaiXe == "tai") {
                  numberSelectCont = 0;
                }
              });
            },
            dropdownBuilder: (BuildContext context, ListTypeCarModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.tenLoaiXe == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn xe",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      )
                    : ListTile(
                        title: Text(
                          item!.tenLoaiXe!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder:
                (BuildContext context, ListTypeCarModel item, bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(
                      item.tenLoaiXe!,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _listTypeCont1(CustomerRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Loại cont *",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          FindDropdown<ListTypeContModel>(
            showSearchBox: false,
            onFind: (String filter) => controller.getDataTypeCont(filter),
            onChanged: (ListTypeContModel? data) {
              setState(() {
                controller.selectTypeCont1.value.typeContCode =
                    data!.typeContCode;
                print([
                  controller.selectTypeCont1.value.typeContCode,
                  numberSelectCont,
                ]);
                controller.update();
              });
            },
            dropdownBuilder: (BuildContext context, ListTypeContModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.typeContname == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn loại cont",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      )
                    : ListTile(
                        title: Text(
                          item!.typeContname!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder: (BuildContext context, ListTypeContModel item,
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
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(
                      item.typeContname!,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _listTypeCont2(CustomerRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Loại cont *",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          FindDropdown<ListTypeContModel>(
            showSearchBox: false,
            onFind: (String filter) => controller.getDataTypeCont(filter),
            onChanged: (ListTypeContModel? data) {
              setState(() {
                controller.selectTypeCont2.value.typeContCode =
                    data!.typeContCode;
                controller.update();
              });
            },
            dropdownBuilder: (BuildContext context, ListTypeContModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.typeContname == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn loại cont",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      )
                    : ListTile(
                        title: Text(
                          item!.typeContname!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder: (BuildContext context, ListTypeContModel item,
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
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(
                      item.typeContname!,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  onSignUp(CustomerRegisterController controller) {
    if (controller.dateinput.text == "" ||
        controller.numberCar.text == "" ||
        controller.selectCustomer.value == "" ||
        controller.selectDriver.value == "" ||
        controller.selectWareHome.value == "" ||
        controller.selectTypeProduct.value == "" ||
        controller.selectTypeCar.value == "") {
      getSnack(messageText: "Nhập đầy đủ thông tin *");
    }
    // print(controller.dateinput.text);
    else {
      if (controller.selectTypeCar.value.maLoaiXe == "con") {
        if (controller.isShowCont2.value == false &&
                controller.selectTypeCont1.value.typeContCode != null ||
            controller.isShowCont2.value == true &&
                controller.selectTypeCont1.value.typeContCode != null &&
                controller.selectTypeCont2.value.typeContCode != null) {
          controller.postRegisterCustomer(
            idTaixe: controller.selectDriver.value.maTaixe,
            maKhachHang: controller.selectCustomer.value.maKhachHang!,
            time: controller.dateinput.text,
            idKho: controller.selectWareHome.value.maKho,
            idCar: controller.selectTypeCar.value.maLoaiXe,
            numberCar: controller.numberCar.text,
            numberCont1: controller.numberCont1.text,
            numberCont2: controller.numberCont2.text,
            numberCont1Seal1: controller.numberCont1Seal1.text,
            numberCont1Seal2: controller.numberCont1Seal2.text,
            numberKhoi: double.parse(controller.numberKhoi.text),
            numberKien: double.parse(controller.numberKien.text),
            typeCont: "${controller.selectTypeCont1.value.typeContCode}",
            numberBook: controller.numberBook.text,
            numberTan: double.parse(controller.numberTan.text),
            numberCont2Seal1: controller.numberCont2Seal1.text,
            numberCont2Seal2: controller.numberCont2Seal2.text,
            numberKhoi1: double.parse(controller.numberKhoi1.text),
            numberKien1: double.parse(controller.numberKien1.text),
            numberBook1: controller.numberBook1.text,
            typeCont1: "${controller.selectTypeCont2.value.typeContCode}",
            idProduct: controller.selectTypeProduct.value.maloaiHang,
            maTrongtai: controller.selectTrongTai.value.maTrongTai,
            numberTan1: double.parse(controller.numberTan1.text),
            numberCont: numberSelectCont,
            nameCustomer: controller.selectCustomer.value.tenKhachhang,
          );
        } else {
          getSnack(messageText: "Chọn loại cont * !");
        }
      } else {
        controller.postRegisterCustomer(
          idTaixe: controller.selectDriver.value.maTaixe,
          maKhachHang: controller.selectCustomer.value.maKhachHang!,
          time: controller.dateinput.text,
          idKho: controller.selectWareHome.value.maKho,
          idCar: controller.selectTypeCar.value.maLoaiXe,
          numberCar: controller.numberCar.text,
          numberCont1: controller.numberCont1.text,
          numberCont2: controller.numberCont2.text,
          numberCont1Seal1: controller.numberCont1Seal1.text,
          numberCont1Seal2: controller.numberCont1Seal2.text,
          numberKhoi: double.parse(controller.numberKhoi.text),
          numberKien: double.parse(controller.numberKien.text),
          numberBook: controller.numberBook.text,
          typeCont: controller.selectTypeCont1.value.typeContCode,
          numberTan: double.parse(controller.numberTan.text),
          numberCont2Seal1: controller.numberCont2Seal1.text,
          numberCont2Seal2: controller.numberCont2Seal2.text,
          numberKhoi1: double.parse(controller.numberKhoi1.text),
          numberKien1: double.parse(controller.numberKien1.text),
          numberBook1: controller.numberBook1.text,
          typeCont1: controller.selectTypeCont2.value.typeContCode,
          numberTan1: double.parse(controller.numberTan1.text),
          idProduct: controller.selectTypeProduct.value.maloaiHang,
          maTrongtai: controller.selectTrongTai.value.maTrongTai,
          numberCont: numberSelectCont,
          nameCustomer: controller.selectCustomer.value.tenKhachhang,
        );
      }
    }
  }

  final List<String> numberCont = ["1", "2"];
  void getSnack({required String messageText}) {
    Get.snackbar(
      "",
      "",
      titleText: const Text(
        "Thông báo",
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
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
