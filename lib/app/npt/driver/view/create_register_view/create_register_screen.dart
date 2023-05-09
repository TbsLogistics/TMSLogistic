// ignore_for_file: unrelated_type_equality_checks

import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:tbs_logistics_tms/app/npt/driver/controller/register_driver_controller.dart';
import 'package:tbs_logistics_tms/app/npt/driver/model/list_customer_for_driver_model.dart';
import 'package:tbs_logistics_tms/app/npt/driver/model/list_total_cont_model.dart';
import 'package:tbs_logistics_tms/app/npt/driver/model/list_type_car.dart';
import 'package:tbs_logistics_tms/app/npt/driver/model/list_type_product_model.dart';
import 'package:tbs_logistics_tms/app/npt/driver/model/list_warehome_model.dart';
import 'package:tbs_logistics_tms/config/core/data/validate.dart';
import 'package:tbs_logistics_tms/config/widget/button_form_submit.dart';
import 'package:tbs_logistics_tms/config/widget/custom_text_form_field.dart';
import 'package:tbs_logistics_tms/config/widget/dropdown_button.dart';

class RegisterFormScreen extends StatefulWidget {
  const RegisterFormScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterFormScreenState createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  final String routes = "/CREATE_REGISTER_DRIVER";
  final formKey = GlobalKey<FormState>();
  var countriesKey = GlobalKey<FindDropdownState>();
  ListCustomerForDriverModel? selectedKhachhang;
  String? idKhachhang;

  String? selectedNumberCont;
  int numberSelectCont = 0;
  String? selectedProduct;
  bool isCheckProduct = false;
  bool isCheckNotProduct = true;

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

    return GetBuilder<RegisterDriverController>(
      init: RegisterDriverController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                size: 25, color: Theme.of(context).primaryColorLight),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Đăng ký phiếu vào',
            style: TextStyle(color: Theme.of(context).primaryColorLight),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 10,
              right: 10,
            ),
            // decoration: const BoxDecoration(gradient: CustomColor.gradient),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  buildDateTime(size, controller),
                  CustomFormFiels(
                    title: "Số xe *",
                    controller: controller.numberCar,
                    hintText: "Nhập số xe",
                    icon: Icons.abc,
                    color: Theme.of(context).primaryColorLight,
                  ),

                  //Danh sách khách hàng
                  _listCustomer(controller),
                  //danh sách kho
                  _listWareHome(controller),
                  //danh sách loại hàng
                  _listTypeProduct(controller),
                  //danh sách loại xe
                  _listTypeCar(controller),
                  Obx(
                    () => controller.selectTypeCar.value != "" &&
                            controller.selectTypeCar.value.maLoaiXe == "tai"
                        ? Column(
                            children: [
                              CustomFormFiels(
                                title: "Số seal",
                                controller: controller.numberCont1Seal1,
                                hintText: "Nhập Số Seal",
                                icon: Icons.abc,
                                color: Theme.of(context).primaryColorLight,
                              ),
                              CustomFormFiels(
                                title: "Số Khối",
                                controller: controller.numberKhoi,
                                hintText: "",
                                icon: Icons.abc,
                                color: Theme.of(context).primaryColorLight,
                              ),
                              CustomFormFiels(
                                title: "Số Kiện",
                                controller: controller.numberKien,
                                hintText: "",
                                icon: Icons.abc,
                                color: Theme.of(context).primaryColorLight,
                              ),
                              CustomFormFiels(
                                title: "Số Book",
                                controller: controller.numberBook,
                                hintText: "Nhập Số Book",
                                icon: Icons.abc,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ],
                          )
                        : controller.selectTypeCar.value != "" &&
                                controller.selectTypeCar.value.maLoaiXe == "con"
                            ? _listNumberCont(controller, size)
                            : Container(),
                  ),
                  numberSelectCont >= 1 ? _contFirt(controller) : Container(),
                  numberSelectCont >= 2 ? _contSecond(controller) : Container(),
                  ButtonFormSubmit(
                      onPressed: () {
                        _signUpProcess(context, controller);
                        // print(numberSelectCont);
                      },
                      text: "Đăng ký")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listNumberCont(RegisterDriverController controller, Size size) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              Text(
                "Số lượng cont *",
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
        Container(
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

  Widget _listCustomer(RegisterDriverController controller) {
    return SizedBox(
      height: 120,
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
          FindDropdown<ListCustomerForDriverModel>(
            showSearchBox: false,
            onFind: (String filter) => controller.getDataCustomer(filter),
            onChanged: (value) {
              controller.selectCustomer.value.maKhachHang = value!.maKhachHang;
              print(controller.selectCustomer.value.maKhachHang);
            },
            dropdownBuilder:
                (BuildContext context, ListCustomerForDriverModel? item) {
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
                ListCustomerForDriverModel item, bool isSelected) {
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

  Widget _listWareHome(RegisterDriverController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Text(
                  "Kho *",
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
          FindDropdown<ListWareHomeModel>(
            showSearchBox: false,
            onFind: (String filter) => controller.getDataWareHome(filter),
            onChanged: (ListWareHomeModel? data) {
              controller.selectWareHome.value.maKho = data!.maKho;
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

  Widget _listTypeProduct(RegisterDriverController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Text(
                  "Loại hàng *",
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

  Widget _listTypeCar(RegisterDriverController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Text(
                  "Loại xe *",
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
          FindDropdown<ListTypeCarModel>(
            validate: (ListTypeCarModel? value) =>
                Validate().selectCustomer(value: value!.tenLoaiXe),
            showSearchBox: false,
            onFind: (String filter) => controller.getDataTypeCar(filter),
            onChanged: (ListTypeCarModel? data) {
              setState(() {
                controller.selectTypeCar.value.maLoaiXe = data!.maLoaiXe;
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

  Widget buildDateTime(Size size, RegisterDriverController controller) {
    return Column(
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
          margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: TextFormField(
            onTap: () {
              _selectDateTime(context);
              showDateTime = true;
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
    );
  }

  Widget _contFirt(RegisterDriverController controller) {
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

  Widget _contSecond(RegisterDriverController controller) {
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

  final List<String> numberCont = ["1", "2"];

  void _signUpProcess(
      BuildContext context, RegisterDriverController controller) {
    if (dateinput.text == "" ||
        controller.numberCar.text == "" ||
        controller.selectCustomer.value == "" ||
        controller.selectWareHome.value == "" ||
        controller.selectTypeProduct.value == "" ||
        controller.selectTypeCar.value == "") {
      getSnack(messageText: "Nhập đầy đủ thông tin *");
    } else {
      if (controller.selectTypeCar.value.maLoaiXe == "con" &&
          numberSelectCont != 0) {
        controller.postRegisterDriver(
          time: dateinput.text,
          idWarehome: controller.selectWareHome.value.maKho,
          idCar: controller.selectTypeCar.value.maLoaiXe,
          numberCar: controller.numberCar.text,
          numberCont1: controller.numberCont1.text,
          numberCont2: controller.numberCont2.text,
          numberCont1Seal1: controller.numberCont1Seal1.text,
          numberCont1Seal2: controller.numberCont1Seal2.text,
          numberKhoi: double.parse(controller.numberKhoi.text),
          numberKien: double.parse(controller.numberKien.text),
          numberBook: controller.numberBook.text,
          numberCont2Seal1: controller.numberCont2Seal1.text,
          numberCont2Seal2: controller.numberCont2Seal2.text,
          numberKhoi1: double.parse(controller.numberKhoi1.text),
          numberKien1: double.parse(controller.numberKien1.text),
          numberBook1: controller.numberBook1.text,
          idProduct: controller.selectTypeProduct.value.maloaiHang,
          maKhachHang: controller.selectCustomer.value.maKhachHang!,
        );
      } else {
        getSnack(messageText: "Nhập số cont *");
      }
    }
  }

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
